import 'package:appsonews/ui/styles/colors.dart';
import 'package:appsonews/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget(
      {Key? key, required this.index, required this.onItemTapped})
      : super(key: key);

  final int index;
  final void Function(int) onItemTapped;

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.BACKGROUND,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: widget.index,
        onTap: widget.onItemTapped,
        selectedFontSize: 0,
        iconSize: 30,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomNavItem(Icons.gamepad, "Jouer"),
          _bottomNavItem(Icons.gamepad, "Mes arènes"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      activeIcon: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        child: _iconAndLabel(icon, label, true),
      ),
      icon: _iconAndLabel(icon, label, false),
      label: '',
    );
  }

  Container _iconAndLabel(IconData icon, String label, bool isActive) {
    return Container(
      width: double.infinity,
      height: 69,
      color: isActive ? AppColors.SECONDARY : Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              content: label,
              color: isActive ? Colors.white : Colors.grey,
              type: TextType.SMALL,
            )
          ],
        ),
      ),
    );
  }
}
