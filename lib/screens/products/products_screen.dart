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
        title: const Text('Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final search = await showDialog<String>(context: context,
                    builder: (_) => SearchDialog()
                );
                if(search != null){
                  context.read<ProductManager>().search = search;
                }
              },
              icon: Icon(Icons.search)),
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
    );
  }
}
