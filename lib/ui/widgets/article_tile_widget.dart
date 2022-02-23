import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/shimmer_loading_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/constants/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleTileWidget extends StatelessWidget {
  const ArticleTileWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleViewModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                        _bottomInfo("Il y'a 15mn", CupertinoIcons.calendar),
                        SizedBox(
                          width: 10,
                        ),
                        _bottomInfo("Par CNews",
                            Icons.drive_file_rename_outline_rounded)
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
          content: article.title ?? "",
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
              color: AppColors.SECONDARY,
            ))
      ],
    );
  }

  ClipRRect _image() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: FadeInImage(
        image: NetworkImage(article.imageUrl),
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
