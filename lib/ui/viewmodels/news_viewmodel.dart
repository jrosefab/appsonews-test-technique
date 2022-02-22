import 'dart:collection';

import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/repositories/news_repository.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  final newsRepository = NewsRepositoryImpl();

  List<Article> _news = [];

  Future<List<Article>> getNews() async {
    List<Article> news = await newsRepository.getNews();
    //  print(news);

    _news = news;

    notifyListeners();
    return _news;
  }

  /// Removes all items from the cart.

}
