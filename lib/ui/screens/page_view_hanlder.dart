import 'dart:async';
import 'package:appsonews/ui/screens/favorite_screen.dart';
import 'package:appsonews/ui/screens/home_screen.dart';
import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/widgets/bottom_navigation_widget.dart';
import 'package:appsonews/utils/constants/images.dart';
import 'package:flutter/material.dart';

class PageViewHandler extends StatefulWidget {
  const PageViewHandler({Key? key}) : super(key: key);
  @override
  _PageViewHandlerState createState() => _PageViewHandlerState();
}

class _PageViewHandlerState extends State<PageViewHandler> {
  late PageController _pageController;
  late int _previousIndex;
  int _selectedIndex = 0;

  List<Widget> tabScreen = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
