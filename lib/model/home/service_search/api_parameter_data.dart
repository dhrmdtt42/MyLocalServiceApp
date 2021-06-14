import 'package:flutter/foundation.dart';

class APIParameterData {
  String seo_url;
  String name;
  String type;
  String city;

  APIParameterData({this.seo_url, this.name, this.type, this.city});

  factory APIParameterData.fromJson(Map<String, dynamic> subJson) {
    return APIParameterData(
        seo_url: subJson['seo_url'],
        name: subJson['name'],
        type: subJson['type'],
        city: subJson['city']);
  }
}
