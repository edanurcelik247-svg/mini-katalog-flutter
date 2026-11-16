import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/product.dart';

// assets/products.json dosyasındaki ürünleri okur
class ProductService {
  static Future<List<Product>> loadProducts(BuildContext context) async {
    final jsonText = await DefaultAssetBundle.of(context).loadString('assets/products.json');
    final List<dynamic> list = jsonDecode(jsonText);
    return list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }
}
