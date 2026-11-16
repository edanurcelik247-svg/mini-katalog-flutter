import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Liste ekranından gönderilen ürün
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [CartButton(onReturn: () => setState(() {}))],
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'product-${product.id}',
            child: Image.asset(product.image, height: 300, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text(product.category)),
                const SizedBox(height: 8),
                Text(product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(
                  product.formattedPrice,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Ürün açıklaması', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(product.description, style: const TextStyle(height: 1.5)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Sepete Ekle'),
            onPressed: () {
              setState(() => Cart.add(product));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('${product.name} sepete eklendi')));
            },
          ),
        ),
      ),
    );
  }
}
