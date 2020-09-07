import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};
  Map<String, CartItem> get items {
    return {..._item};
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _item.remove(id);
    notifyListeners();
  }

  void addItem(String id, double price, String title) {
    if (_item.containsKey(id)) {
      _item.update(
          id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _item.putIfAbsent(
        id,
        () => CartItem(
          id: DateTime.now().toIso8601String(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  int get itemCount {
    return _item.length;
  }

  void clear() {
    _item = {};
    notifyListeners();
  }

  void removeSIngleItem(String id) {
    if (!_item.containsKey(id)) {
      return;
    }
    if (_item[id].quantity > 1) {
      _item.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    } else {
      _item.remove(id);
    }
    notifyListeners();
  }
}
