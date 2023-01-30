import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String type;
  final String collection;
  bool isFav;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.collection,
    this.isFav = false,
  });

  void toggleFavStatus(String? token, String? userId) async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    final url = Uri.parse(
      'https://flutter-shop-app-89c8b-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token',
    );
    final response = await http.put(url,
        body: json.encode(
          isFav,
        ));
  }
}
