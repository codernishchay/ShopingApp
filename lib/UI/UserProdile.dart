import 'package:finall_shop/UI/appBar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Your Account', context),
    );
  }
}
