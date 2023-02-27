import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

class Cart with ChangeNotifier {
   late Map<String, CartItem>  _items;
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items==0 ?0: _items.length;   
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (exisitingCartItem) =>
            CartItem(id: exisitingCartItem.id, price: exisitingCartItem.price, quantity: exisitingCartItem.quantity +1, title: exisitingCartItem.title),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
    }
    
  }
}
