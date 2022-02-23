import 'package:appsonews/ui/router.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key, required this.argument}) : super(key: key);
  final ScreenArgument argument;

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late ArticleViewModel article;
  Color? color;

  @override
  void initState() {
    super.initState();
    article = widget.argument.content as ArticleViewModel;
    setColorText();
  }

  void setColorText() async {
    final _color = await Utils.setColorText(article.imageUrl);
    setState(() {
      color = _color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.imageUrl), fit: BoxFit.cover),
            ),
            child: Center(
              child: TextWidget(
                content: article.title ?? "",
                type: TextType.LARGE,
                color: color,
                isBold: true,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.65,
              maxChildSize: 1,
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: AppColors.WHITE,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: _articleContent(context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _articleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_addToFavorite()],
        ),
        _contentInfo("Articles", article.content ?? ""),
        const SizedBox(
          height: 30,
        ),
        _contentInfo("Articles", article.content ?? ""),
        const SizedBox(
          height: 30,
        ),
        _contentInfo("Articles", article.content ?? ""),
      ],
    );
  }

  Column _contentInfo(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          content: "Article",
          type: TextType.LARGE,
          color: Colors.black,
          isBold: true,
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
          content: article.content ?? "",
          type: TextType.MEDIUM,
          color: Colors.grey,
        ),
      ],
    );
  }

  Container _addToFavorite() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.DISABLED, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          TextWidget(
            content: "Ajouter aux favoris",
            type: TextType.SMALL,
            color: Colors.grey,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.favorite,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
