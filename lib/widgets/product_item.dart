import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/providers/product.dart';
import 'package:shop_application/screens/product_detail_screen.dart';

import '../providers/cart.dart';

class ProducItem extends StatelessWidget {
  static const routeName = '/products-overview';
  const ProducItem({super.key});

  // final String id;
  // final String title;
  // final double price;
  // final String imageUrl;
  // const ProducItem(
  //     {super.key,
  //     required this.id,
  //     required this.title,
  //     required this.imageUrl,
  //     required this.price});
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (ctx, product, child) {
            return IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  product.toggleFavoriteStatus();
                });
          }),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).hintColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                  'Added a new Item!',
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    }),
              ));
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProducDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
