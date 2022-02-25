import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/utils/constants/environment.dart';
import 'package:appsonews/utils/constants/strings.dart';
import 'package:appsonews/utils/constants/url.dart';
import 'package:dio/dio.dart';

abstract class NewsRepository {}

class NewsRepositoryImpl extends NewsRepository {
  Dio dio = Dio();

  Future<List<Article>?> getNews(int page, String country) async {
    String url = AppUrl.TOP_HEAD_LINES_URL;
    return await Dio().get(url, queryParameters: {
      AppStrings.COUNTRY: country,
      AppStrings.API_KEY: "f40097c5da6b4a7dae41c7f1372db5a0",
      AppStrings.PAGE_SIZE: "${AppStrings.DEFAULT_PAGE_SIZE}",
      AppStrings.PAGE: "$page",
    }).then((response) {
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable list = result[AppStrings.ARTICLES];

        return list.map((article) => Article.fromMap(article)).toList();
      }
    }).catchError((error, stackTrace) {
      throw Exception("Failed to get top news $error");
    });
  }

  Future<List<Article>?> searchNews(String content, String language) async {
    String url = AppUrl.EVERYTHING_URL;
    return await Dio().get(url, queryParameters: {
      AppStrings.QUERY: content,
      AppStrings.LANGUAGE: language,
      AppStrings.API_KEY: Environnement.API_KEY,
      AppStrings.PAGE_SIZE: "${AppStrings.DEFAULT_PAGE_SIZE}",
      AppStrings.PAGE: "1",
    }).then((response) {
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable list = result[AppStrings.ARTICLES];
        return list.map((article) => Article.fromMap(article)).toList();
      }
    }).catchError((error, stackTrace) {
      throw Exception("Failed to get searchNews $error");
    });
  }
}
