import 'package:appsonews/ui/screens/article_screen.dart';
import 'package:appsonews/ui/screens/favorite_screen.dart';
import 'package:appsonews/ui/screens/home_screen.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/constants/routes.dart';
import 'package:flutter/material.dart';

class MyRouter {
  // generated routes
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      //user
      case AppRoutes.FAVORITE_ROUTE:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      //user
      case AppRoutes.ARTICLE_ROUTE:
        return MaterialPageRoute(builder: (_) => const ArticleScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: TextWidget(
                      content:
                          "No route at ${settings.name}, please check router file",
                      type: TextType.MEDIUM,
                      color: Colors.redAccent,
                    ),
                  ),
                ));
    }
  }
}