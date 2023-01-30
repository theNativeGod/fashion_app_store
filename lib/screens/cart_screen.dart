import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/orders.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 239),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30,
              color: Color.fromARGB(190, 51, 51, 51),
            ),
          ),
        ),
        title: Text(
          'Your Cart',
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                )
              ],
            ),
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Chip(
                    backgroundColor: const Color.fromARGB(255, 224, 232, 239),
                    label: Text(
                      cart.totalAmount.toStringAsFixed(2),
                    ),
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .7,
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) {
                return ChangeNotifierProvider.value(
                  value: cart.items.values.toList()[i],
                  child: const CartItemWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      style: TextButton.styleFrom(
        alignment: Alignment.centerRight,
        foregroundColor: const Color.fromARGB(255, 221, 133, 96),
        padding: const EdgeInsets.only(left: 10, right: 0),
      ),
      child: _isLoading
          ? CircularProgressIndicator(
              color: const Color.fromARGB(255, 221, 133, 96),
            )
          : Text('ORDER NOW'),
    );
  }
}
