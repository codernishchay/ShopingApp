import 'package:shopingApp/resources/themes/light_color.dart';
import 'package:shopingApp/ui/widgets/home/cart.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: LightColor.black,
      body: Cart(),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: LightColor.black,
    );
  }
