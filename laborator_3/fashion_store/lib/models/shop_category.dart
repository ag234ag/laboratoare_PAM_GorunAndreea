class ShopCategory {
  const ShopCategory({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.selected,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) {
    return ShopCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      selected: json['selected'] as bool? ?? false,
    );
  }

  final String id;
  final String name;
  final String iconUrl;
  final bool selected;
}
