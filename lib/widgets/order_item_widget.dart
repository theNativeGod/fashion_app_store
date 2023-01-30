import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/orders.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;
  const OrderItemWidget(this.order, {super.key});

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.only(
                bottom: 25,
              ),
              height: min(widget.order.products.length * 20.0 + 45.0, 100.0),
              child: ListView(
                children: [
                  ...widget.order.products
                      .map(
                        (prod) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                prod.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
