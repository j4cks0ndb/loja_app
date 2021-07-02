import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/section_model.dart';

class HomeManager extends ChangeNotifier{
  HomeManager(){
    _loadSections();
  }

  List<SectionModel> sections = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async{
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.docs){
       sections.add(SectionModel.fromDocumnet(document));
      }
      notifyListeners();
    });

  }


}