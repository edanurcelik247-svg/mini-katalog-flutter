import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog/data/cart.dart';
import 'package:mini_katalog/main.dart';
import 'package:mini_katalog/models/product.dart';

void main() {
  const product = Product(
    id: 1,
    name: 'Deneme Ürün',
    category: 'Test',
    price: 100,
    description: 'Açıklama',
    image: 'assets/images/product_1.png',
  );

  test('Product fromJson ve toJson birbirinin tersi', () {
    final copy = Product.fromJson(product.toJson());
    expect(copy.name, product.name);
    expect(copy.price, product.price);
  });

  test('Sepete aynı ürün eklenince adet artar', () {
    Cart.clear();
    Cart.add(product);
    Cart.add(product);
    expect(Cart.items.length, 1);
    expect(Cart.count, 2);
    expect(Cart.total, 200);
    Cart.decrease(product);
    expect(Cart.count, 1);
  });

  testWidgets('Ana sayfa açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
