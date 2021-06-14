class HealthCareDataModel {
  String healthandcare_categoryID;
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

  HealthCareDataModel(
      {this.healthandcare_categoryID,
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

  factory HealthCareDataModel.fromJson(Map<String, dynamic> healthJsonData) {
    return HealthCareDataModel(
        healthandcare_categoryID: healthJsonData['healthandcare_categoryID'],
        parentID: healthJsonData['parentID'],
        category_title: healthJsonData['category_title'],
        keyword_name: healthJsonData['keyword_name'],
        amenities_label_text: healthJsonData['amenities_label_text'],
        seo_url: healthJsonData['seoUrl'],
        category_description: healthJsonData['category_description'],
        category_image: healthJsonData['category_image'],
        category_banner_image: healthJsonData['category_banner_image'],
        seo_title: healthJsonData['seo_title'],
        seo_keyword: healthJsonData['seo_keyword'],
        seo_description: healthJsonData['seo_description'],
        sort_order: healthJsonData['sort_order'],
        deletable: healthJsonData['deletable'],
        create_date: healthJsonData['create_date'],
        modified_date: healthJsonData['modified_date'],
        status: healthJsonData['status'],
        total_items: healthJsonData['total_items']);
  }
}
