import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/product_manager.dart';
import 'package:loja_virutal_app/models/section_item_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItemModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>().findProductByID(item.product!);
          Navigator.of(context).pushNamed('/product',arguments: product);
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          image: item.image!,
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
