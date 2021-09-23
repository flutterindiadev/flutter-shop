import 'package:flutshop/Widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import 'package:flutshop/Widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routename = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) {
          return OrderItem(ordersData.orders[i]);
        },
      ),
    );
  }
}
