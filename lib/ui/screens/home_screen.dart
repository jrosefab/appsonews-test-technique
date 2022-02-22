import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
import 'package:appsonews/ui/widgets/article_tile_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/ui/widgets/title_widget.dart';
import 'package:appsonews/ui/widgets/trending_news_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsViewModel newsViewModel;
  @override
  void initState() {
    super.initState();
    newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    newsViewModel.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TextWidget(
            content: "Rechercher",
            type: TextType.XXLARGE,
            isBold: true,
          ),
          const TextWidget(
            content: "Vos actualités au bout des doigts",
            type: TextType.SMALL,
            color: AppColors.GRAY,
          ),
          _trendingNews(),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: _newsList(context),
          ),
          // ListView.builder(itemBuilder: itemBuilder)
        ],
      ),
    );
  }

  Column _trendingNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleWidget(content: "À la une"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TrendingNewsWidget(),
              TrendingNewsWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _newsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleWidget(content: "Recommandé pour vous"),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsViewModel.news.length,
              itemBuilder: (BuildContext context, int index) {
                final news = newsViewModel.news[index];
                return ArticleTileWidget(news: news);
              }),
        ],
      ),
    );
  }
}
