import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfavs;

  ProductsGrid(this.showfavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showfavs ? productsData.favoriteItems : productsData.items;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            // create: (c) => products[i],
            // use of changenotifier.value is recommended here to avoid bugs
            child: ProductItem(
                // products[i].id, products[i].title, products[i].imageUrl // earlier method
                //replaced with provider data
                ),
          );
        },
      ),
    );
  }
}
