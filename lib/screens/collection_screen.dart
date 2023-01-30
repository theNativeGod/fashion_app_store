import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';

import '../models/collection.dart';

class CollectionScreen extends StatelessWidget {
  final Collection colxn;
  const CollectionScreen(this.colxn, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),
            child: Image.network(colxn.bannerUrl, fit: BoxFit.fitWidth),
          ),
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
            colxn.name,
            style: TextStyle(
              //color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: _newArrivalBodyUI(),
          ),
        ),
      ),
    );
  }

  Widget _newArrivalBodyUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _menuBar(),
        _itemsGrid(),
      ],
    );
  }

  Widget _menuBar() {
    return const Material(
      color: Color.fromARGB(255, 231, 234, 239),
      child: TabBar(
        indicatorColor: Color.fromARGB(190, 51, 51, 51),
        indicatorWeight: 0.5,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.all(1.0),
        unselectedLabelColor: Color.fromARGB(176, 51, 51, 51),
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'TenorSans-Regular',
        ),
        tabs: [
          Tab(
            text: 'Apparel',
          ),
          Tab(
            text: 'Dress',
          ),
          Tab(
            text: 'Tshirt',
          ),
          Tab(
            text: 'Bag',
          ),
        ],
      ),
    );
  }

  Widget _itemsGrid() {
    return Expanded(
      child: TabBarView(
        children: [
          ProductsGrid(
            colxn: colxn.name,
            tp: 'Apparel',
          ),
          ProductsGrid(
            colxn: colxn.name,
            tp: 'Dress',
          ),
          ProductsGrid(
            colxn: colxn.name,
            tp: 'Tshirt',
          ),
          ProductsGrid(
            colxn: colxn.name,
            tp: 'Bag',
          ),
        ],
      ),
    );
  }
}
