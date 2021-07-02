import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';
import 'package:loja_virutal_app/models/product_model.dart';

class CartProductModel extends ChangeNotifier {
  CartProductModel.fromProduct(this.product) {
    productId = product!.id!;
    quantity = 1;
    size = product!.selectedSize!.name!;
  }

  CartProductModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;
    firestore.doc('products/$productId').get().then((value) {
      product = ProductModel.fromDocument(value);
      notifyListeners();
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;

  String? productId;
  int? quantity;
  String? size;

  ProductModel? product;

  ItemSizeModel? get itemSize {
    if (product == null) return null;
    return product!.findSize(size!);
  }

  num? get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(ProductModel product) {
    return product.id == productId && product.selectedSize!.name == size;
  }

  void increment() {
    var aux = quantity ?? 0;
    if (aux > 0) {
      quantity = aux + 1;
      notifyListeners();
    }
  }

  void decrement() {
    var aux = quantity ?? 0;
    if (aux > 0) {
      quantity = aux - 1;
      notifyListeners();
    }
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock! >= quantity!;
  }

  num get totalPrice => unitPrice! * quantity!;
}
