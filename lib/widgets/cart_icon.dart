import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../models/cart.dart';
import '../screens/cart_screen.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            value: cart.itemCount.toString(),
            color: const Color.fromARGB(255, 221, 133, 96),
            child: ch!,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart,
                size: 24, color: Color.fromARGB(190, 51, 51, 51)),
          ),
        ));
  }
}
