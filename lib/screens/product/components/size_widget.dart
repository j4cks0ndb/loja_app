import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  SizeWidget({required this.size});


  final ItemSizeModel size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>();
    final selected = size == product.selectedSize;


    Color color;
    if(!size.hasStock) {
      color = Colors.red;
    }
    else if (selected){
      color = Theme.of(context).primaryColor;
    }else{

      color = Colors.grey;
    }

    return InkWell(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      }
      ,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name.toString(),
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price!.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
