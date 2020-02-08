import 'package:flutter_trip_demo/bean/GridNavItem.dart';

class GridNavModel {
  GridNavItem hotel;
  GridNavItem flight;
  GridNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});


  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GridNavModel(
      hotel: GridNavItem.fromJson(json['hotel']),
      flight: GridNavItem.fromJson(json['flight']),
      travel: GridNavItem.fromJson(json['travel']),
    )
        : null;
  }

}