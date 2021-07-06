import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virutal_app/models/product_manager.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:loja_virutal_app/screens/edit_product/components/images_form.dart';
import 'package:provider/provider.dart';

import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(ProductModel? p):
        editing = p != null ? true : false,
        product = p != null ? p.clone() : ProductModel();

  final ProductModel product;

  final bool editing ;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        //drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            editing ? 'Editar Produto' : 'Inserir Produto' ,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(product),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey
                        )
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      validator: (name){
                        if(name!.length < 3){
                          return 'Título muito curto';
                        }
                        return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 0),
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
                      'R\$ ${product.basePrice!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 0),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      decoration: InputDecoration(
                          hintText: 'Descrição',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey
                          )
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      validator: (description){
                        if(description!.length < 6){
                          return 'Descrição muito curta';
                        }
                        return null;
                      },
                      onSaved: (description) => product.description = description,
                    ),
                    SizesForm(product: product),
                    SizedBox(height: 20,),
                    Consumer<ProductModel>(builder: (_,product,__){
                      return SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5);
                                else if (states.contains(MaterialState.disabled))
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(100);
                                return Theme.of(context)
                                    .colorScheme
                                    .primary; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: !product.loading ? () async {
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                             await product.save();
                             context.read<ProductManager>().update(product);
                             Navigator.of(context).pop();
                            }
                          } : null,
                          child: !product.loading ?
                            CircularProgressIndicator()
                          : Text('Salvar'),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
