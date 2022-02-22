class Article {
  String? title;
  String? description;
  String? url_to_image;
  String? url;
  String? published_at;
  String? content;

  Article(
      {this.title,
      this.description,
      this.url_to_image,
      this.url,
      this.published_at,
      this.content});

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url_to_image: map['urlToImage'] ?? "",
      url: map['url'] ?? "",
      published_at: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}
