class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      imageUrl: (json['imageUrl'] ?? json['mainImageUrl']) as String,
    );
  }

  static const _currencySymbols = {'USD': '\$', 'EUR': '€'};

  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;

  String get formattedPrice {
    final symbol = _currencySymbols[currency] ?? currency;
    return '$symbol ${price.toStringAsFixed(2)}';
  }
}
