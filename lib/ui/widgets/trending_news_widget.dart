import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

String image =
    "https://media.istockphoto.com/photos/abstract-digital-news-concept-picture-id1290904409?b=1&k=20&m=1290904409&s=170667a&w=0&h=6khncht98kwYG-l7bdeWfBNs_GGcG1pDqzLb6ZXhh7I=";

class TrendingNewsWidget extends StatelessWidget {
  const TrendingNewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 200,
          height: 100,
          margin: const EdgeInsets.only(right: 10, bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white60, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const Expanded(
                child: TextWidget(
                  content:
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elit",
                  type: TextType.SMALL,
                  color: Colors.black,
                  isBold: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  TextWidget(
                    content: "Lire plus",
                    type: TextType.SMALL,
                    color: Colors.black,
                    isBold: true,
                  ),
                  Icon(Icons.arrow_forward_sharp)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
