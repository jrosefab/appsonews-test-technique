import 'package:appsonews/core/services/dynamic_links_service.dart';
import 'package:appsonews/ui/router.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/widgets/favorite_icon_widget.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
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

  Future<void> shareArticle() async {
    final dynamicLinksService = DynamicLinkService();
    late Uri url;
    if (article.url == null) {
      url = await dynamicLinksService.buildLink();
    } else {
      url = Uri.parse(article.url!);
    }
    Share.share("Découvre sur AppsoNews : $url");
  }

  void setColorText() async {
    final _color = await Utils.setColorText(article.urlToImage);
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
        actions: [
          IconButton(onPressed: shareArticle, icon: const Icon(Icons.share))
        ],
      ),
      body: Stack(
        children: [
          _topArticleImage(context),
          _draggableWrapper(),
        ],
      ),
    );
  }

  Widget _draggableWrapper() {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.65,
      maxChildSize: 1,
      expand: true,
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
    );
  }

  Widget _topArticleImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(article.urlToImage)),
      ),
      child: Center(
        child: TextWidget(
            content: article.title ?? "",
            type: TextType.LARGE,
            color: color,
            isBold: true,
            shadow: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 10.0,
                color: Colors.black,
              ),
            ]),
      ),
    );
  }

  Widget _articleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _topInfos(),
        const SizedBox(
          height: 20,
        ),
        article.content!.isEmpty
            ? TextWidget(
                content: article.title ?? "",
                type: TextType.MEDIUM,
                color: Colors.grey,
              )
            : TextWidget(
                content: article.title ?? "",
                type: TextType.MEDIUM,
                color: Colors.grey,
              ),
        const SizedBox(
          height: 30,
        ),
        if (article.source != null)
          _contentInfo("Source", article.source!.name!),
        const SizedBox(
          height: 30,
        ),
        if (article.author!.isNotEmpty)
          Column(
            children: [
              _contentInfo("Auteur", article.author!),
            ],
          ),
      ],
    );
  }

  Widget _topInfos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _publishedDate(),
        const SizedBox(
          width: 5,
        ),
        FavoriteIconWidget(
          article: article,
          size: 40,
        ),
      ],
    );
  }

  Widget _contentInfo(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          content: label,
          type: TextType.LARGE,
          color: Colors.black,
          isBold: true,
        ),
        const SizedBox(
          height: 10,
        ),
        TextWidget(
          content: content,
          type: TextType.MEDIUM,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _publishedDate() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month,
            color: Colors.blueAccent,
          ),
          const SizedBox(
            width: 5,
          ),
          TextWidget(
            content: article.publishedAt,
            type: TextType.SMALL,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
