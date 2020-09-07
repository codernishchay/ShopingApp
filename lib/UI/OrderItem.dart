import 'package:flutter/material.dart';
import 'dart:math';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

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
            title: Text('\u{20B9}${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd-MM-yyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                size: 40,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                height: min(widget.order.products.length * 20.0 + 50, 180),
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: widget.order.products
                      .map(
                        (prod) => Row(
                          children: [
                            Text(prod.title),
                            Spacer(),
                            Text(
                              '\u{20B9}${prod.price}*${prod.quantity}',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ))
        ],
      ),
    );
  }
}
