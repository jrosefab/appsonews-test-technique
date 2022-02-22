import 'dart:collection';

import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/repositories/news_repository.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  final newsRepository = NewsRepositoryImpl();

  List<ArticleViewModel> news = [];

  void getNews() async {
    List<Article> _news = await newsRepository.getNews();
    news = _news.map((article) => ArticleViewModel(article: article)).toList();
    notifyListeners();
  }

  /// Removes all items from the cart.

}
