class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
  });

  // JSON'dan nesne oluşturma
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  // Nesneyi tekrar JSON'a çevirme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'image': image,
    };
  }

  String get formattedPrice => '${price.toStringAsFixed(2).replaceAll('.', ',')} TL';
}
