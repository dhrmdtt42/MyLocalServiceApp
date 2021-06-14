class GetPageModel {
  String status;
  PrivacyData data;

  GetPageModel({this.status, this.data});

  GetPageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new PrivacyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PrivacyData {
  String pageID;
  String seoUrl;
  String bannerImage;
  String bannerImageAlt;
  String bannerHeading;
  String pageHeading;
  String pageContent;
  String seoTitle;
  String seoKeyword;
  String seoDescription;
  String status;
  String deletable;
  String hide;
  String sortOrder;
  String createDate;
  String modifiedDate;

  PrivacyData(
      {this.pageID,
      this.seoUrl,
      this.bannerImage,
      this.bannerImageAlt,
      this.bannerHeading,
      this.pageHeading,
      this.pageContent,
      this.seoTitle,
      this.seoKeyword,
      this.seoDescription,
      this.status,
      this.deletable,
      this.hide,
      this.sortOrder,
      this.createDate,
      this.modifiedDate});

  PrivacyData.fromJson(Map<String, dynamic> json) {
    pageID = json['pageID'];
    seoUrl = json['seo_url'];
    bannerImage = json['banner_image'];
    bannerImageAlt = json['banner_image_alt'];
    bannerHeading = json['banner_heading'];
    pageHeading = json['page_heading'];
    pageContent = json['page_content'];
    seoTitle = json['seo_title'];
    seoKeyword = json['seo_keyword'];
    seoDescription = json['seo_description'];
    status = json['status'];
    deletable = json['deletable'];
    hide = json['hide'];
    sortOrder = json['sort_order'];
    createDate = json['create_date'];
    modifiedDate = json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageID'] = this.pageID;
    data['seo_url'] = this.seoUrl;
    data['banner_image'] = this.bannerImage;
    data['banner_image_alt'] = this.bannerImageAlt;
    data['banner_heading'] = this.bannerHeading;
    data['page_heading'] = this.pageHeading;
    data['page_content'] = this.pageContent;
    data['seo_title'] = this.seoTitle;
    data['seo_keyword'] = this.seoKeyword;
    data['seo_description'] = this.seoDescription;
    data['status'] = this.status;
    data['deletable'] = this.deletable;
    data['hide'] = this.hide;
    data['sort_order'] = this.sortOrder;
    data['create_date'] = this.createDate;
    data['modified_date'] = this.modifiedDate;
    return data;
  }
}
