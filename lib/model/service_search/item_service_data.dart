class ItemServiceData {
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

  ItemServiceData(
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
      this.modified_date});

  factory ItemServiceData.fromJson(Map<String, dynamic> itemservJson) {
    return ItemServiceData(
        keywordID: itemservJson['keywordID'],
        seo_url: itemservJson['seo_url'],
        categoryID: itemservJson['categoryID'],
        name: itemservJson['name'],
        code: itemservJson['code'],
        description: itemservJson['description'],
        seo_title: itemservJson['seo_title'],
        seo_keyword: itemservJson['seo_keyword'],
        seo_description: itemservJson['seo_description'],
        status: itemservJson['status'],
        create_date: itemservJson['create_date'],
        modified_date: itemservJson['modified_date']);
  }
}
