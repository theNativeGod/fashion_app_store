import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  final String id = DateTime.now().toString();
  final String name;
  final String bannerUrl;
  Collection({
    required this.name,
    required this.bannerUrl,
  });
}
