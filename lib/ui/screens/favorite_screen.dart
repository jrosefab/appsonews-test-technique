import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/ui/widgets/article_tile_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPrefViewModel sharedPrefViewModel;

  @override
  void initState() {
    super.initState();
    sharedPrefViewModel =
        Provider.of<SharedPrefViewModel>(context, listen: false);
    sharedPrefViewModel.getNewsFromSharedPref();
  }

  void clearFavorites() {
    if (sharedPrefViewModel.favoriteNews.isNotEmpty) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return _dialogConfirmDelete(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  content: "Mes favoris",
                  type: TextType.XXLARGE,
                  isBold: true,
                ),
                IconButton(
                    onPressed: clearFavorites,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.SECONDARY,
                      size: 30,
                    ))
              ],
            ),
            Flexible(child: _favoriteListConsumer(context)),
          ],
        ),
      ),
    );
  }

  Widget _favoriteListConsumer(BuildContext context) {
    return Consumer<SharedPrefViewModel>(
        builder: (BuildContext context, SharedPrefViewModel viewModel, _) {
      bool isLoading = viewModel.loadingType == LoadingType.IS_LOADING;
      return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: isLoading ? 6 : sharedPrefViewModel.favoriteNews.length,
          itemBuilder: (BuildContext context, int index) {
            if (isLoading) {
              return const ShimmerArticleTileWidget();
            }
            final favoriteArticle = sharedPrefViewModel.favoriteNews[index];
            return ArticleTileWidget(
              article: favoriteArticle,
            );
          });
    });
  }

  Widget _dialogConfirmDelete(BuildContext context) {
    return AlertDialog(
      title: const TextWidget(
          content: "Êtes-vous sûr de tout supprimer ?",
          type: TextType.MEDIUM,
          color: Colors.black),
      actions: <Widget>[
        TextButton(
          child: const TextWidget(
              content: "Annuler", type: TextType.SMALL, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const TextWidget(
            content: "Confirmer",
            type: TextType.SMALL,
            color: AppColors.SECONDARY,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            sharedPrefViewModel.clearFavorites();
          },
        ),
      ],
    );
  }
}
