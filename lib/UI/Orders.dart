import 'package:finall_shop/UI/appBar.dart';
import 'package:finall_shop/providers/orders.dart' show Orders;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OrderItem.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: appBar('Your Orders', context),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
      ),
    );
  }
}
