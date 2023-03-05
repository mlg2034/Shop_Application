import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/product.dart';
import 'package:shop_application/widgets/user_product_item.dart';

import '../providers/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName ='/user-products';
  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                    title: productsData.items[index].title,
                    imageUrl: productsData.items[index].imageUrl),
                    Divider()
              ],
            )),
      ),
    );
  }
}
