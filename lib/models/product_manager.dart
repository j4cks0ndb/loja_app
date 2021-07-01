import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/product_model.dart';

class ProductManager extends ChangeNotifier{

  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> allProducts = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    final List<ProductModel> filteredProducts = [];
    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    }else{
      filteredProducts.addAll(
        allProducts.where((p) => p.name!.toLowerCase().contains(search.toLowerCase()))
      );
    }
    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
    await firestore.collection('products').get();

    allProducts = snapProducts.docs.map(
            (e) => ProductModel.fromDocument(e)).toList();

    notifyListeners();

  }
}
