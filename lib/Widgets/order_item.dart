import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutshop/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
                'Total Amount : ₹ ${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20 + 30, 180),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: widget.order.products
                      .map(
                        (prod) => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${prod.quantity}x ₹ ${prod.price}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
