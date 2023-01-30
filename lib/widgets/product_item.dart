import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Product>(context);
    return GestureDetector(
      onTap: (() => Navigator.pushNamed(
            context,
            ProductDetailScreen.routeName,
            arguments: loadedProduct.id,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: SizedBox(
            height: 40,
            child: GridTileBar(
              backgroundColor: Colors.white.withOpacity(0.9),
              title: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  loadedProduct.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'TenorSans-Regular',
                    fontSize: 12,
                  ),
                ),
              ),
              subtitle: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  '\$${loadedProduct.price.toString()}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'TenorSans-Regular',
                    color: Color.fromARGB(255, 221, 133, 96),
                  ),
                ),
              ),
            ),
          ),
          child: Image.network(
            loadedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
