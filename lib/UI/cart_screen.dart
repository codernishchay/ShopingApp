import 'package:finall_shop/UI/appBar.dart';
import 'package:finall_shop/providers/item_cart.dart' show Cart;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: appBar('Your Shopping Cart', context),
      //      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),

      // bottom:
      body: cart.itemCount == 0
          ? Container(
              child: Center(
                child: Text('Add Items to your Cart'),
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, i) => CartItem(
                              cart.items.values.toList()[i].id,
                              cart.items.keys.toList()[i],
                              cart.items.values.toList()[i].price,
                              cart.items.values.toList()[i].quantity,
                              cart.items.values.toList()[i].title,
                            ))),
                Card(
                  shadowColor: Colors.black87,
                  elevation: 100,
                  color: Colors.grey,
                  margin: EdgeInsets.all(14),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        Chip(
                          shadowColor: Colors.black12,
                          label: Text(
                            '\u{20B9}${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Colors.white10,
                        ),
                        Spacer(),
                        RaisedButton(
                          elevation: 100,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          onPressed: () {
                            Provider.of<Orders>(context, listen: false)
                                .addOrder(cart.items.values.toList(),
                                    cart.totalAmount);
                            cart.clear();
                          },
                          child: Text(
                            "Order Now",
                            style: TextStyle(fontSize: 25),
                          ),
                          color: Colors.white10,
                          splashColor: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
