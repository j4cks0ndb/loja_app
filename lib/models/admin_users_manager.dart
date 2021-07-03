import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/models/user_model.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserModel> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(Usermanager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    /*
    firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((e) => UserModel.fromDocument(e)).toList();
      users.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
    */
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((e) => UserModel.fromDocument(e)).toList();
      users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names {
    if (users != null) {
      return users.map((e) => e.name!.toUpperCase()).toList();
    } else {
      return [];
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
