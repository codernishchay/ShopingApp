import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  @required
  final String id;
  @required
  final String title;
  @required
  final String description;
  @required
  final double price;
  @required
  final double mrp;
  @required
  final String imageUrl;
  @required
  final String catogery;
  @required
  final int stockVal;
  @required
  bool isfavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.mrp,
    this.imageUrl,
    this.isfavorite = false,
    this.catogery,
    this.stockVal,
  });

  Future<void> togglefavoriteStatus(String token) async {
    final oldStatus = isfavorite;

    isfavorite = !isfavorite;
    notifyListeners();
    final url =
        'https://final-shop-6a4ae.firebaseio.com/products/$id.json?auth=$token';
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isfavorite': !isfavorite,
          }));
      if (response.statusCode >= 400) {
        isfavorite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isfavorite = oldStatus;
      notifyListeners();
    }
  }
}
