import 'dart:convert';
import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/models/country_model.dart';
import 'package:appsonews/core/services/shared_preference_service.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:appsonews/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SharedPrefViewModel with ChangeNotifier {
  SharedPrefService prefService = SharedPrefService();
  LoadingType loadingType = LoadingType.IS_LOADING;
  List<ArticleViewModel> favoriteNews = [];
  Country? favoriteCountry;

  void getNewsFromSharedPref() async {
    List<String> _favoritePrefsNews =
        await prefService.getStringList(AppStrings.FAVORITES);

    List<Article> _favoriteArticle = _favoritePrefsNews
        .map((article) => Article.fromMap(json.decode(article)))
        .toList();

    if (_favoritePrefsNews.isNotEmpty) {
      loadingType = LoadingType.HAS_DATA;
    } else {
      loadingType = LoadingType.IS_EMPTY;
    }

    favoriteNews = _favoriteArticle
        .map((article) => NewsViewModel.convertArticleToViewModel(article))
        .toList();

    notifyListeners();
  }

  void chooseFavoriteCountry(Country country) async {
    final pref = SharedPrefService();
    pref.setString(AppStrings.COUNTRY, json.encode(country.toJson()));
    favoriteCountry = country;
    notifyListeners();
  }

  Future<Country> getFavoriteCountry() async {
    final pref = SharedPrefService();
    final country = await pref.getString(AppStrings.COUNTRY);
    late Country _favoriteCountry;
    if (country != null) {
      _favoriteCountry = Country.fromMap(json.decode(country));
    } else {
      _favoriteCountry = Country(
          name: AppStrings.DEFAULT_COUNTRY,
          code: AppStrings.DEFAULT_COUNTRY_CODE,
          flag: AppStrings.DEFAULT_COUNTRY_FLAG);
    }

    favoriteCountry = _favoriteCountry;
    notifyListeners();

    return _favoriteCountry;
  }

  void clearFavorites() {
    final pref = SharedPrefService();
    pref.removePref(AppStrings.FAVORITES);
    favoriteNews.clear();
    notifyListeners();
  }

  Future<String> updateFavorite(ArticleViewModel article) async {
    late String message;
    List<String> currentFavorites =
        await prefService.getStringList(AppStrings.FAVORITES);

    final articleTime = DateFormat('d/M/y').parse(article.publishedAt);
    final convertedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(articleTime);

    final favoriteArticle = Article(
      title: article.title ?? "",
      author: article.author ?? "",
      source: article.source ?? Source(id: "", name: ""),
      urlToImage: article.urlToImage,
      publishedAt: convertedDate.toString(),
      description: article.description ?? "",
      url: article.url ?? "",
      content: article.content ?? "",
    );

    final encodedArticle = json.encode(favoriteArticle.toJson());

    if (!currentFavorites.contains(encodedArticle)) {
      currentFavorites.add(encodedArticle);
      message = "Article ajouté à votre liste de favoris";
    } else {
      currentFavorites.removeWhere((favorite) => favorite == encodedArticle);
      message = "Cet article ne fait plus partie de vos favoris";
    }

    await prefService.setStringList('favorites', currentFavorites);

    List<Article> _favoriteNews = currentFavorites
        .map((article) => Article.fromMap(json.decode(article)))
        .toList();

    favoriteNews = _favoriteNews
        .map((article) => NewsViewModel.convertArticleToViewModel(article))
        .toList();

    notifyListeners();
    return message;
  }
}
