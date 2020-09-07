import 'package:finall_shop/UI/edit_for_add.dart';
import 'package:finall_shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  UserProductItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditPeroductScreen.routeName, arguments: id),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
