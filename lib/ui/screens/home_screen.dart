import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/article_view_model.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/ui/widgets/article_tile_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/ui/widgets/title_widget.dart';
import 'package:appsonews/ui/widgets/featured_article_widget.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:appsonews/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late NewsViewModel newsViewModel;
  late SharedPrefViewModel sharedPrefViewModel;
  final TextEditingController _searchController = TextEditingController();
  int page = 1;
  late ScrollController _scrollController;
  late String fromRoute;
  FocusNode fieldFocusNode = FocusNode();
  bool newsFinded = false, searchActive = false, isKeyBoardVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    sharedPrefViewModel =
        Provider.of<SharedPrefViewModel>(context, listen: false);
    newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    getNews();
  }

  @override
  bool get wantKeepAlive => true;

  Future getNews() async {
    await sharedPrefViewModel.getFavoriteCountry();
    newsViewModel.getNews(
        page, sharedPrefViewModel.favoriteCountry?.code ?? "fr");
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (!isTop) {
        setState(() {
          //  page++;
        });
        // newsViewModel.getNews(page);
      }
    }
  }

  void searchNews() {
    if (_searchController.text.length > 2) {
      newsViewModel.searchNews(
          _searchController.text, sharedPrefViewModel.favoriteCountry!.code);
      if (newsViewModel.findedNews.isNotEmpty) {
        setState(() {
          newsFinded = true;
        });
      }
    } else {
      Utils.showSnackBar(context, "Renseigner au minium 2 lettres");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          _searchTextForm(),
          const SizedBox(
            height: 20,
          ),
          if (newsFinded) _searchedNewsConsumer(),
          if (!newsFinded)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featuredNewsConsumer(),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: _newsListConsumer(context),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )

          // ListView.builder(itemBuilder: itemBuilder)
        ],
      ),
    );
  }

  Widget _searchTextForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(
            height: 20,
          ),
          _serchTextForm(),
        ],
      ),
    );
  }

  Widget _serchTextForm() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _searchController,
            focusNode: fieldFocusNode,
            onTap: () {
              setState(() {
                searchActive = true;
              });
            },
            onChanged: (query) {
              //    if (query.length >= 1) _searchGame(ref, query);
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    searchActive = false;
                    newsFinded = false;
                    _searchController.clear();
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                    color: searchActive
                        ? AppColors.SECONDARY
                        : Colors.black.withOpacity(0.1),
                  ),
                ),
                hintText: "Rechercher un évenement",
                hintStyle: const TextStyle(color: Colors.black26),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15.0),
                )),
          ),
        ),
        if (searchActive) _searchingBtn()
      ],
    );
  }

  Widget _searchingBtn() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.PRIMARY,
        child: IconButton(
          onPressed: searchNews,
          icon: const Icon(
            Icons.search,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    );

    GestureDetector(
      onTap: searchNews,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: AppColors.PRIMARY),
        child: const Center(
          child: Icon(
            Icons.search,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _searchedNewsConsumer() {
    return Consumer<NewsViewModel>(
        builder: (BuildContext context, NewsViewModel viewModel, _) {
      bool isLoading = viewModel.loadingType == LoadingType.IS_LOADING;
      bool loadMoreData = viewModel.loadingType == LoadingType.LOAD_MORE_DATA;
      bool isEmpty = viewModel.loadingType == LoadingType.IS_EMPTY;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(content: "Vous avez recherché"),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: isLoading ? 6 : newsViewModel.findedNews.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isLoading) {
                    return const ShimmerArticleTileWidget();
                  }
                  final article = newsViewModel.findedNews[index];
                  return ArticleTileWidget(
                    article: article,
                  );
                }),
            if (loadMoreData)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.PRIMARY,
                ),
              ),
            if (isEmpty)
              const TextWidget(
                content: "Il n'y'a plus d'actualités",
                type: TextType.MEDIUM,
                align: TextAlign.center,
              )
          ],
        ),
      );
    });
  }

  Widget _featuredNewsConsumer() {
    return Consumer(
        builder: (BuildContext context, NewsViewModel viewModel, _) {
      bool isLoading = viewModel.loadingType == LoadingType.IS_LOADING;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TitleWidget(content: "À la une"),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: isLoading ? 3 : newsViewModel.featuredNews.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isLoading) {
                    return const ShimmerFeaturedArticleWidget();
                  }
                  final article = newsViewModel.featuredNews[index];
                  return FeaturedArticleWidget(article: article);
                }),
          ),
        ],
      );
    });
  }

  Widget _newsListConsumer(BuildContext context) {
    return Consumer<NewsViewModel>(
        builder: (BuildContext context, NewsViewModel viewModel, _) {
      bool isLoading = viewModel.loadingType == LoadingType.IS_LOADING;
      bool loadMoreData = viewModel.loadingType == LoadingType.LOAD_MORE_DATA;
      bool isEmpty = viewModel.loadingType == LoadingType.IS_EMPTY;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(content: "Les actualités"),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: isLoading ? 6 : newsViewModel.news.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isLoading) {
                    return const ShimmerArticleTileWidget();
                  }
                  final article = newsViewModel.news[index];
                  return ArticleTileWidget(
                    article: article,
                  );
                }),
            if (loadMoreData)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.PRIMARY,
                ),
              ),
            if (isEmpty)
              const TextWidget(
                content: "Il n'y'a plus d'actualités",
                type: TextType.MEDIUM,
                align: TextAlign.center,
              )
          ],
        ),
      );
    });
  }
}
