class TrendingCategories {
  String categoryID;
  String parentID;
  String category_title;
  String keyword_name;
  String amenities_label_text;
  String seo_url;
  String category_description;
  String category_image;
  String category_banner_image;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String sort_order;
  String deletable;
  String create_date;
  String modified_date;
  String status;
  String mainCat;

  TrendingCategories(
      {this.categoryID,
      this.parentID,
      this.category_title,
      this.keyword_name,
      this.amenities_label_text,
      this.seo_url,
      this.category_description,
      this.category_image,
      this.category_banner_image,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.sort_order,
      this.deletable,
      this.create_date,
      this.modified_date,
      this.status,
      this.mainCat});

  factory TrendingCategories.fromJson(Map<String, dynamic> catJson) {
    return TrendingCategories(
        categoryID: catJson['categoryID'],
        parentID: catJson['parentID'],
        category_title: catJson['category_title'],
        keyword_name: catJson['keyword_name'],
        amenities_label_text: catJson['amenities_label_text'],
        seo_url: catJson['seoUrl'],
        category_description: catJson['category_description'],
        category_image: catJson['category_image'],
        category_banner_image: catJson['category_banner_image'],
        seo_title: catJson['seo_title'],
        seo_keyword: catJson['seo_keyword'],
        seo_description: catJson['seo_description'],
        sort_order: catJson['sort_order'],
        deletable: catJson['deletable'],
        create_date: catJson['create_date'],
        modified_date: catJson['modified_date'],
        status: catJson['status'],
        mainCat: catJson['mainCat']);
  }
}
