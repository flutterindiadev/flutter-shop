import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './cart_screen.dart';
import '../Widgets/drawer.dart';
import '../providers/cart.dart';
import '../Widgets/products_grid.dart';
import '../Widgets/badge.dart';

enum FilterOptions { Favorites, All }

class ProductOverview extends StatefulWidget {
  const ProductOverview({Key? key}) : super(key: key);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(child: Text('Show all'), value: FilterOptions.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                child: ch as Widget,
                value: cart.itemCount.toString(),
                color: Theme.of(context).accentColor),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routename);
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
