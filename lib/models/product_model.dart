import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';

class ProductModel extends ChangeNotifier{


  ProductModel.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);

    try{
      sizes = (document['sizes'] as List<dynamic>).map((e) =>
          ItemSizeModel.fromMap(e as Map<String, dynamic>)).toList();
    }catch (e){
      sizes = [];
    }

  }

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSizeModel>? sizes;

  ItemSizeModel? _selectedSize ;

  ItemSizeModel? get selectedSize => _selectedSize;

  set selectedSize(ItemSizeModel? value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes!){
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  ItemSizeModel? findSize(String name){
    try {
      return sizes!.firstWhere((s) => s.name == name);
    }catch (e){
      return null;
    }
  }


}