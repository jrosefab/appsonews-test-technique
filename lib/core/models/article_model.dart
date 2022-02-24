class Article {
  String? title;
  String? author;
  String? source;
  String? description;
  String? url;
  String urlToImage;
  String publishedAt;
  String? content;

  Article(
      {this.title,
      this.author,
      this.source,
      required this.urlToImage,
      required this.publishedAt,
      this.description,
      this.url,
      this.content});

  Article.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? "",
        author = map['author'] ?? "",
        source = map['source']['name'] ?? "",
        urlToImage = map['urlToImage'] ??
            "https://eic-immobilier.fr/wp-content/themes/realestate-7/images/no-image.png",
        publishedAt = map['publishedAt'],
        description = map['description'] ?? "",
        url = map['url'] ?? "",
        content = map['content'] ?? "";

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'source': source,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'description': description,
      'url': url,
      'content': content,
    };
  }
}
