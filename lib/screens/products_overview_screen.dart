import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/screens/cart_screen.dart';
import 'package:shop_application/widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';
import 'package:shop_application/widgets/product_item.dart';

import '../widgets/product_grid.dart';

enum FillterOptions { Favorites, All }

class ProducOverviewScreen extends StatelessWidget {
  const ProducOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
              onSelected: (selectedValue) {
                if (selectedValue == FillterOptions.Favorites) {
                  productsContainer.showFavoritesOnly();
                } else {
                  productsContainer.showAll();
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FillterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FillterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, label: Text(cart.itemCount.toString())),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer:  AppDrawer(),
        body: ProductGrid());
  }
}
