import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  FavoriteIconWidget({Key? key, required this.article, this.size})
      : super(key: key);
  final ArticleViewModel article;
  double? size;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  bool isSelected = false;

  void saveToFavorite() async {
    setState(() {
      isSelected = !isSelected;
    });

    final sharedPrefViewModel =
        Provider.of<SharedPrefViewModel>(context, listen: false);

    final favoriteAction =
        await sharedPrefViewModel.updateFavorite(widget.article);

    Utils.showSnackBar(context, favoriteAction);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPrefViewModel>(
        builder: (BuildContext context, SharedPrefViewModel viewModel, _) {
      final contain = viewModel.favoriteNews
          .where((element) => element.title == widget.article.title);
      return GestureDetector(
        onTap: saveToFavorite,
        child: Container(
            margin: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.favorite,
              size: widget.size ?? 30,
              color:
                  contain.isNotEmpty ? AppColors.SECONDARY : AppColors.DISABLED,
            )),
      );
    });
  }
}
