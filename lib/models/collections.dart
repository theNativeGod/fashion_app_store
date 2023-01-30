import 'package:flutter/material.dart';
import './collection.dart';

class Collections with ChangeNotifier {
  final List<Collection> _items = [
    Collection(
      name: 'Summer',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2017/07/23/16/01/nature-2531761_960_720.jpg',
    ),
    Collection(
      name: 'Rainy Season',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2018/05/18/12/24/rain-3411068_960_720.jpg',
    ),
    Collection(
      name: 'Winter',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2021/12/01/14/04/christmas-season-6838066_960_720.jpg',
    ),
    Collection(
      name: 'Autumn',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2015/12/06/09/15/maple-1079235_960_720.jpg',
    ),
    Collection(
      name: 'Spring',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2020/04/19/21/25/field-5065671_960_720.jpg',
    ),
    Collection(
      name: 'New Arrival',
      bannerUrl:
          'https://cdn.pixabay.com/photo/2017/12/17/22/31/christmas-3025101_960_720.jpg',
    ),
  ];

  List<Collection> get items {
    return [..._items];
  }
}
