import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

class Utils {
  static String convertDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date).toString();
  }

  static Future<Color?> setColorText(String imageUrl) async {
    late Color textColor;
    final imageColor =
        await Utils.getImagePalette(Image.network(imageUrl).image);
    if (imageColor != null) {
      textColor =
          imageColor.computeLuminance() > 0.8 ? Colors.black : Colors.white;
    } else {
      textColor = Colors.black;
    }
    return textColor;
  }

  static Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  static String convertToTimeAgo(DateTime date) {
    Duration diff = DateTime.now().difference(date);
    if (diff.inDays >= 1) {
      return "Il y'a ${diff.inDays} jour${diff.inDays == 1 ? "" : "s"}";
    } else if (diff.inHours >= 1) {
      return "Il y'a ${diff.inHours} heure${diff.inHours == 1 ? "" : "s"}";
    } else if (diff.inMinutes >= 1) {
      return "Il y'a ${diff.inMinutes} min";
    } else if (diff.inSeconds >= 1) {
      return "Il y'a ${diff.inSeconds} s";
    } else {
      return "À l'instant";
    }
  }
}
