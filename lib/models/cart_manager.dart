import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/cart_product_model.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/models/user_model.dart';

class CartManager extends ChangeNotifier {
  List<CartProductModel> items = [];

  UserModel? user;

  num productsPrice = 0.0;

  void updateUser(Usermanager userManager) {
    user = userManager.usuario;

    items.clear();
    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user!.cartReference.get();
    items = cartSnap.docs
        .map((e) =>
            CartProductModel.fromDocument(e)..addListener(_onItemUpdated))
        .toList();
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProductModel.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      await user!.cartReference.add(cartProduct.toCartItemMap()).then((value) {
        cartProduct.id = value.id;
      });
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCard(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  Future<void> _updateCartProduct(CartProductModel cartProduct) async {
    if (cartProduct.id != null)
      await user!.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
  }

  Future<void> removeOfCard(CartProductModel cartProduct) async {
    await user!.cartReference.doc(cartProduct.id).delete();
    items.removeWhere((p) => p.id == cartProduct.id);
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
