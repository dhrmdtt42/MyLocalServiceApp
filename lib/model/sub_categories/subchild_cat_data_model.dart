class SubChildCatDataModel {
  String keywordID;
  String seo_url;
  String categoryID;
  String name;
  String code;
  String description;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String status;
  String create_date;
  String modified_date;
  String mainCat;

  SubChildCatDataModel(
      {this.keywordID,
      this.seo_url,
      this.categoryID,
      this.name,
      this.code,
      this.description,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.status,
      this.create_date,
      this.modified_date,
      this.mainCat});

  factory SubChildCatDataModel.fromJson(Map<String, dynamic> subChildJson) {
    return SubChildCatDataModel(
        keywordID: subChildJson['keywordID'],
        seo_url: subChildJson['seo_url'],
        categoryID: subChildJson['categoryID'],
        name: subChildJson['name'],
        code: subChildJson['code'],
        description: subChildJson['description'],
        seo_title: subChildJson['seo_title'],
        seo_description: subChildJson['seo_description'],
        status: subChildJson['status'],
        create_date: subChildJson['create_date'],
        modified_date: subChildJson['modified_date'],
        mainCat: subChildJson['main_Cat']);
  }
}
