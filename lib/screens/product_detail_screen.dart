import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/products_provider.dart';

import '../providers/product.dart';

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
      body: SingleChildScrollView(
        child: Container(
           color: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style:  TextStyle(color: Colors.grey.shade900, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
               
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
