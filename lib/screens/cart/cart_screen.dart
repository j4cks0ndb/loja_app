import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/price_card.dart';
import 'package:loja_virutal_app/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: <Widget>[
              Column(
                children: cartManager.items.map((e) => CartTile(e)).toList(),
              ),
              PriceCard(
                onPressed: cartManager.isCartValid ? () {

                } : null,
                buttonText: 'Continuar para Entrega',
              ),
            ],
          );
        },
      ),
    );
  }
}
