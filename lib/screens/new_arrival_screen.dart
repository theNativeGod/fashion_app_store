import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../screens/collections_screen.dart';

class NewArrivalScreen extends StatelessWidget {
  static const routeName = '/newArrivalScreen';
  const NewArrivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          title: const Text(
            'NEW ARRIVAL',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: _newArrivalBodyUI(context),
          ),
        ),
      ),
    );
  }

  Widget _newArrivalBodyUI(ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _menuBar(),
        _itemsGrid(),
        _exploreMoreButton(ctx),
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
    return const Expanded(
      child: TabBarView(
        children: [
          ProductsGrid(tp: 'Apparel', colxn: 'New Arrival'),
          ProductsGrid(tp: 'Dress', colxn: 'New Arrival'),
          ProductsGrid(tp: 'Tshirt', colxn: 'New Arrival'),
          ProductsGrid(tp: 'Bag', colxn: 'New Arrival'),
        ],
      ),
    );
  }

  Widget _exploreMoreButton(BuildContext ctx) {
    return TextButton(
      onPressed: () {
        Navigator.of(ctx).pushNamed(CollectionsScreen.routeName);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => const Color.fromARGB(255, 231, 234, 239),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Explore More',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Color.fromARGB(190, 51, 51, 51),
            size: 30,
          ),
        ],
      ),
    );
  }
}
