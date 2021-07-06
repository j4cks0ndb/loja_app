import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';

class ProductModel extends ChangeNotifier{

  ProductModel({this.id,this.name,this.description,this.images,this.sizes}){
    images = images ?? [];
    sizes = sizes ?? [];
  }


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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSizeModel>? sizes;

  List<dynamic>? newImages;

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

  num? get basePrice{
    num lowest = double.infinity;
    for (final size in sizes!){
      if(size.price! < lowest && size.hasStock)
        lowest = size.price!;
    }
    return lowest;
  }

  ProductModel clone(){
    return ProductModel(
      id :id,
      name: name,
      description : description,
      images: List.from(images as List<String>),
      sizes: sizes!.map((size) => size.clone()).toList()
    );
  }

  List<Map<String,dynamic>> exportSizeList(){
    return sizes!.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    final Map<String,dynamic> data = {
      'name': name,
      'description' : description,
      'sizes': exportSizeList(),
    };

    if(id ==null){
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    }else{
      await firestoreRef.update(data);
    }
  }


}