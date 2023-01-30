import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_products_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  const UserProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetData(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: null);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        color: const Color.fromARGB(255, 221, 133, 96),
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserProductItem(
                    productsData.items[i].id,
                    productsData.items[i].name,
                    productsData.items[i].imageUrl,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
