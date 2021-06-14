class ItemCategories {
  String categoryID;
  String category_title;
  String seo_url;

  ItemCategories({this.categoryID, this.category_title, this.seo_url});

  factory ItemCategories.fromJson(Map<String, dynamic> itemCatJson) {
    return ItemCategories(
        categoryID: itemCatJson['categoryID'],
        category_title: itemCatJson['category_title'],
        seo_url: itemCatJson['seo_url']);
  }
}
