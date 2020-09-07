import 'package:finall_shop/UI/badge.dart';
import 'package:finall_shop/UI/cart_screen.dart';
import 'package:finall_shop/UI/favourites.dart';
import 'package:finall_shop/providers/item_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appBar(String text, BuildContext context) {
  return AppBar(
    //  automaticallyImplyLeading: false,
    // toolbarOpacity: 3.3,
    backgroundColor: Colors.white,
    iconTheme: new IconThemeData(color: Colors.black),
    elevation: 500,
    bottom: PreferredSize(
      child: new Container(
        height: 50.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow: [new BoxShadow(blurRadius: 0)],
          borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 100)),
        ),
      ),
      preferredSize: Size.fromHeight(50),
    ),

    title: Text(
      text,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          color: Colors.black),
    ),
    centerTitle: false,
    actions: [
      SizedBox(
          //width: 50,
          ),
      Consumer<Cart>(
        builder: (_, cart, ch) => Badge(
          child: ch,
          value: cart.itemCount.toString(),
        ),
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
        ),
      ),
      IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(Favorites.routeName)),
      // backgroundColor: AppTheme.mainThemeColor(),
    ],
    brightness: Brightness.dark,
  );
}
