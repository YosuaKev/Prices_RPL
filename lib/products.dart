class Product {
  final String name;
  final String price;

  Product({required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '',
    );
  }
}
