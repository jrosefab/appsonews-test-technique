import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/material.dart';

class FeaturedArticleWidget extends StatefulWidget {
  const FeaturedArticleWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleViewModel article;
  @override
  State<FeaturedArticleWidget> createState() => _FeaturedArticleWidgetState();
}

class _FeaturedArticleWidgetState extends State<FeaturedArticleWidget> {
  Color? color;

  @override
  void initState() {
    super.initState();
    setColorText();
  }

  Future<Color?> setColorText() async {
    final imageColor = await Utils.getImagePalette(
        Image.network(widget.article.imageUrl).image);
    if (imageColor != null) {
      Color textColor =
          imageColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
      setState(() {
        color = textColor;
      });
    }
    return Utils.getImagePalette(Image.network(widget.article.imageUrl).image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(widget.article.imageUrl), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: _favorite(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _titleAndShowMore(),
          ),
        ],
      ),
    );
  }

  Container _favorite() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Icon(
        Icons.favorite,
        color: AppColors.DISABLED,
      ),
    );
  }

  Container _titleAndShowMore() {
    return Container(
      width: 250,
      height: 100,
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: TextWidget(
              content: widget.article.title ?? "",
              type: TextType.MEDIUM,
              color: color,
              isBold: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextWidget(
                content: "Lire plus",
                type: TextType.SMALL,
                color: color,
                isBold: true,
              ),
              Icon(
                Icons.arrow_forward_sharp,
                color: color,
              )
            ],
          )
        ],
      ),
    );
  }
}
