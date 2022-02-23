import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:intl/intl.dart';

class ArticleViewModel {
  final Article article;

  ArticleViewModel({required this.article});

  String? get title {
    return article.title;
  }

  String? get description {
    return article.description;
  }

  String get imageUrl {
    return article.urlToImage;
  }

  String? get url {
    return article.url;
  }

  String? get content {
    return article.content;
  }

  String get publishedAt {
    final dateTime =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(article.publishedAt, true);
    return Utils.convertToTimeAgo(dateTime);
  }
}
