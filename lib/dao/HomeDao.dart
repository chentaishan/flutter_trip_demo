import 'dart:convert';
import 'dart:io';

import 'package:flutter_trip_demo/bean/home_model_entity.dart';
import 'package:http_client/console.dart';

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeBean> fetch() async {
    var uri = Uri.parse(HOME_URL);

    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient.getUrl(uri);

    HttpClientResponse httpClientResponse = await request.close();

    if (httpClientResponse.statusCode == 200) {
      var str = await httpClientResponse.transform(utf8.decoder).join();

      print("get ====== " + str.toString());
      var resultVar = json.decode(str);

      return HomeBean.fromJson(resultVar);
    }
  }
}
