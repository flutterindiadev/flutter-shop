import 'package:flutshop/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/product_detail_screen.dart';
import 'package:flutshop/providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  //all details above will be provider here by provider

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailSreen.routeName, arguments: product.id),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                  //using consumer helps optimisation

                  onPressed: () {
                    product.toggleFavorite();
                  },
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).accentColor),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added item to cart!',
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
