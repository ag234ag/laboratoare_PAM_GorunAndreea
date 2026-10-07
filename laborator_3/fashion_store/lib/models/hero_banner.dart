class HeroBannerData {
  const HeroBannerData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.action,
    required this.slides,
    required this.activeSlide,
  });

  factory HeroBannerData.fromJson(Map<String, dynamic> json) {
    return HeroBannerData(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      action: json['action'] as String? ?? '',
      slides: json['slides'] as int? ?? 1,
      activeSlide: json['activeSlide'] as int? ?? 0,
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final String action;
  final int slides;
  final int activeSlide;
}
