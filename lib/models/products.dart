import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: '101',
    //     name: "Basic T-Shirt",
    //     price: 19.99,
    //     imageUrl:
    //         "https://images.unsplash.com/photo-1628730992773-5185cc8efca9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80",
    //     description:
    //         "A simple and comfortable t-shirt made from 100% cotton. Available in sizes S-XL.",
    //     type: "Apparel",
    //     collection: "Summer"),
    // Product(
    //     id: '102',
    //     name: "Hooded Sweatshirt",
    //     price: 34.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2019/01/30/10/27/girl-3964269_960_720.jpg",
    //     description:
    //         "A classic sweatshirt with a hood, made from a blend of cotton and polyester. Available in sizes S-XL.",
    //     type: "Apparel",
    //     collection: "Winter"),
    // Product(
    //     id: '103',
    //     name: "Women's Tank Top",
    //     price: 24.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2019/12/27/08/01/blonde-4721865_960_720.jpg",
    //     description:
    //         "A stylish and comfortable tank top for women, made from a lightweight and breathable fabric. Available in sizes XS-L.",
    //     type: "Dress",
    //     collection: "Summer"),
    // Product(
    //     id: '104',
    //     name: "Men's Polo Shirt",
    //     price: 39.99,
    //     imageUrl:
    //         "https://www.doiturselfforfree.com/wp-content/uploads/2020/09/Mens-polo-shirt.jpg",
    //     description:
    //         "A classic polo shirt for men, made from a soft and durable fabric. Available in sizes S-XXL.",
    //     type: "T-Shirt",
    //     collection: "Autumn"),
    // Product(
    //     id: '105',
    //     name: "Women's Jeans",
    //     price: 49.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2017/06/15/11/29/jeans-2405037_960_720.jpg",
    //     description:
    //         "A pair of stylish and comfortable jeans for women, made from a high-quality denim fabric. Available in sizes 2-16.",
    //     type: "Apparel",
    //     collection: "Rainy Season"),
    // Product(
    //     id: '106',
    //     name: "Women's Dress",
    //     price: 79.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2016/11/19/11/33/women-1838768_960_720.jpg",
    //     description:
    //         "A beautiful and elegant dress for women, made from a high-quality silk fabric. Available in sizes XS-L.",
    //     type: "Dress",
    //     collection: "Autumn"),
    // Product(
    //     id: '107',
    //     name: "Men's Jacket",
    //     price: 129.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2017/10/06/04/32/jacket-2821961_960_720.jpg",
    //     description:
    //         "A warm and stylish jacket for men, made from a durable water-resistant fabric. Available in sizes S-XL.",
    //     type: "Apparel",
    //     collection: "Winter"),
    // Product(
    //   id: '108',
    //   name: "Women's Sneakers",
    //   price: 69.99,
    //   imageUrl:
    //       "https://cdn.pixabay.com/photo/2017/07/02/19/51/shoes-2465599_960_720.jpg",
    //   description:
    //       "A pair of comfortable and stylish sneakers for women, made from a breathable and supportive fabric. Available in sizes 6-10",
    //   type: "Apparel",
    //   collection: "Summer",
    // ),
    // Product(
    //     id: '109',
    //     name: "Men's Boots",
    //     price: 99.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2020/04/03/00/50/boots-4997097_960_720.jpg",
    //     description:
    //         "A pair of rugged and durable boots for men, perfect for outdoor adventures. Available in sizes 7-12.",
    //     type: "Apparel",
    //     collection: "Winter"),
    // Product(
    //   id: '110',
    //   name: "Women's Handbag",
    //   price: 129.99,
    //   imageUrl:
    //       "https://cdn.pixabay.com/photo/2018/01/01/00/48/handbag-3053374_960_720.jpg",
    //   description:
    //       "A stylish and spacious handbag for women, made from a high-quality leather material.",
    //   type: "Bag",
    //   collection: "Spring",
    // ),
    // Product(
    //     id: '111',
    //     name: "Women's Sundress",
    //     price: 49.99,
    //     imageUrl:
    //         "https://i.pinimg.com/736x/6e/24/cc/6e24cc07657624f5e0c8286a2cf1d257.jpg",
    //     description:
    //         "A comfortable and stylish sundress for women, perfect for the summer season. Made from a lightweight and breathable fabric. Available in sizes XS-L.",
    //     type: "Dress",
    //     collection: "New Arrival"),
    // Product(
    //     id: '112',
    //     name: "Men's Chino Shorts",
    //     price: 39.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2018/08/08/16/37/glasses-3592607_960_720.jpg",
    //     description:
    //         "A pair of stylish and comfortable chino shorts for men, made from a high-quality cotton fabric. Available in sizes S-XL.",
    //     type: "Apparel",
    //     collection: "New Arrival"),
    // Product(
    //     id: '113',
    //     name: "Women's Sandals",
    //     price: 29.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2020/09/24/09/32/sandals-5598158_960_720.jpg",
    //     description:
    //         "A pair of comfortable and stylish sandals for women, perfect for the summer season. Made from a high-quality leather material. Available in sizes 6-10.",
    //     type: "Apparel",
    //     collection: "New Arrival"),
    // Product(
    //     id: '114',
    //     name: "Men's Linen Shirt",
    //     price: 49.99,
    //     imageUrl:
    //         "https://img.freepik.com/premium-photo/man-looks-attractive-casual-linen-blue-shirt-guy-bristle-undress-casual-shirt-fashion-concept-man-calm-serious-face-confidently-unbuttoning-shirts-collar-yellow-background-take-off-my-clothes_474717-7890.jpg?w=2000",
    //     description:
    //         "A stylish and comfortable linen shirt for men, perfect for the summer season. Made from a high-quality linen fabric. Available in sizes S-XXL.",
    //     type: "T-Shirt",
    //     collection: "New Arrival"),
    // Product(
    //     id: '115',
    //     name: "Women's Sunglasses",
    //     price: 29.99,
    //     imageUrl:
    //         "https://cdn.pixabay.com/photo/2020/03/03/05/21/boho-4897564_960_720.jpg",
    //     description:
    //         "A stylish and fashionable pair of sunglasses for women, perfect for the summer season. Made from a high-quality plastic material.",
    //     type: "Apparel",
    //     collection: "New Arrival")
  ];

  final String? authToken;
  final String? userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetData([bool filterByUser = false]) async {
    print('running');
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }

    url = Uri.parse(
      'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken',
    );
    final favoriteResponse = await http.get(url);
    final favoriteData = json.decode(favoriteResponse.body);
    final List<Product> loadedProducts = [];

    extractedData.forEach((prodId, prodData) {
      loadedProducts.add(Product(
        id: prodId,
        name: prodData['title'],
        description: prodData['description'],
        price: prodData['price'],
        collection: prodData['collection'],
        type: prodData['type'],
        imageUrl: prodData['imageUrl'],
        isFav: favoriteData == null ? false : favoriteData[prodId] ?? false,
      ));
    });
    _items = loadedProducts;
    notifyListeners();
  }

  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    return http
        .post(
      url,
      body: json.encode({
        'title': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'collection': product.collection,
        'type': product.type,
        'isFavorite': product.isFav,
        'creatorId': userId,
      }),
    )
        .then((response) {
      print(
        json.decode(response.body),
      );
      final newProduct = Product(
        name: product.name,
        description: product.description,
        price: product.price,
        collection: product.collection,
        type: product.type,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

      await http.patch(url,
          body: json.encode({
            'title': newProduct.name,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'collection': newProduct.collection,
            'type': newProduct.type,
          }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
        'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    http.delete(url).then((_) {
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProdIndex, existingProduct!);
      notifyListeners();
    });
  }
}
