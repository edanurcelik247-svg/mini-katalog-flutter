import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../screens/cart_screen.dart';

// AppBar'daki sepet ikonu, üstünde ürün adedi gösterilir
class CartButton extends StatelessWidget {
  final VoidCallback onReturn;

  const CartButton({super.key, required this.onReturn});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Sepet',
      onPressed: () async {
        await Navigator.pushNamed(context, CartScreen.routeName);
        onReturn(); // sepetten dönünce sayıyı yenile
      },
      icon: Badge(
        isLabelVisible: Cart.count > 0,
        label: Text('${Cart.count}'),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
