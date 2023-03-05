import 'package:flutter/material.dart';
import 'package:shop_application/screens/orders_screen.dart';
import 'package:shop_application/screens/user_products_screen.dart';

import '../screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Askhat!'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.shop_2_outlined),
              title: const Text('shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Manage Products'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
              }),
        ],
      ),
    );
  }
}
