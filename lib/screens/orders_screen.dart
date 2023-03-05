import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/orders_item.dart';
class OrdersScreen extends StatelessWidget {
  static const routeName ='/orders';
    const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ordersData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your orders'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: AppDrawer(),
      body:ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context , index)=> OrderItem(ordersData.orders[index])
      ) ,
    );
  }
}
