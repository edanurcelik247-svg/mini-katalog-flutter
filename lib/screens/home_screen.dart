import 'package:flutter/material.dart';

import '../data/product_service.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';
import '../widgets/home_banner.dart';
import 'product_detail_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Product> _products = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_products.isEmpty) {
      ProductService.loadProducts(context).then((list) => setState(() => _products = list));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Arama metni route argümanı olarak liste ekranına gönderilir
  Future<void> _openList([String query = '']) async {
    await Navigator.pushNamed(context, ProductListScreen.routeName, arguments: query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [CartButton(onReturn: () => setState(() {}))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Merhaba!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const Text('Bugün ne almak istersin?'),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => _openList(value),
            decoration: InputDecoration(
              hintText: 'Ürün ara...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          HomeBanner(onPressed: () => _openList()),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Öne çıkanlar', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => _openList(), child: const Text('Tüm ürünler')),
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _products.length > 5 ? 5 : _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                    setState(() {});
                  },
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(product.image, height: 100, width: 120, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 6),
                        Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(product.formattedPrice, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
