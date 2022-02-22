import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ArticleTileWidget extends StatelessWidget {
  const ArticleTileWidget({
    Key? key,
    required this.news,
  }) : super(key: key);

  final ArticleViewModel news;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              news.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextWidget(
            content: news.title ?? "",
            type: TextType.MEDIUM,
            isBold: true,
            overflow: true,
          )),
          const SizedBox(
            width: 10,
          ),
          Container(
              margin: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.favorite,
                color: AppColors.DISABLED,
              ))
        ],
      ),
    );
  }
}
