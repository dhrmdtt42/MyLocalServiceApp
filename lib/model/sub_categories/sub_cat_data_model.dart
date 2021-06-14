class SubCatDataModel {
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

  SubCatDataModel(
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

  factory SubCatDataModel.fromJson(Map<String, dynamic> subcatJson) {
    return SubCatDataModel(
        categoryID: subcatJson['categoryID'],
        parentID: subcatJson['parentID'],
        category_title: subcatJson['category_title'],
        keyword_name: subcatJson['keyword_name'],
        amenities_label_text: subcatJson['amenities_label_text'],
        seo_url: subcatJson['seo_url'],
        category_description: subcatJson['category_description'],
        category_image: subcatJson['category_image'],
        category_banner_image: subcatJson['category_banner_image'],
        seo_title: subcatJson['seo_title'],
        seo_keyword: subcatJson['seo_keyword'],
        seo_description: subcatJson['seo_description'],
        sort_order: subcatJson['sort_order'],
        deletable: subcatJson['deletable'],
        create_date: subcatJson['create_date'],
        modified_date: subcatJson['modified_date'],
        status: subcatJson['status'],
        mainCat: subcatJson['mainCat']);
  }
}
