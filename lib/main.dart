import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/products.dart';
import './models/collections.dart';
import './models/cart.dart';
import './models/orders.dart';
import './models/auth.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/new_arrival_screen.dart';
import 'screens/collections_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/user_product_screen.dart';
import 'screens/edit_products_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(null, null, []),
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(create: (ctx) => Collections()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(null, null, []),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(builder: (context, auth, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Fashion Store',
              theme: ThemeData(
                fontFamily: 'TenorSans-Regular',
                primaryColor: const Color.fromARGB(255, 231, 234, 239),
                appBarTheme: const AppBarTheme(
                  color: Color.fromARGB(255, 231, 234, 239),
                  titleTextStyle: TextStyle(
                    fontFamily: 'TenorSans-Regular',
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  iconTheme: IconThemeData(
                    color: Color.fromARGB(190, 51, 51, 51),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
              ),
              home: auth.isAuth ? const HomeScreen() : const AuthScreen(),
              // : FutureBuilder(
              //     future: auth.tryAutoLogin(),
              //     builder: (ctx, authResultSnapshot) =>
              //         authResultSnapshot.connectionState ==
              //                 ConnectionState.waiting
              //             ? const Scaffold(
              //                 body: Center(
              //                 child: CircularProgressIndicator(
              //                   color: Color.fromARGB(255, 221, 133, 96),
              //                 ),
              //               ))
              //             : const AuthScreen()),
              routes: {
                AuthScreen.routeName: (context) => const AuthScreen(),
                HomeScreen.routeName: (context) => const HomeScreen(),
                NewArrivalScreen.routeName: (context) =>
                    const NewArrivalScreen(),
                CollectionsScreen.routeName: (context) =>
                    const CollectionsScreen(),
                ProductDetailScreen.routeName: (context) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (context) => const CartScreen(),
                OrdersScreen.routeName: (context) => const OrdersScreen(),
                UserProductScreen.routeName: (context) =>
                    const UserProductScreen(),
                EditProductScreen.routeName: (context) =>
                    const EditProductScreen(),
              });
        }));
  }
}
