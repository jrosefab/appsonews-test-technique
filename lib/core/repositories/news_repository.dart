import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/utils/constants/environnment.dart';
import 'package:appsonews/utils/constants/url.dart';
import 'package:dio/dio.dart';

abstract class NewsRepository {}

class NewsRepositoryImpl extends NewsRepository {
  int DEFAULT_PAGE_SIZE = 6;
  String COUNTRY_PARAMETER = "country";
  String API_KEY_PARAMETER = "apikey";
  String PAGE_SIZE_PARAMETER = "pageSize";
  String PAGE_PARAMETER = "page";

  Dio dio = Dio();

  Future<List<Article>> getNews(int page) async {
    String url = AppUrl.TOP_HEAD_LINES;
    final response = await Dio().get(url, queryParameters: {
      COUNTRY_PARAMETER: "fr",
      API_KEY_PARAMETER: Environnement.API_KEY,
      PAGE_SIZE_PARAMETER: "$DEFAULT_PAGE_SIZE",
      PAGE_PARAMETER: "$page",
    });

    if (response.statusCode == 200) {
      final result = response.data;

      Iterable list = result["articles"];

      return list.map((article) => Article.fromMap(article)).toList();
    } else {
      throw Exception("Failed to get top news");
    }
  }
}
