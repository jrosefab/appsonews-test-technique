import 'dart:async';
import 'package:appsonews/core/models/country_model.dart';
import 'package:appsonews/ui/screens/favorite_screen.dart';
import 'package:appsonews/ui/screens/home_screen.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/ui/widgets/bottom_navigation_widget.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
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
  late SharedPrefViewModel _sharedPrefViewModel;
  late int _previousIndex;
  int _selectedIndex = 0;

  List<Country> countries = [
    Country(name: "Français", code: "fr", flag: "🇫🇷"),
    Country(name: "Deutsh", code: "de", flag: "🇩🇪"),
    Country(name: "English", code: "en", flag: "🇬🇧"),
    Country(name: "Spanish", code: "es", flag: "🇪🇸"),
    Country(name: "Arabic", code: "ar", flag: "🇸🇦"),
  ];

  List<Widget> tabScreen = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
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
    bool hasGoBackToHome =
        _selectedIndex == _previousIndex && _previousIndex != 0;

    bool hasBackToPreviousPage = _selectedIndex != _previousIndex;

    if (hasBackToPreviousPage) {
      setState(() {
        _selectedIndex = _previousIndex;
        _pageController.jumpToPage(_previousIndex);
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
      return GestureDetector(
        onTap: choosCountries,
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: TextWidget(
              content: viewModel.favoriteCountry.flag,
              type: TextType.LARGE,
            ),
          ),
        ),
      );
    });
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
}
