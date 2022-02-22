import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/material.dart';

String image =
    "https://media.istockphoto.com/photos/abstract-digital-news-concept-picture-id1290904409?b=1&k=20&m=1290904409&s=170667a&w=0&h=6khncht98kwYG-l7bdeWfBNs_GGcG1pDqzLb6ZXhh7I=";

class TrendingNewsWidget extends StatefulWidget {
  const TrendingNewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingNewsWidget> createState() => _TrendingNewsWidgetState();
}

class _TrendingNewsWidgetState extends State<TrendingNewsWidget> {
  Color? color;

  @override
  void initState() {
    super.initState();
    setColorText();
  }

  Future<Color?> setColorText() async {
    final imageColor = await Utils.getImagePalette(Image.network(image).image);
    if (imageColor != null) {
      Color textColor =
          imageColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
      setState(() {
        color = textColor;
      });
    }

    return Utils.getImagePalette(Image.network(image).image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 250,
          height: 100,
          margin: const EdgeInsets.only(right: 10, bottom: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: TextWidget(
                  content:
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elit",
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
        ),
      ),
    );
  }
}
