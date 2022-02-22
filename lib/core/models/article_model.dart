class Article {
  String? title;
  String? description;
  String? url;
  String urlToImage;
  String publishedAt;
  String? content;

  Article(
      {this.title,
      required this.urlToImage,
      required this.publishedAt,
      this.description,
      this.url,
      this.content});

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? "",
      urlToImage: map['urlToImage'] ??
          "https://eic-immobilier.fr/wp-content/themes/realestate-7/images/no-image.png",
      publishedAt: map['publishedAt'],
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      content: map['content'] ?? "",
    );
  }
}
