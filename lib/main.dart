import 'package:flutter/material.dart';

import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        scaffoldBackgroundColor: const Color(0xFFF6F7F5),
        useMaterial3: true,
      ),
      // Named routes
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProductListScreen.routeName: (context) => const ProductListScreen(),
        ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
        CartScreen.routeName: (context) => const CartScreen(),
      },
    );
  }
}
