import 'dart:async';
import 'package:appsonews/core/models/country_model.dart';
import 'package:appsonews/ui/screens/favorite_screen.dart';
import 'package:appsonews/ui/screens/home_screen.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/ui/widgets/bottom_navigation_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:appsonews/utils/constants/enum.dart';
import 'package:appsonews/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageViewHandler extends StatefulWidget {
  const PageViewHandler({Key? key}) : super(key: key);
  @override
  _PageViewHandlerState createState() => _PageViewHandlerState();
}

class _PageViewHandlerState extends State<PageViewHandler> {
  late PageController _pageController;
  late NewsViewModel _newsViewModel;
  late SharedPrefViewModel _sharedPrefViewModel;
  int? _previousIndex;
  int _selectedIndex = 0;

  List<Country> countries = [
    Country(name: "Argentine", code: "ar", flag: "🇦🇷"),
    Country(name: "Allemagne", code: "de", flag: "🇩🇪"),
    Country(name: "Anglais", code: "en", flag: "🇬🇧"),
    Country(name: "Espagnol", code: "es", flag: "🇪🇸"),
    Country(name: "France", code: "fr", flag: "🇫🇷"),
    Country(name: "Italie", code: "it", flag: "🇮🇹"),
    Country(name: "Pays-Bas", code: "nl", flag: "🇳🇱"),
    Country(name: "Norvège", code: "no", flag: "🇳🇴"),
    Country(name: "Portugal", code: "pt", flag: "🇵🇹"),
    Country(name: "Russie", code: "ru", flag: "🇷🇺"),
    Country(name: "Suède", code: "se", flag: "🇸🇪"),
  ];

  List<Widget> tabScreen = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _selectedIndex);
    _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    _sharedPrefViewModel =
        Provider.of<SharedPrefViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void selectCountry(Country country) {
    _sharedPrefViewModel.chooseFavoriteCountry(country);

    _newsViewModel.getNews(1, country.code);
    Navigator.of(context).pop();
  }

  Future<void> choosCountries() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _chooseCountriesDialog(context);
      },
    );
  }

  Future<bool> handlePreviousPage() async {
    // allow user to navigate throungh tab
    if (_previousIndex != null) {
      bool hasGoBackToHome =
          _selectedIndex == _previousIndex && _previousIndex != 0;

      bool backToPreviousPage = _selectedIndex != _previousIndex;

      if (backToPreviousPage) {
        setState(() {
          _selectedIndex = _previousIndex!;
          _pageController.jumpToPage(_previousIndex!);
        });
        return false;
      } else if (hasGoBackToHome) {
        setState(() {
          _selectedIndex = 0;
          _pageController.jumpToPage(0);
        });
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void _onScreenChanged(int page) {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = page;
    });
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handlePreviousPage,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.BACKGROUND,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Center(
              child: Image.asset(
                AppImages.LOGO_TEXT,
              ),
            ),
          ),
          actions: [_selectedCountry()],
        ),
        extendBody: true,
        bottomNavigationBar: BottomNavigationWidget(
          onItemTapped: (int item) {
            _onTabTapped(item);
          },
          index: _selectedIndex,
        ),
        body: Container(
          color: AppColors.BACKGROUND,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: tabScreen,
            onPageChanged: _onScreenChanged,
            controller: _pageController,
          ),
        ),
      ),
    );
  }

  Widget _chooseCountriesDialog(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [for (Country country in countries) _country(country)],
      ),
    );
  }

  Widget _country(Country country) {
    return InkWell(
      onTap: () => selectCountry(country),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(content: country.name, type: TextType.MEDIUM),
            TextWidget(content: country.flag, type: TextType.MEDIUM)
          ],
        ),
      ),
    );
  }

  Widget _selectedCountry() {
    return Consumer<SharedPrefViewModel>(
        builder: (BuildContext context, SharedPrefViewModel viewModel, _) {
      return InkWell(
        onTap: choosCountries,
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: TextWidget(
              content: viewModel.favoriteCountry?.flag ?? "",
              type: TextType.LARGE,
            ),
          ),
        ),
      );
    });
  }
}
