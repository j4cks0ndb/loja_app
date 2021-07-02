import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/cart_manager.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.produto);

  final ProductModel produto;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: produto,
      child: Scaffold(
        appBar: AppBar(
          title: Text(produto.name.toString()),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            CarouselSlider(
              items: produto.images!
                  .map((e) => Container(child: Image.network(e)))
                  .toList(),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 1,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    produto.name.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19,23',
                    style: TextStyle(
                      fontSize: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    produto.description.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: produto.sizes!.map((e) {
                      print(e);
                      return SizeWidget(size: e);
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (produto.hasStock)
                    Consumer2<Usermanager, ProductModel>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedSize != null
                                ? () {
                                    if (userManager.isLoggedIn) {
                                      context.read<CartManager>().addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            child: Text(userManager.isLoggedIn
                                ? 'Adicionar ao Carrinho'
                                : 'Entre para Comprar'),
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
