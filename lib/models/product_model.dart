import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';
import 'package:uuid/uuid.dart';

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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');
  Reference get storageRef => storage.ref().child('products').child(id.toString());

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSizeModel>? sizes;

  List<dynamic>? newImages;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

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
    _loading = true;
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

    //IMAGES[URL1,URL2,URL3]
    //NEWIMAGES[URL3,FILE1]
    //MANDA FILE1 PRO STORAGE -> FURL1
    //UPDATE[URL3,FURL1]
    //EXCLUIR URL1, URL2 STORAGE
    final List<String> updateImages = [];
    for(final newImage in newImages!){
      if(images!.contains(newImage)){
        updateImages.add(newImage as String);
      }else{
        final UploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        String url = snapshot.ref.getDownloadURL().toString();
        updateImages.add(url);
      }
    }

    for(final image in images!){
      if(!newImages!.contains(images)){
        try {
          final ref = await storage.refFromURL(image);
          await ref.delete();
        }catch(e){
          debugPrint('Falha ao deletear $image');
        }
      }
    }
    
    await firestoreRef.update({'images': updateImages});

    images = updateImages;

    _loading = false;
  }


}