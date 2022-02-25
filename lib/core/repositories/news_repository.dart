import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/utils/constants/environnment.dart';
import 'package:appsonews/utils/constants/url.dart';
import 'package:dio/dio.dart';

abstract class NewsRepository {}

class NewsRepositoryImpl extends NewsRepository {
  int DEFAULT_PAGE_SIZE = 6;
  String COUNTRY_PARAMETER = "country";
  String LANGUAGE_PARAMETER = "language";
  String API_KEY_PARAMETER = "apikey";
  String QUERY_PARAMETER = "q";
  String PAGE_SIZE_PARAMETER = "pageSize";
  String PAGE_PARAMETER = "page";
  String SORT_BY_PARAMETER = "sortBy";

  Dio dio = Dio();

  Future<List<Article>?> getNews(int page, String country) async {
    String url = AppUrl.TOP_HEAD_LINES_URL;
    return await Dio().get(url, queryParameters: {
      COUNTRY_PARAMETER: country,
      API_KEY_PARAMETER:
          "231424f0488947ccaecd32567871727c", //"f40097c5da6b4a7dae41c7f1372db5a0"
      PAGE_SIZE_PARAMETER: "$DEFAULT_PAGE_SIZE",
      PAGE_PARAMETER: "$page",
    }).then((response) {
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable list = result["articles"];

        return list.map((article) => Article.fromMap(article)).toList();
      }
    }).catchError((error, stackTrace) {
      throw Exception("Failed to get top news $error");
    });
  }

  Future<List<Article>?> searchNews(String content, String language) async {
    String url = AppUrl.EVERYTHING_URL;
    return await Dio().get(url, queryParameters: {
      QUERY_PARAMETER: content,
      LANGUAGE_PARAMETER: language,
      API_KEY_PARAMETER:
          "231424f0488947ccaecd32567871727c", //"f40097c5da6b4a7dae41c7f1372db5a0"
      PAGE_SIZE_PARAMETER: "10",
      PAGE_PARAMETER: "1",
    }).then((response) {
      if (response.statusCode == 200) {
        print("oui");
        final result = response.data;
        Iterable list = result["articles"];
        return list.map((article) => Article.fromMap(article)).toList();
      }
    }).catchError((error, stackTrace) {
      throw Exception("Failed to get searchNews $error");
    });
  }
}
