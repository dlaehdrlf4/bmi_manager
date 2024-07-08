class NaverModel {
  final String title;
  final String link;
  final String description;
  final String thumbnail;

  NaverModel({
    required this.title,
    required this.link,
    required this.description,
    required this.thumbnail,
  });

  factory NaverModel.fromJson(Map<String, dynamic> json) {
    return NaverModel(
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
