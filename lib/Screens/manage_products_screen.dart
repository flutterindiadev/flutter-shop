import 'package:flutshop/Screens/edit_product_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutshop/providers/products_provider.dart';
import 'package:flutshop/Widgets/manage_products.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routename = '/manage-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routename);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) {
            return ManageProducts(
                id: productData.items[i].id,
                title: productData.items[i].title,
                imageUrl: productData.items[i].imageUrl);
          },
        ),
      ),
    );
  }
}
