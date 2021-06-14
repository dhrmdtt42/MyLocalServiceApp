class MainCategoryData {
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
  String icon_image;
  String mainCat;

  MainCategoryData(
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
      this.icon_image,
      this.mainCat});

  factory MainCategoryData.fromJson(Map<String, dynamic> mainCatJson) {
    return MainCategoryData(
        categoryID: mainCatJson['categoryID'],
        parentID: mainCatJson['parentID'],
        category_title: mainCatJson['category_title'],
        seo_url: mainCatJson['seo_url'],
        category_description: mainCatJson['category_description'],
        category_image: mainCatJson['category_image'],
        category_banner_image: mainCatJson['category_banner_image'],
        font_awesome: mainCatJson['font_awesome'],
        color: mainCatJson['color'],
        seo_title: mainCatJson['seo_title'],
        seo_keyword: mainCatJson['seo_keyword'],
        seo_description: mainCatJson['seo_description'],
        popular: mainCatJson['popular'],
        trending: mainCatJson['trending'],
        featured: mainCatJson['featured'],
        multiple_category: mainCatJson['multiple_category'],
        sort_order: mainCatJson['sort_order'],
        deletable: mainCatJson['deletable'],
        create_date: mainCatJson['craeted_date'],
        modified_date: mainCatJson['modified_date'],
        status: mainCatJson['status'],
        icon_image: mainCatJson['icon_image'],
        mainCat: mainCatJson['mainCat']);
  }
}
