import 'package:flutter/material.dart';
import 'package:flutter_trip_demo/page/HomePage.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key});

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  Color defaultColor = Colors.grey;
  Color activeColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        onTap: (index) {
          // TODO 跳转页面

          _controller.jumpToPage(index);
          setState(() {
            _currIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("trip", Icons.home, 1),
          _bottomItem("search", Icons.home, 2),
          _bottomItem("owner", Icons.home, 3),
        ],
      ),
    );
  }

  _bottomItem(String tab, IconData iconData, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconData,
          color: defaultColor,
        ),
        activeIcon: Icon(iconData, color: activeColor),
        title: Text(
          tab,
          style: TextStyle(
              color: index == _currIndex ? activeColor : defaultColor),
        ));
  }
}
