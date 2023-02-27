import 'package:flutter/material.dart';
import 'package:shop_application/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
   final  productsData= Provider.of<Products>(context);
   final products=productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            // create: (c)=>products[index],
            value: products[index],
            child: ProducItem(
                // id: products[index].id, 
                // title: products[index].title,
                // imageUrl: products[index].imageUrl,
                // price: products[index].price,
                ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 170),
      );
   
  }
}