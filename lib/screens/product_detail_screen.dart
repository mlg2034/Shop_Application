import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/products_provider.dart';

class ProducDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // const ProducDetailScreen({super.key, required this.title, required this.price});

  static const routeName = '/product-detail';

  const ProducDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
