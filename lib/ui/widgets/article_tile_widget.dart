import 'dart:convert';

import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/core/services/shared_preference_service.dart';
import 'package:appsonews/ui/router.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/shimmer_loading_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/constants/images.dart';
import 'package:appsonews/utils/constants/routes.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleTileWidget extends StatefulWidget {
  const ArticleTileWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleViewModel article;

  @override
  State<ArticleTileWidget> createState() => _ArticleTileWidgetState();
}

class _ArticleTileWidgetState extends State<ArticleTileWidget> {
  bool isSelected = false;

  Future<void> saveToFavorite() async {
    setState(() {
      isSelected = !isSelected;
    });

    if (isSelected) {
      final pref = SharedPrefService();

      final favoriteArticle = Article(
        title: widget.article.title ?? "",
        author: widget.article.author ?? "",
        source: widget.article.source ?? "",
        urlToImage: widget.article.urlToImage,
        publishedAt: widget.article.publishedAt,
        description: widget.article.description ?? "",
        url: widget.article.url ?? "",
        content: widget.article.content ?? "",
      ).toJson();

      final encodedArticle = json.encode(favoriteArticle);
      final currentFavorites = await pref.getString("favorites");
      print(currentFavorites);
      //pref.setString("favorites", encodedArticle);
      print(encodedArticle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.ARTICLE_ROUTE,
            arguments: ScreenArgument(content: widget.article));
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: AppColors.WHITE, borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _titleAndFavorite(),
                    Row(
                      children: [
                        TextWidget(
                          content: widget.article.publishedAgo,
                          type: TextType.XSMALL,
                          color: Colors.grey,
                          overflow: true,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (widget.article.author != null)
                          TextWidget(
                            content: "|  ${widget.article.author} ",
                            type: TextType.XSMALL,
                            color: Colors.grey,
                            overflow: true,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleAndFavorite() {
    return Row(
      children: [
        Expanded(
            child: TextWidget(
          content: widget.article.title ?? "",
          maxLines: 2,
          type: TextType.MEDIUM,
          isBold: true,
          overflow: true,
        )),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: saveToFavorite,
          child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.favorite,
                color: isSelected ? AppColors.SECONDARY : AppColors.DISABLED,
              )),
        )
      ],
    );
  }

  ClipRRect _image() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: FadeInImage(
        image: NetworkImage(widget.article.urlToImage),
        placeholder: const AssetImage(
          AppImages.NOT_FOUND,
        ),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppImages.NOT_FOUND,
            fit: BoxFit.cover,
            height: 110,
            width: 110,
          );
        },
        fit: BoxFit.cover,
        height: 110,
        width: 110,
      ),
    );
  }

  Widget _bottomInfo(String content, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),
        SizedBox(
          width: 5,
        ),
        TextWidget(
          content: content,
          type: TextType.XSMALL,
          color: Colors.grey,
          overflow: true,
        ),
      ],
    );
  }
}

class ShimmerArticleTileWidget extends StatelessWidget {
  const ShimmerArticleTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.WHITE, borderRadius: BorderRadius.circular(25))),
    );
  }
}
