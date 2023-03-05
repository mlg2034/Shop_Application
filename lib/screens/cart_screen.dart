import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/cart.dart' show Cart;
import 'package:shop_application/providers/orders.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false)
                        .addOrder(cart.items.values.toList(), cart.totalAmount);
                    cart.clear();
                  },
                  child: Text(
                    'ORDER NOW',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context, index) {
              return ci.CartItem(
                id: cart.items.values.toList()[index].id,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title,
                productId: cart.items.keys.toList()[index],
              );
            },
          ),
        )
      ]),
    );
  }
}
