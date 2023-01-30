import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                },
                color: const Color.fromARGB(255, 221, 133, 96),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                },
                color: const Color.fromARGB(255, 221, 133, 96),
              ),
            ],
          ),
        ));
  }
}
