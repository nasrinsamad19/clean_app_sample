import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class NavigationBarItems extends StatefulWidget {
  const NavigationBarItems({Key? key}) : super(key: key);

  @override
  State<NavigationBarItems> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarItems> {
  int _currentIndex = 0;

  @override
  void initState() {
    debugPrint('${Constants.imgPath}home.png');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildScreens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.1,
                ),
                spreadRadius: 3,
                blurRadius: 2,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              selectedItemColor: MyColors.yellow,
              unselectedItemColor: Colors.black,
              selectedIconTheme: IconThemeData(color: MyColors.yellow),
              currentIndex: _currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: _navBarsItems()),
        ));
  }

  List<Widget> _buildScreens = [
    HomePage(),
    LoginPage(),
    HomePage(),
    LoginPage(),
  ];
}

List<BottomNavigationBarItem> _navBarsItems() {
  return [
    BottomNavigationBarItem(
        label: '',
        icon: Container(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '${Constants.imgPath}home.png',
              ),
              SizedBox(
                width: 10,
              ),
              Text('Home',
                  style: TextStyle(
                    color: MyColors.yellow,
                  )),
            ],
          ),
        )),
    BottomNavigationBarItem(
      label: 'User',
      icon: Image.asset(
        '${Constants.imgPath}user.png',
      ),
    ),
    BottomNavigationBarItem(
      label: 'Share',
      icon: Image.asset(
        '${Constants.imgPath}share.png',
      ),
    ),
    BottomNavigationBarItem(
      label: 'Smile',
      icon: Image.asset(
        '${Constants.imgPath}smile.png',
      ),
    ),
  ];
}
