import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_icon_button.dart';
import 'package:loja_virutal_app/models/item_size_model.dart';
import 'package:loja_virutal_app/models/product_model.dart';

import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {
  SizesForm({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSizeModel>>(
      initialValue:
          product.sizes,
      validator: (sizes) {
        if (sizes!.isEmpty) {
          return 'Insira um tamanho';
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('Tamanhos')),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    state.value!.add(ItemSizeModel());
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            Column(
              children: state.value!.map((size) {
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value!.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: size != state.value!.first
                      ? () {
                          final index = state.value!.indexOf(size);
                          state.value!.remove(size);
                          state.value!.insert(index - 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                  onMoveDown: size != state.value!.last
                      ? () {
                          final index = state.value!.indexOf(size);
                          state.value!.remove(size);
                          state.value!.insert(index + 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
