import '../models/cart_item.dart';
import '../models/product.dart';

// Basit sepet: uygulama boyunca tek bir liste tutulur.
// Ekranlar değişiklikten sonra setState ile kendini yeniler.
class Cart {
  static final List<CartItem> items = [];

  static void add(Product product) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(CartItem(product: product));
    }
  }

  static void decrease(Product product) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index < 0) return;
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }
  }

  static void remove(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  static void clear() => items.clear();

  static int get count => items.fold(0, (sum, item) => sum + item.quantity);

  static double get total => items.fold(0, (sum, item) => sum + item.total);
}
