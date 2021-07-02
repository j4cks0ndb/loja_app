import 'package:flutter/material.dart';
import 'package:loja_virutal_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virutal_app/models/product_manager.dart';
import 'package:loja_virutal_app/screens/products/components/product_list_tile.dart';
import 'package:loja_virutal_app/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context, builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: Container(
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                    ),
                    width: constraints.biggest.width,
                  ),
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context, builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    icon: Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () async {
                      productManager.search = '';
                    },
                    icon: Icon(Icons.close));
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: ProductListTile(filteredProducts[index]),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
