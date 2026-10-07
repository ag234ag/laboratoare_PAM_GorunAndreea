class Promo {
  const Promo({
    required this.label,
    required this.title,
    required this.imageUrl,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      label: json['label'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  final String label;
  final String title;
  final String imageUrl;
}

class CategoryPromo {
  const CategoryPromo({
    required this.id,
    required this.category,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryPromo.fromJson(Map<String, dynamic> json) {
    return CategoryPromo(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  final String id;
  final String category;
  final String title;
  final String imageUrl;
}
