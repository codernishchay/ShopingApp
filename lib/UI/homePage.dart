import 'package:finall_shop/UI/ProductGrid.dart';
import 'package:finall_shop/UI/appBar.dart';
import 'package:finall_shop/UI/drawer.dart';
import 'package:finall_shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorites,
  All,
}

class ProductOverview extends StatefulWidget {
  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _isInit = true;
  var isLoading = false;
  var _showOnlyfavorites = false;

  Future<void> _refresh(BuildContext context) async {
    Provider.of<Products>(context).fetchandSetProducts();
  }

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      //isLoading = true;
      Provider.of<Products>(context)
          .fetchandSetProducts()
          .then((value) => setState(() {
                isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: appBar('Shopping App', context),
      drawer: Drawer_(),
      body: isLoading
          ? Container(
              child: RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : ProductsGrid(_showOnlyfavorites),
    );
  }
}
