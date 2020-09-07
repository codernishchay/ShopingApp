import 'package:finall_shop/UI/appBar.dart';
import 'package:finall_shop/providers/item_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/ProductItemDetails';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    //  final product = Provider.of<Product>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar('Shopping_world', context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                loadedProduct.title,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                loadedProduct.description,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 10,
              ),
              Text(loadedProduct.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Consumer<Cart>(
                  builder: (context, value, child) => RaisedButton(
                      child: Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      onPressed: () {
                        cart.addItem(loadedProduct.id, loadedProduct.price,
                            loadedProduct.title);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Added Item to Cart',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                          action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                cart.removeSIngleItem(loadedProduct.id);
                              }),
                        ));
                        //padding: EdgeInsets.fromLTRB(100, 0
                      })),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () {},
                //padding: EdgeInsets.fromLTRB(100, 0, 30,0),
                child: Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 20),
                ),
                elevation: 20,
                splashColor: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Product OverView',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
