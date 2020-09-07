import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'data.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: '5c342ac9fc1',
    //   title: "Chromes",
    //   description: "Thi is  very good product",
    //   price: 25,
    //   imageUrl:
    //       "https://cdn.pixabay.com/photo/2019/12/05/19/28/clip-art-4675943_960_720.png",
    //   isfavorite: false,
    // ),
    // Product(
    //   id: '5c342ac9fc2',
    //   title: "Combs",
    //   description: "Thi is  very good product",
    //   price: 25,
    //   imageUrl:
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTsQtW_YJtZBMpCDlC5Osym7SBgOdWMvCT7PA&usqp=CAU",
    //   isfavorite: false,
    // ),
    // Product(
    //   id: '5c342ac9fc3',
    //   title: "AIr ConditionAL",
    //   description: "Thi is  very good product",
    //   price: 25,
    //   imageUrl:
    //       "https://clipartstation.com/wp-content/uploads/2017/11/eule-clipart-5.jpg",
    //   isfavorite: false,
    // ),
  ];
  final String authToken;

  Products(this.authToken);

  //Products(this.authToken, this._items);
  void deleteProduct(String id) async {
    final url =
        'https://final-shop-6a4ae.firebaseio.com/products/$id.json?auth=$authToken';
    var existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);

    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete Product');
    }
    existingProduct = null;
  }

  Future<void> addProducts(Product product) async {
    print('what happend bro');
    final url =
        'https://final-shop-6a4ae.firebaseio.com/products.json?auth=$authToken';

    try {
      await http
          .post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'mrp': product.mrp,
          'isfavorite': product.isfavorite,
          'stockVal': product.stockVal,
          'catogery': product.catogery,
          'isFavorite': product.isfavorite,
        }),
      )
          .then((response) {
        print('what the fuck');
        print(response.body);

        final newProduct = Product(
            title: product.title,
            description: product.description,
            imageUrl: product.imageUrl,
            price: product.price,
            mrp: product.mrp,
            isfavorite: product.isfavorite,
            catogery: product.catogery,
            stockVal: product.stockVal,
            id: json.decode(response.body)['name']);

        _items.add(newProduct);
      });
      //
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> fetchandSetProducts() async {
    final url =
        'https://final-shop-6a4ae.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((id, prodData) {
        loadedProducts.add(Product(
          id: id,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          mrp: prodData['mrp'],
          isfavorite: prodData['isfavorite'],
          catogery: prodData['catogery'],
          stockVal: prodData['stockVal'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> fetchProducts() async {
    final url = 'https://final-shop-6a4ae.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      print('im working properly');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((id, prodData) {
        loadedProducts.add(Product(
          id: id,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          mrp: prodData['mrp'],
          isfavorite: prodData['isfavorite'],
          catogery: prodData['catogery'],
          stockVal: prodData['stockVal'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      print('im working properly');
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://final-shop-6a4ae.firebaseio.com/products/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              //'mrp': product.mrp,
              'isfavorite': product.isfavorite,
              'stockVal': product.stockVal,
              'catogery': product.catogery,
              'isFavorite': product.isfavorite,
            }));

        //   .then((response) {
        // final newProduct = Product(
        //     title: product.title,
        //     description: product.description,
        //     imageUrl: product.imageUrl,
        //     price: product.price,
        //     mrp: product.mrp,
        //     isfavorite: product.isfavorite,
        //     catogery: product.catogery,
        //     stockVal: product.stockVal,
        //     id: json.decode(response.body)['name']);

        _items[prodIndex] = product;
        //
        notifyListeners();
      } catch (e) {
        print(e);
        throw (e);
      }
    }
  }
  // void updateProduct(String id, Product newProduct) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('....');
  //   }
  // }

  // void addProduct() {
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // var showfavoritesOnly = false;

  // void showfavoriteOnly() {
  //   showfavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showfavoritesOnly = false;
  //   notifyListeners();
  // }
  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isfavorite).toList();
  }

  List<Product> get items {
    //   if (showfavoritesOnly) {
    //     return _items.where((prodItem) => prodItem.isfavorite).toList();
    //   }
    return [..._items];
  }

  // Future<void> update(Products proddata) async {
  //   final url = 'https://final-shop-6a4ae.firebaseio.com/products.json';
  //   a
  // }
}
