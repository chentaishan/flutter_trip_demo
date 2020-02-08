import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip_demo/bean/home_model_entity.dart';
import 'package:flutter_trip_demo/dao/HomeDao.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerList> bannerList = [];
  List<LocalNavList> localNavList = [];

  List<SubNavList> subNavList = [];
  Config config;
  GridNav gridNav;
  SalesBox salesBox;

  bool _loading = true;

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
        : RefreshIndicator(
            onRefresh: _handleRefresh,
            child: _listview(),
          );
  }

  Widget _listview() {
    return ListView(
      children: <Widget>[
        _banner(),
      ],
    );
  }

  Widget _banner() {
    return Container(
      height: 166,
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
}
