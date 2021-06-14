import 'package:flutter/cupertino.dart';
import 'package:haarway_app/model/home/popular_services_category.dart';

class PopularCategoryData {
  String categoryID;
  String parentID;
  String category_title;
  String seo_url;
  String category_description;
  String category_image;
  String category_banner_image;
  String font_awesome;
  String color;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String popular;
  String trending;
  String featured;
  String multiple_category;
  String sort_order;
  String deletable;
  String create_date;
  String modified_date;
  String status;
  List<PopularCategories> categories;

  PopularCategoryData(
      {this.categoryID,
      this.parentID,
      this.category_title,
      this.seo_url,
      this.category_description,
      this.category_image,
      this.category_banner_image,
      this.font_awesome,
      this.color,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.popular,
      this.trending,
      this.featured,
      this.multiple_category,
      this.sort_order,
      this.deletable,
      this.create_date,
      this.modified_date,
      this.status,
      this.categories});

  factory PopularCategoryData.fromJson(Map<String, dynamic> popCatJson) {
    var popList = popCatJson['categories'] as List;
    print(popList.toString());
    List<PopularCategories> popularList =
        popList.map((e) => PopularCategories.fromJson(e)).toList();

    return PopularCategoryData(
        categoryID: popCatJson['categoryID'],
        parentID: popCatJson['parentID'],
        category_title: popCatJson['category_title'],
        seo_url: popCatJson['seo_url'],
        category_description: popCatJson['category_description'],
        category_image: popCatJson['category_image'],
        category_banner_image: popCatJson['category_banner_image'],
        font_awesome: popCatJson['font_awesome'],
        color: popCatJson['color'],
        seo_title: popCatJson['seo_title'],
        seo_keyword: popCatJson['seo_keyword'],
        seo_description: popCatJson['seo_description'],
        popular: popCatJson['popular'],
        trending: popCatJson['trending'],
        featured: popCatJson['featured'],
        multiple_category: popCatJson['multiple_category'],
        sort_order: popCatJson['sort_order'],
        deletable: popCatJson['deletable'],
        create_date: popCatJson['create_date'],
        modified_date: popCatJson['modified_date'],
        status: popCatJson['status'],
        categories: popularList);
  }
}
