import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virutal_app/models/page_manager.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/screens/admin_users/admin_users_screen.dart';
import 'package:loja_virutal_app/screens/home/home_screen.dart';
import 'package:loja_virutal_app/screens/login/login_screen.dart';
import 'package:loja_virutal_app/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_)=>PageManager(pageController),
      child: Consumer<Usermanager>(
        builder: (_,userManager,__){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              //LoginScreen(),
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: Text('Home3'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: Text('Home4'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                AdminUsersScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: Text('Pedidos'),
                    ),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
