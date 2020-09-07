import 'package:finall_shop/UI/ProductItemDetails.dart';
import 'package:finall_shop/providers/auth_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finall_shop/providers/data.dart';

class ItemView extends StatelessWidget {
  // ItemView(this.id, this.title, this.description, this.price, this.imageUrl);
  //We can do it by just wrapping the changable widget to the Consumer widget.. it
  //acts as a listner and only reruns that part
  //Conusmer can be used insted of the provider here!
  // .value can also be used instead of builder everywhere... better is to use builder or create..  @override

  Widget build(BuildContext context) {
    // Provider.of<Products>(context, listen: false);
    //  final cart = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context);
    final authData = Provider.of<Auth_data>(context);
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(11.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                icon: Icon(product.isfavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.togglefavoriteStatus(authData.token);
                }),
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
