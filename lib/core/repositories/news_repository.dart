import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/utils/constants/url.dart';
import 'package:dio/dio.dart';

abstract class NewsRepository {}

class NewsRepositoryImpl extends NewsRepository {
  Dio dio = Dio();

  Future<List<Article>> getNews() async {
    final response = await dio.get(AppUrl.TOP_HEAD_LINES);
    if (response.statusCode == 200) {
      final result = response.data;

      Iterable list = result["articles"];

      return list.map((article) => Article.fromMap(article)).toList();
    } else {
      throw Exception("Failed to get top news");
    }
  }
}
