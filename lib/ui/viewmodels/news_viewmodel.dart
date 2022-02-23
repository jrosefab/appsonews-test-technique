import 'dart:collection';

import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/repositories/news_repository.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:flutter/material.dart';

enum LoadingType { HAS_DATA, IS_EMPTY, IS_LOADING, LOAD_MORE_DATA }

class NewsViewModel with ChangeNotifier {
  final newsRepository = NewsRepositoryImpl();
  LoadingType loadingType = LoadingType.IS_LOADING;
  List<ArticleViewModel> news = [];
  List<ArticleViewModel> featuredNews = [];

  void getNews(int page) async {
    List<Article> _news = await newsRepository.getNews(page);

    if (page > 1) {
      news.addAll(
          _news.map((article) => ArticleViewModel(article: article)).toList());
      loadingType = LoadingType.LOAD_MORE_DATA;
    } else {
      featuredNews.clear();

      news =
          _news.map((article) => ArticleViewModel(article: article)).toList();

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

    notifyListeners();
  }

  /// Removes all items from the cart.

}
