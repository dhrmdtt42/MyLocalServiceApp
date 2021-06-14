import 'dart:convert';

import 'package:haarway_app/model/home/main_categories.dart';

class MainCategoryResponse {
  String status;
  List<MainCategoryData> mainCategory;

  MainCategoryResponse({this.status, this.mainCategory});

  factory MainCategoryResponse.fromJson(Map<String, dynamic> mainCatResJson) {
    var list = mainCatResJson['mainCategoriesData'] as List;
    print(list.runtimeType);
    List<MainCategoryData> mainCategoryList =
        list.map((e) => MainCategoryData.fromJson(e)).toList();
    return MainCategoryResponse(
        status: mainCatResJson['status'], mainCategory: mainCategoryList);
  }
}
