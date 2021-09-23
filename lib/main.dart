import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/edit_product_screen.dart';
import './Screens/manage_products_screen.dart';
import '/Screens/product_overview_screen.dart';
import '/Screens/product_detail_screen.dart';
import './Screens/orders_screen.dart';
import '/Screens/cart_screen.dart';
import '/providers/products_provider.dart';
import '/providers/cart.dart';
import './providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverview(),
        routes: {
          ProductDetailSreen.routeName: (ctx) => ProductDetailSreen(),
          CartScreen.routename: (ctx) => CartScreen(),
          OrdersScreen.routename: (ctx) => OrdersScreen(),
          ManageProductsScreen.routename: (ctx) => ManageProductsScreen(),
          EditProductScreen.routename: (ctx) => EditProductScreen()
        },
      ),
    );
  }
}
