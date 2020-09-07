import 'package:finall_shop/UI/Catogeries.dart';
import 'package:finall_shop/UI/ups.dart';
import 'package:flutter/material.dart';
//import 'OrderItem.dart';
import 'Orders.dart';
//import 'Orders.dart';

// ignore: camel_case_types
class Drawer_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'This is me',
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: Title(
              color: Colors.black,
              child: Text(
                'Hello there',
                style: TextStyle(color: Colors.black),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 150,
            child: FittedBox(
              fit: BoxFit.cover,
              child: CircleAvatar(
                foregroundColor: Colors.red,
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ),
          ListTile(
            title: Text('Your Profile'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            hoverColor: Colors.purple,
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Your Orders'),
            hoverColor: Colors.purple,
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Catogeries"),
            onTap: () => Navigator.of(context).pushNamed(Catrogeries.routeName),
            leading: Icon(Icons.category),
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue),
            title: Text('Add Your Product'),
            hoverColor: Colors.purple,
            onTap: () {
              Navigator.of(context).pushNamed(
                UserProductScreen.routeName,
              );
              // Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.monochrome_photos),
            title: Text('Switch to Dark Mode'),
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
