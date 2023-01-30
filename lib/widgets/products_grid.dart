import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/products.dart';
import '../models/product.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final String? tp;
  final String? colxn;
  const ProductsGrid({required this.tp, required this.colxn, super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products = productsData.items
        .where((element) => element.type == tp && element.collection == colxn)
        .toList();
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        return Container(
          child: ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(),
          ),
        );
      },
    );
  }
}
