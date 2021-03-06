import 'package:flutter/material.dart';
import 'package:flutter_trip_demo/bean/CommonModel.dart';
import 'package:flutter_trip_demo/bean/LocalNavList.dart';
import 'package:flutter_trip_demo/bean/home_model_entity.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(),
      ),
    );
  }

  _items() {
    if (localNavList == null) return null;

    List<Widget> items = [];

    localNavList.forEach((model) {
      items.add(_item(model));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(CommonModel model) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
