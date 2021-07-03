import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer_heder.dart';
import 'package:loja_virutal_app/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        ListView(
          children: <Widget>[
            CustomDrawerHeader(),
            const Divider(),
            DrawerTile(
              iconData: Icons.home,
              title: 'Inicio',
              page: 0,
            ),
            DrawerTile(
              iconData: Icons.list,
              title: 'Produtos',
              page: 1,
            ),
            DrawerTile(
              iconData: Icons.playlist_add_check,
              title: 'Meus Pedidos',
              page: 2,
            ),
            DrawerTile(
              iconData: Icons.location_on,
              title: 'Lojas',
              page: 3,
            ),
            Consumer<Usermanager>(
              builder: (_,userManager,__){
                if(userManager.adminEnabled){
                  return Column(
                    children: <Widget>[
                      Divider(),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Usuários',
                        page: 4,
                      ),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Pedidos',
                        page: 5,
                      ),
                    ],
                  );
                }else{
                  return Container();
                }
              },
            )
          ],
        ),
      ]),
    );
  }
}
