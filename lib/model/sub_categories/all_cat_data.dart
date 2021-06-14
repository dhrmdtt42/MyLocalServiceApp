class AllCatDataModel {
  String parentID;
  String category_type;
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
  var categoryID;

  AllCatDataModel(
      {this.parentID,
      this.category_type,
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
      this.categoryID});

  factory AllCatDataModel.fromJson(Map<String, dynamic> allDataJson) {
    return AllCatDataModel(
        parentID: allDataJson['parentID'],
        category_type: allDataJson['category_type'],
        category_title: allDataJson['category_title'],
        keyword_name: allDataJson['keyword_name'],
        amenities_label_text: allDataJson['amenities_label_text'],
        seo_url: allDataJson['seo_url'],
        category_description: allDataJson['category_description'],
        category_image: allDataJson['category_image'],
        category_banner_image: allDataJson['category_banner_image'],
        seo_title: allDataJson['seo_title'],
        seo_keyword: allDataJson['seo_keyword'],
        seo_description: allDataJson['seo_description'],
        sort_order: allDataJson['sort_order'],
        deletable: allDataJson['deletable'],
        create_date: allDataJson['create_date'],
        modified_date: allDataJson['modified_date'],
        status: allDataJson['status'],
        categoryID: allDataJson['categoryID']);
  }
}
