import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  //UserModel({this.id = '', this.email = '',this.senha = '', this.name = '', this.confirmSenha = ''});
  UserModel({this.id, this.email,this.senha, this.name, this.confirmSenha});
  //UserModel(this.id, this.email,this.senha, this.name , this.confirmSenha);

  UserModel.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
  }

  String? id;
  String? name;
  String? email;
  String? senha;

  String? confirmSenha;

  bool admin = false;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    //await FirebaseFirestore.instance.collection('users').doc(id).set(toMap());
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
    };
  }
}