class CategoryResponse {
  ResCategories categories;

  CategoryResponse({this.categories});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new ResCategories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.toJson();
    }
    return data;
  }
}

class ResCategories {
  String title;
  List<ResCategoryData> categoryData;

  ResCategories({this.title, this.categoryData});

  ResCategories.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['categoryData'] != null) {
      categoryData = new List<ResCategoryData>();
      json['categoryData'].forEach((v) {
        categoryData.add(new ResCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.categoryData != null) {
      data['categoryData'] = this.categoryData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResCategoryData {
  String categoryID;
  String parentID;
  String categoryTitle;
  String keywordName;
  String amenitiesLabelText;
  String seoUrl;
  String categoryDescription;
  String categoryImage;
  String categoryBannerImage;
  String categoryImageAlt;
  String categoryBannerImageAlt;
  String seoTitle;
  String seoKeyword;
  String seoDescription;
  String sortOrder;
  String deletable;
  String createDate;
  String modifiedDate;
  String status;

  ResCategoryData(
      {this.categoryID,
      this.parentID,
      this.categoryTitle,
      this.keywordName,
      this.amenitiesLabelText,
      this.seoUrl,
      this.categoryDescription,
      this.categoryImage,
      this.categoryBannerImage,
      this.categoryImageAlt,
      this.categoryBannerImageAlt,
      this.seoTitle,
      this.seoKeyword,
      this.seoDescription,
      this.sortOrder,
      this.deletable,
      this.createDate,
      this.modifiedDate,
      this.status});

  ResCategoryData.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    parentID = json['parentID'];
    categoryTitle = json['category_title'];
    keywordName = json['keyword_name'];
    amenitiesLabelText = json['amenities_label_text'];
    seoUrl = json['seo_url'];
    categoryDescription = json['category_description'];
    categoryImage = json['category_image'];
    categoryBannerImage = json['category_banner_image'];
    categoryImageAlt = json['category_image_alt'];
    categoryBannerImageAlt = json['category_banner_image_alt'];
    seoTitle = json['seo_title'];
    seoKeyword = json['seo_keyword'];
    seoDescription = json['seo_description'];
    sortOrder = json['sort_order'];
    deletable = json['deletable'];
    createDate = json['create_date'];
    modifiedDate = json['modified_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryID'] = this.categoryID;
    data['parentID'] = this.parentID;
    data['category_title'] = this.categoryTitle;
    data['keyword_name'] = this.keywordName;
    data['amenities_label_text'] = this.amenitiesLabelText;
    data['seo_url'] = this.seoUrl;
    data['category_description'] = this.categoryDescription;
    data['category_image'] = this.categoryImage;
    data['category_banner_image'] = this.categoryBannerImage;
    data['category_image_alt'] = this.categoryImageAlt;
    data['category_banner_image_alt'] = this.categoryBannerImageAlt;
    data['seo_title'] = this.seoTitle;
    data['seo_keyword'] = this.seoKeyword;
    data['seo_description'] = this.seoDescription;
    data['sort_order'] = this.sortOrder;
    data['deletable'] = this.deletable;
    data['create_date'] = this.createDate;
    data['modified_date'] = this.modifiedDate;
    data['status'] = this.status;
    return data;
  }
}
