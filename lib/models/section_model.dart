import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virutal_app/models/section_item_model.dart';

class SectionModel{
  SectionModel.fromDocumnet(DocumentSnapshot document){
    name = document['name'] as String;
    type = document['type'] as String;
    items = (document['items'] as List).map((e) => SectionItemModel.fromMap(e as Map<String,dynamic>)).toList();
  }

  String? name;
  String? type;

  List<SectionItemModel> items = [];

  @override
  String toString() {
    return 'SectionModel{name: $name, type: $type, items: $items}';
  }
}