import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/products.dart';
import '../screens/new_arrival_screen.dart';
import '../widgets/cart_icon.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 234, 239),
        title: const Text(
          'Open Fashion',
          style: TextStyle(
            fontFamily: 'TenorSans-Regular',
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        automaticallyImplyLeading: true,
        // leading:  Padding(
        // padding: EdgeInsets.only(left: 10.0),
        // child: IconButton(
        // onPressed: () {
        // return AppDrawer();
        // },
        // icon: Icon(
        // Icons.menu_sharp,
        // color: Color.fromARGB(190, 51, 51, 51),
        // )),
        // ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(190, 51, 51, 51),
              size: 25,
            ),
          ),
          const CartIcon(),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 221, 133, 96),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/image1.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'LUXURY\nFASHION\n& ACCESSORIES',
                        style: TextStyle(
                          color: Color.fromARGB(190, 51, 51, 51),
                          fontFamily: 'BodoniModa-Italic',
                          fontSize: 37,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 253,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(38),
                    //     ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(NewArrivalScreen.routeName);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 0, 0, 0.4),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'EXPLORE COLLECTION',
                              style: TextStyle(
                                fontFamily: 'TenorSans-Regular',
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
