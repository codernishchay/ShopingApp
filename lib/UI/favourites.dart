import 'package:finall_shop/UI/ProductGrid.dart';
import 'package:finall_shop/UI/appBar.dart';
import 'package:flutter/material.dart';

enum FilterOptions {
  favorites,
  All,
}

class Favorites extends StatelessWidget {
  static const routeName = '/favorites';
  final showFavs = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('favorites', context),
      body: ProductsGrid(showFavs),
    );
  }
}

// PopupMenuButton(
//   onSelected: (FilterOptions selecterValue) {
//     setState(() {
//       if (selecterValue == FilterOptions.All) {
//         // productContainer.showAll();
//         _showOnlyfavorites = false;
//       } else if (selecterValue == FilterOptions.favorites) {
//         // productContainer.showfavoriteOnly();
//         _showOnlyfavorites = true;
//       }
//     });
//   },
//   icon: Icon(Icons.more_vert),
//   itemBuilder: (context) => [
//     PopupMenuItem(
//       child: Text("Only favorites"),
//       value: FilterOptions.favorites,
//     ),
//     PopupMenuItem(
//       child: Text("Show all"),
//       value: FilterOptions.All,
//     ),
//   ],
// ),
