import 'package:appsonews/core/models/article_model.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const TitleWidget(content: "À la une"),
        const TrendingNewsWidget(),
        const TitleWidget(content: "Recommandé pour vous"),
        Expanded(
          child: FutureBuilder<List<Article>>(
            future: newsViewModel.getNews(),
            builder: (_, AsyncSnapshot<List<Article>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent));
                case ConnectionState.active:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  ));
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.yellowAccent));
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    var films = snapshot.data;
                    return ListView.builder(
                      itemCount: films == null ? 0 : films.length,
                      itemBuilder: (_, int index) {
                        var film = films?[index];
                        return Text("film: ${film?.title}");
                      },
                    );
                  } else {
                    return Center(
                        child: const CircularProgressIndicator(
                            color: Colors.green));
                  }
              }
            },
          ),
        ),
        // ListView.builder(itemBuilder: itemBuilder)
      ],
    );
  }
}
