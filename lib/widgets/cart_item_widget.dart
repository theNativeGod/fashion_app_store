import 'package:readmore/readmore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CartItem>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(cartItem.id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are You Sure'),
            content:
                const Text('Do You Want To Remove This Item From The Cart? '),
            actions: [
              TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 221, 133, 96),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 221, 133, 96),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: ((direction) {
        var _prodId;
        for (var i in cart.items.keys) {
          if (cart.items[i] == cartItem) {
            _prodId = i;
          }
        }
        cart.deleteItem(_prodId);
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 50,
                    // width: MediaQuery.of(context).size.width * ,
                    decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          blurRadius: 1.5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color.fromARGB(255, 221, 133, 96),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        '\$${cartItem.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 221, 133, 96),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: ReadMoreText(
                      cartItem.title,
                      trimLines: 1,
                      trimMode: TrimMode.Line,
                      style: const TextStyle(
                          fontFamily: 'BodoniModa-Italic', fontSize: 15),
                    ),
                  ),
                  _adjustQuantity(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _adjustQuantity(BuildContext ctx) {
    final cart = Provider.of<Cart>(ctx);
    final cartItem = Provider.of<CartItem>(ctx);
    return Container(
      width: MediaQuery.of(ctx).size.width * .31,
      //padding: EdgeInsets.only(right: ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              var _prodId;
              for (var i in cart.items.keys) {
                if (cart.items[i] == cartItem) {
                  _prodId = i;
                }
              }
              cart.removeItem(
                _prodId,
              );
            },
            icon: const Icon(Icons.remove),
            color: const Color.fromARGB(255, 221, 133, 96),
          ),
          FittedBox(
            child: Text(
              cartItem.quantity.toString(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              var _prodId;
              for (var i in cart.items.keys) {
                if (cart.items[i] == cartItem) {
                  _prodId = i;
                }
              }
              cart.addItem(
                _prodId,
                cartItem.price,
                cartItem.title,
              );
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 221, 133, 96),
            ),
          ),
        ],
      ),
    );
  }
}
