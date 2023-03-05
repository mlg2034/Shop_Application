import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/orders.dart';
import 'package:shop_application/providers/products_provider.dart';
import 'package:shop_application/screens/cart_screen.dart';
import 'package:shop_application/screens/orders_screen.dart';
import 'package:shop_application/screens/product_detail_screen.dart';
import 'package:shop_application/screens/products_overview_screen.dart';
import 'package:shop_application/providers/cart.dart';
import 'package:shop_application/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return Products();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (ctx) => Cart(),
          child: MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primaryColor: Colors.red,
                hintColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: ProducOverviewScreen(),
            routes: {
              ProducDetailScreen.routeName: (ctx) => ProducDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName:(ctx) => OrdersScreen(), 
              UserProductScreen.routeName:(ctx)=>UserProductScreen(),
            },
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyShop')),
    );
  }
}
