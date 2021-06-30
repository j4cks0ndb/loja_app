import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virutal_app/models/page_manager.dart';
import 'package:loja_virutal_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_)=>PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          //LoginScreen(),
          Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            drawer: CustomDrawer(),
          ),
          Container(
            color: Colors.green,

          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
