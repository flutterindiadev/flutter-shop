import 'package:flutshop/Screens/manage_products_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'FlutShop',
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.money),
              title: Text('Your Orders'),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routename);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context).pushNamed(ManageProductsScreen.routename);
              },
            ),
          )
        ],
      ),
    );
  }
}
