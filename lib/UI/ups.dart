import 'package:finall_shop/UI/edit_for_add.dart';
import 'package:finall_shop/UI/upi.dart';
import 'package:finall_shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/ups';
  Future<void> _refresh(BuildContext context) async {
    Provider.of<Products>(context).fetchandSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditPeroductScreen.routeName),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(productData.items[i].title,
                    productData.items[i].imageUrl, productData.items[i].id),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
