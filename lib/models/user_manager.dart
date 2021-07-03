import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/helpers/firebase_errors.dart';
import 'package:loja_virutal_app/models/user_model.dart';

class Usermanager extends ChangeNotifier{

  Usermanager(){
     _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel? usuario;

  bool _loading=false;
  bool get loading => _loading;
  bool get isLoggedIn => usuario !=null;

  Future<void> signIn({required UserModel usuario, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: usuario.email.toString(), password: usuario.senha.toString());
      print(result.user!.uid);
      //user = result.user;
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    }on FirebaseAuthException
    catch (e){
      onFail(getErrorString(e.code));
    }finally{
      loading = false;
    }

  }

  Future<void> signUp({required UserModel usuario, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: usuario.email.toString(), password: usuario.senha.toString());
      print(result.user!.uid);
      //user = result.user;

      usuario.id = result.user!.uid;

      this.usuario = usuario;

      await usuario.saveData();

      onSuccess();
    }on FirebaseAuthException
    catch (e){
      onFail(getErrorString(e.code));
    }finally{
      loading = false;
    }

  }

  void signOut(){
    auth.signOut();
    usuario = null;
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? await auth.currentUser;
    if(currentUser != null){
      //user = currentUser;
      //print(user!.uid);
      final DocumentSnapshot docUser = await firestore.collection('users').doc(currentUser.uid).get();

      usuario = UserModel.fromDocument(docUser);

      final docAdmin = await firestore.collection('admins').doc(usuario!.id).get();
      if(docAdmin.exists){
        usuario!.admin = true;
      }

      print(usuario!.admin);

      //print(usuario!.name);
      notifyListeners();
    }
  }

  bool get adminEnabled {
    if(usuario != null) {
      return usuario!.admin;
    }else{
      return false;
    }
  }
}