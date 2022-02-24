class Article {
  String? title;
  String? author;
  Source source;
  String? description;
  String? url;
  String urlToImage;
  String publishedAt;
  String? content;

  Article(
      {this.title,
      this.author,
      required this.source,
      required this.urlToImage,
      required this.publishedAt,
      this.description,
      this.url,
      this.content});

  Article.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? "",
        author = map['author'] ?? "",
        source = Source.fromMap(map['source']),
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
      'source': source.toJson(),
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'description': description,
      'url': url,
      'content': content,
    };
  }
}

class Source {
  String? id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  Source.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? "",
        name = map['name'] ?? "";

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }
}
