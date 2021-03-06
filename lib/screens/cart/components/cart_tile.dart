import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_icon_button.dart';
import 'package:loja_virutal_app/models/cart_product_model.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);

  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product!.images!.first),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cartProduct.product!.name.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProductModel>(
                        builder: (_,cartProduct,__){
                          if (cartProduct.hasStock){
                            return Text(
                              'R\$ ${cartProduct.unitPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          }else{
                            return Text(
                              'Sem estoque suficiente',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<CartProductModel>(
                builder: (_, cartProduct, __) {
                  return Column(
                    children: <Widget>[
                      CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: () {
                            cartProduct.increment();
                          }),
                      Text(
                        '${cartProduct.quantity}',
                        style: TextStyle(fontSize: 20),
                      ),
                      CustomIconButton(
                          iconData: Icons.remove,
                          color: cartProduct.quantity! > 1 ? Theme.of(context).primaryColor : Colors.red,
                          onTap: () {
                            cartProduct.decrement() ;
                          }),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
