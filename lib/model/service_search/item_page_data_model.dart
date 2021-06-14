class PageDataModel {
  String page_content;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String page_heading;

  PageDataModel(
      {this.page_content,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.page_heading});

  factory PageDataModel.fromJson(Map<String, dynamic> pageJson) {
    return PageDataModel(
        page_content: pageJson['page_content'],
        seo_title: pageJson['seo_title'],
        seo_keyword: pageJson['seo_keyword'],
        seo_description: pageJson['seo_description'],
        page_heading: pageJson['page_heading']);
  }
}
