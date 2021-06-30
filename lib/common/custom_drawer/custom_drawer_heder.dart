import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<Usermanager>(
        builder: (_,userManager,__){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Loja do \n Jack',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Olá, ${userManager.usuario?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  if (userManager.isLoggedIn){
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastra-se',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          );
        },
      )
    );
  }
}
