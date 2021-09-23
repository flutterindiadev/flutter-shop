import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/drawer.dart';
import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../Widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routename = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                  ),
                  Spacer(),

                  //Total  cart value
                  Chip(
                    label: Text(
                      '₹ ${cart.cartTotal.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),

                  //Order now button
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.cartTotal);
                        cart.clear();
                      },
                      child: Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                  price: cart.items.values.toList()[i].price,
                  productId: cart.items.keys.toList()[i],
                  quantity: cart.items.values.toList()[i].quantity,
                  title: cart.items.values.toList()[i].title,
                  id: cart.items.values.toList()[i].id),
            ),
          ),
        ],
      ),
    );
  }
}
