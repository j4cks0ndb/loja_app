import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_icon_button.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';


class EditItemSize extends StatelessWidget {
  EditItemSize({Key? key, required this.size, this.onRemove, this.onMoveUp, this.onMoveDown}) : super(key: key);

  final ItemSizeModel size;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            validator: (name){
              if(name!.isEmpty)
                return 'Título inválido';
              return null;
            },
            onChanged: (name) => size.name = name,
            onFieldSubmitted: (name) => size.name = name,
            decoration: InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            validator: (stock){
              if(int.tryParse(stock!) == null)
                return 'Estoque inválido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
            onFieldSubmitted: (stock) => size.stock = int.tryParse(stock),
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            validator: (price){
              if(num.tryParse(price!) == null)
                return 'Preço inválido';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$',
            ),
            onChanged: (price) => size.price = num.tryParse(price),
            onFieldSubmitted: (price) => size.price = num.tryParse(price),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
