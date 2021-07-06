import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/cart_manager.dart';
import 'package:loja_virutal_app/models/product_manager.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/screens/base/base_screen.dart';
import 'package:loja_virutal_app/screens/cart/cart_screen.dart';
import 'package:loja_virutal_app/screens/edit_product/edit_product_sceen.dart';
import 'package:loja_virutal_app/screens/login/login_screen.dart';
import 'package:loja_virutal_app/screens/product/product_screen.dart';
import 'package:loja_virutal_app/screens/products/products_screen.dart';
import 'package:loja_virutal_app/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/admin_users_manager.dart';
import 'models/home_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Usermanager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<Usermanager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<Usermanager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.lightBlue,
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: BaseScreen(),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignupScreen());
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/edit_product':
              return MaterialPageRoute(builder: (_) {
                if (settings.arguments != null) {
                  return EditProductScreen(settings.arguments as ProductModel);
                } else {
                  return EditProductScreen(null);
                }
              });
            case '/product':
              return MaterialPageRoute(
                  builder: (_) =>
                      ProductScreen(settings.arguments as ProductModel));

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
