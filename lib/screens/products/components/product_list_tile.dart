import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/product_model.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile(this.product);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/product',arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images!.first),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Text(
                      'R\$ 10,96',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
