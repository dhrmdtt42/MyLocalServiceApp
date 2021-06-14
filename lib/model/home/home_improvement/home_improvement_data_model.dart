class HomeImprovementData {
  String homeimprovement_categoryID;
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
  String total_items;

  HomeImprovementData(
      {this.homeimprovement_categoryID,
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
      this.total_items});

  factory HomeImprovementData.fromJson(Map<String, dynamic> homeJson) {
    return HomeImprovementData(
        homeimprovement_categoryID: homeJson['homeimprovement_categoryID'],
        parentID: homeJson['parentID'],
        category_title: homeJson['category_title'],
        keyword_name: homeJson['keyword_name'],
        amenities_label_text: homeJson['amenities_label_text'],
        seo_url: homeJson['seo_url'],
        category_description: homeJson['category_description'],
        category_image: homeJson['category_image'],
        category_banner_image: homeJson['category_banner_image'],
        seo_title: homeJson['seo_title'],
        seo_keyword: homeJson['seo_keyword'],
        seo_description: homeJson['seo_description'],
        sort_order: homeJson['sort_order'],
        deletable: homeJson['deletable'],
        create_date: homeJson['create_date'],
        modified_date: homeJson['modified_date'],
        status: homeJson['status'],
        total_items: homeJson['total_items']);
  }
}
