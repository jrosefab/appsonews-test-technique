import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/repositories/news_repository.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  final newsRepository = NewsRepositoryImpl();
  LoadingType loadingType = LoadingType.IS_LOADING;
  List<ArticleViewModel> news = [];
  List<ArticleViewModel> findedNews = [];
  List<ArticleViewModel> featuredNews = [];
  List<ArticleViewModel> favoriteNews = [];

  void getNews(int page, String country) async {
    String? fixedCode;
    if (country == "en") {
      fixedCode = "gb";
    } else if (country == "es") {
      fixedCode = "ar";
    }

    List<Article>? _news = await newsRepository
        .getNews(page, fixedCode ?? country)
        .catchError((error) {
      loadingType = LoadingType.HAS_ERROR;
    });

    if (_news != null) {
      if (page > 1) {
        news.addAll(_news
            .map((article) => convertArticleToViewModel(article))
            .toList());
        loadingType = LoadingType.LOAD_MORE_DATA;
      } else {
        featuredNews.clear();
        news =
            _news.map((article) => convertArticleToViewModel(article)).toList();

        for (int i = 0; i < 3; i++) {
          featuredNews.add(news[i]);
          news.removeAt(i);
        }
      }

      if (_news.isNotEmpty) {
        loadingType = LoadingType.HAS_DATA;
      } else {
        loadingType = LoadingType.IS_EMPTY;
      }
    }
    notifyListeners();
  }

  void searchNews(String content, String language) async {
    List<Article>? _findedNews =
        await newsRepository.searchNews(content, language).catchError((error) {
      loadingType = LoadingType.HAS_ERROR;
    });

    if (_findedNews != null) {
      findedNews = _findedNews
          .map((article) => convertArticleToViewModel(article))
          .toList();
      loadingType = LoadingType.IS_LOADING;
      if (_findedNews.isEmpty) {
        loadingType = LoadingType.IS_EMPTY;
      } else {
        loadingType = LoadingType.HAS_DATA;
      }
    }

    notifyListeners();
  }

  static ArticleViewModel convertArticleToViewModel(Article article) {
    return ArticleViewModel(article: article);
  }
}
