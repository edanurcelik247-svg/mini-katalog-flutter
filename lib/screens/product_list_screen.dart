import 'package:flutter/material.dart';

import '../data/product_service.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = '/products';

  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = TextEditingController();
  List<Product> _products = [];
  bool _loading = true;
  String _query = '';
  String _category = 'Tümü';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loading) {
      // Ana sayfadan gelen arama metni (route argümanı)
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String && args.isNotEmpty) {
        _query = args;
        _searchController.text = args;
      }
      ProductService.loadProducts(context).then((list) {
        setState(() {
          _products = list;
          _loading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filtered {
    final q = _query.toLowerCase();
    return _products.where((p) {
      final matchesText = p.name.toLowerCase().contains(q) || p.category.toLowerCase().contains(q);
      final matchesCategory = _category == 'Tümü' || p.category == _category;
      return matchesText && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Tümü', ..._products.map((p) => p.category).toSet()];
    final products = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        actions: [CartButton(onReturn: () => setState(() {}))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Ürün veya kategori ara',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final c = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : products.isEmpty
                    ? const Center(child: Text('Aramana uygun ürün bulunamadı.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onTap: () async {
                              // Seçilen ürün detay ekranına argüman olarak gider
                              await Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                              setState(() {});
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
