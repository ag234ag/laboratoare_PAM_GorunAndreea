class Review {
  const Review({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.createdAtLabel,
    required this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      author: json['author'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      createdAtLabel: json['createdAtLabel'] as String? ?? '',
      text: json['text'] as String,
    );
  }

  final String id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String createdAtLabel;
  final String text;
}
