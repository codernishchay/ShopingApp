import 'package:finall_shop/UI/Catogeries.dart';
import 'package:finall_shop/UI/Orders.dart';
import 'package:finall_shop/UI/ProductItemDetails.dart';
import 'package:finall_shop/UI/UserProdile.dart';
import 'package:finall_shop/UI/cart_screen.dart';

import 'package:finall_shop/UI/edit_for_add.dart';
//import 'package:finall_shop/UI/favorites.dart';
import 'package:finall_shop/UI/favourites.dart';
import 'package:finall_shop/UI/homePage.dart';
import 'package:finall_shop/UI/ups.dart';
import 'package:finall_shop/auth/auth_screen.dart';
import 'package:finall_shop/providers/auth_.dart';
import 'package:finall_shop/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';
import 'UI/ProductItemDetails.dart';
import 'providers/item_cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth_data()),
          // ChangeNotifierProxyProvider<Auth_data, Products>(
          //   create: (_) => Products(),
          //   update: (ctx, auth, previousProducts) =>
          //       previousProducts..fetchandSetProducts(),
          // ),

          ChangeNotifierProvider(
              create: (_) => Products(Provider.of<Auth_data>(context).token,
                  Provider.of<Products>(context).items)),
          ProxyProvider<Auth_data, Products>(
            update: (context, auth, previousProdData) => Products(auth.token,
                previousProdData == null ? [] : previousProdData.items),
          ),

          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(create: (ctx) => Orders()),
          ChangeNotifierProvider.value(
            value: Auth_data(),
          )
        ],
        child: Consumer<Auth_data>(
            builder: (context, auth, _) => MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      primaryColorDark: Colors.black12,
                      iconTheme: IconThemeData(color: Colors.grey),
                      dividerColor: Colors.black26,
                      applyElevationOverlayColor: true,
                      indicatorColor: Colors.black,
                      cursorColor: Colors.grey,
                      backgroundColor: Colors.white,
                      accentColor: Colors.white,
                      //buttonColor: Colors.black,
                      primaryIconTheme: Theme.of(context).accentIconTheme,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: auth.isAuth ? ProductOverview() : AuthScreen(),
                    routes: {
                      ProductDetails.routeName: (context) => ProductDetails(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      UserProductScreen.routeName: (ctx) => UserProductScreen(),
                      OrdersScreen.routeName: (context) => OrdersScreen(),
                      EditPeroductScreen.routeName: (context) =>
                          EditPeroductScreen(),
                      UserProfile.routeName: (context) => UserProfile(),
                      Favorites.routeName: (context) => Favorites(),
                      Catrogeries.routeName: (context) => Catrogeries(),
                      //    SignInPage.routeName: (context) => SignInPage(),
                      //  SplashScreen.routeName: (context) => SplashScreen(),
                      // SignUpScreen.routeName: (context) => SignUpScreen(),
                    })));
  }
}
