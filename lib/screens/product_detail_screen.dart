import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_icon.dart';
import '../models/products.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../models/auth.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetailScreen';
  const ProductDetailScreen({super.key});

  void showImage(ctx, imageUrl) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          content: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments.toString();
    final productData = Provider.of<Products>(context);
    final authData = Provider.of<Auth>(context);
    final product = productData.findById(id);
    final cart = Provider.of<Cart>(context, listen: false);
    return ChangeNotifierProvider.value(
        value: product,
        builder: (context, child) {
          final data = context.watch<Product>();
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
                product.name,
                style: const TextStyle(
                    fontFamily: 'BodoniModa-Italic',
                    fontWeight: FontWeight.normal),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      data.toggleFavStatus(authData.token, authData.userId);
                    },
                    icon: Icon(
                      data.isFav ? Icons.favorite : Icons.favorite_border,
                      color: const Color.fromARGB(255, 221, 133, 96),
                    ),
                  ),
                ),
                const CartIcon(),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showImage(context, data.imageUrl);
                        },
                        child: Container(
                          height:
                              400, //MediaQuery.of(context).size.height * .6,
                          width: 500, // MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(300),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(data.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        left: 10,
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
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
                              '\$${data.price}',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 221, 133, 96),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            cart.addItem(data.id, data.price, data.name);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Added item to cart!',
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  textColor:
                                      const Color.fromARGB(255, 221, 133, 96),
                                  onPressed: () {
                                    cart.removeItem(product.id);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 120,
                            width: 140,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/cart.png'),
                                fit: BoxFit.contain,
                                scale: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BodoniModa-Italic',
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    //height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color.fromARGB(255, 231, 234, 239),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: ReadMoreText(
                        data.description + '\n',
                        trimLines: 2,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show More',
                        trimExpandedText: 'Show Less',
                        lessStyle: const TextStyle(
                          color: Color.fromARGB(255, 221, 133, 96),
                          fontFamily: 'BodoniModa-Italic',
                        ),
                        moreStyle: const TextStyle(
                          color: Color.fromARGB(255, 221, 133, 96),
                          fontFamily: 'BodoniModa-Italic',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
