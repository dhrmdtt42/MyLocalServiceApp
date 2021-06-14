import 'package:haarway_app/model/home/trending_services/trending_categories.dart';

class TrendingServicesData {
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
  List<TrendingCategories> categories;

  TrendingServicesData(
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

  factory TrendingServicesData.fromJson(Map<String, dynamic> trenCatJson) {
    var popList = trenCatJson['categories'] as List;
    print(popList.toString());
    List<TrendingCategories> popularList =
        popList.map((e) => TrendingCategories.fromJson(e)).toList();

    return TrendingServicesData(
        categoryID: trenCatJson['categoryID'],
        parentID: trenCatJson['parentID'],
        category_title: trenCatJson['category_title'],
        seo_url: trenCatJson['seo_url'],
        category_description: trenCatJson['category_description'],
        category_image: trenCatJson['category_image'],
        category_banner_image: trenCatJson['category_banner_image'],
        font_awesome: trenCatJson['font_awesome'],
        color: trenCatJson['color'],
        seo_title: trenCatJson['seo_title'],
        seo_keyword: trenCatJson['seo_keyword'],
        seo_description: trenCatJson['seo_description'],
        popular: trenCatJson['popular'],
        trending: trenCatJson['trending'],
        featured: trenCatJson['featured'],
        multiple_category: trenCatJson['multiple_category'],
        sort_order: trenCatJson['sort_order'],
        deletable: trenCatJson['deletable'],
        create_date: trenCatJson['create_date'],
        modified_date: trenCatJson['modified_date'],
        status: trenCatJson['status'],
        categories: popularList);
  }
}
