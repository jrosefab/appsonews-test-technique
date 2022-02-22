import 'package:flutter/material.dart';

enum TextType {
  XXSMALL,
  XSMALL,
  SMALL,
  MEDIUM,
  LARGE,
  XLARGE,
  XXLARGE,
  XXXLARGE
}

class TextWidget extends StatelessWidget {
  final String content;
  final TextType type;
  final Color? color;
  final bool? isBold;
  final bool? overflow;
  final TextAlign? align;
  final TextDecoration? decoration;
  final List<Shadow>? shadow;

  const TextWidget(
      {Key? key,
      required this.content,
      required this.type,
      this.color,
      this.isBold,
      this.overflow,
      this.shadow,
      this.align,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (isBold != null) ? FontWeight.w600 : FontWeight.normal;
    return Text(
      content,
      textAlign: align,
      maxLines: 2,
      overflow:
          (overflow != null) ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
          fontSize: getTextSize(type),
          color: color,
          fontWeight: size,
          decoration: decoration,
          shadows: shadow),
    );
  }

  getTextSize(TextType size) {
    late double fontSize;
    switch (size) {
      case TextType.XXLARGE:
        fontSize = 35.00;
        break;
      case TextType.XLARGE:
        fontSize = 25.00;
        break;
      case TextType.LARGE:
        fontSize = 20.00;
        break;
      case TextType.MEDIUM:
        fontSize = 18.00;
        break;
      case TextType.SMALL:
        fontSize = 14.00;
        break;
      case TextType.XSMALL:
        fontSize = 12.00;
        break;
      case TextType.XXSMALL:
        fontSize = 8.00;
        break;
      default:
        fontSize = 14.00;
        break;
    }
    return fontSize;
  }
}
