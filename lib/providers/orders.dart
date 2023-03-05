import 'package:flutter/material.dart';

import 'cart.dart';

class OrdersItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrdersItem({
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.id,
  });
}

class Orders with ChangeNotifier {
  List<OrdersItem> _orders = [];
  List<OrdersItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrdersItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}
