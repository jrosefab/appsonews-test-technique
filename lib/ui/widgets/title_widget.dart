import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextWidget(
        content: content,
        type: TextType.MEDIUM,
        color: Colors.black,
        isBold: true,
      ),
    );
  }
}
