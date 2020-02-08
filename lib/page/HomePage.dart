import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip_demo/bean/CommonModel.dart';
import 'package:flutter_trip_demo/bean/GridNav.dart';
import 'package:flutter_trip_demo/bean/LocalNavList.dart';
import 'package:flutter_trip_demo/bean/home_model_entity.dart';
import 'package:flutter_trip_demo/dao/HomeDao.dart';
import 'package:flutter_trip_demo/widget/GridNav.dart';
import 'package:flutter_trip_demo/widget/LocalNav.dart';
import 'package:flutter_trip_demo/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];

  List<CommonModel> subNavList = [];
  Config config;
  GridNavModel gridNav;
  SalesBox salesBox;
  double appBarAlpha = 0;
  bool _loading = true;
  var APPBAR_SCROLL_OFFSET = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeBean homeBean = await HomeDao.fetch();

      setState(() {
        bannerList = homeBean.bannerList;
        localNavList = homeBean.localNavList;
        subNavList = homeBean.subNavList;

        config = homeBean.config;
        gridNav = homeBean.gridNav;
        salesBox = homeBean.salesBox;

        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: isLoading());
  }

  Widget isLoading() {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                // TODO 深入理解
                removeTop: true,
                context: context,
                child: NotificationListener(
                  onNotification: (scrollNOtification) {
                    if (scrollNOtification is ScrollUpdateNotification &&
                        scrollNOtification.depth == 0) {
                      _onScroll(scrollNOtification.metrics.pixels);
                    }
                  },
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: _listview(),
                  ),
                ),
              ),
              _appBar,
            ],
          );
  }

  Widget _listview() {
    return ListView(
      children: <Widget>[
        _banner(),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),

        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: GridNav(gridNavModel: gridNav)),
        Container(
          height: 1111,
          child: Text("hhh"),
        )
      ],
    );
  }

  Widget _banner() {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {},
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
//              inputBoxClick: _jumpToSearch,
//              speakClick: _jumpToSpeak,
//              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }
}
