import 'package:flutter/material.dart';
import 'package:haarway_app/model/service_search/item_popular_cities.dart';

class ItemPopularServices {
  String keywordID;
  String name;
  String seo_url;
  List<ItemPopularCities> popularcities;

  ItemPopularServices(
      {this.keywordID, this.name, this.seo_url, this.popularcities});

  factory ItemPopularServices.fromJson(Map<String, dynamic> popJson) {
    var list = popJson['popularcities'] as List;
    print(list.runtimeType);
    List<ItemPopularCities> popularCityItems =
        list.map((e) => ItemPopularCities.fromJson(e)).toList();

    return ItemPopularServices(
        keywordID: popJson['keywordID'],
        name: popJson['name'],
        seo_url: popJson['seo_url'],
        popularcities: popularCityItems);
  }
}
