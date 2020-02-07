import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _currIndex;

    Color defaultColor = Colors.grey;
    Color activeColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: PageView(


      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        onTap: (index){

          // TODO 跳转页面

          setState(() {
            _currIndex = index;
          });

        },
        type: BottomNavigationBarType.fixed,
        items:[

          _bottomItem("首页",Icons.home,0),
          _bottomItem("trip",Icons.home,1),
          _bottomItem("search",Icons.home,2),
          _bottomItem("owner",Icons.home,3),
        ] ,
      ),
    );
  }

  _bottomItem(String tab, IconData iconData,int index) {

    return  BottomNavigationBarItem(
      icon: Icon(iconData,color: defaultColor,),
      activeIcon:Icon(iconData,color: activeColor),
      title: Text(tab,style: TextStyle(color: index==_currIndex ? activeColor:defaultColor),)
    );
  }
}
