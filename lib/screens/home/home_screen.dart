import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virutal_app/models/home_manager.dart';
import 'package:loja_virutal_app/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do JDB'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
                      icon: Icon(Icons.shopping_cart))
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __) {
                  final List<Widget> children = homeManager.sections.map<Widget>((section) {
                    switch(section.type){
                      case 'List':
                        return SectionList(section);
                      case 'Staggered':
                        return SectionStaggered(section);
                      default:
                        return Container();
                    }
                  }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(
                        children
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
