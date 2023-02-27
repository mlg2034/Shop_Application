import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/products_provider.dart';
import 'package:shop_application/screens/product_detail_screen.dart';
import 'package:shop_application/screens/products_overview_screen.dart';
import 'package:shop_application/providers/cart.dart';

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
          ChangeNotifierProvider.value(
            value: Products(),
          ),
        ],
        child: ChangeNotifierProvider.value(
          value: Cart(),
          child: MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primaryColor: Colors.purple,
                hintColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: ProducOverviewScreen(),
            routes: {
              ProducDetailScreen.routeName: (ctx) => ProducDetailScreen(),
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
