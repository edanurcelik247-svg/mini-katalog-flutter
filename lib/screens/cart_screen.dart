import 'package:flutter/material.dart';

import '../data/cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _price(double value) => '${value.toStringAsFixed(2).replaceAll('.', ',')} TL';

  @override
  Widget build(BuildContext context) {
    final items = Cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: items.isEmpty
          ? const Center(child: Text('Sepetin şu an boş.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(item.product.image, width: 48, height: 48, fit: BoxFit.cover),
                    ),
                    title: Text(item.product.name),
                    subtitle: Text(_price(item.total)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => setState(() => Cart.decrease(item.product)),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() => Cart.add(item.product)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Toplam'),
                          Text(_price(Cart.total),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(Cart.clear);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Siparişin alındı, teşekkürler!')),
                        );
                      },
                      child: const Text('Siparişi Tamamla'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
