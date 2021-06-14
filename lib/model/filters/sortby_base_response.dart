import 'package:flutter/cupertino.dart';

class SortByBaseResponse {
  String title;
  List<dynamic> sortbyData;

  SortByBaseResponse({this.title, this.sortbyData});

  factory SortByBaseResponse.fromJson(Map<dynamic, dynamic> sortJson) {
    var list = sortJson['sortbyData'] as List;
    return SortByBaseResponse(title: sortJson['title'], sortbyData: list);
  }
}
