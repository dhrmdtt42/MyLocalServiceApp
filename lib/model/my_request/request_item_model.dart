class RequestItemModel {
  String seoUrl;
  String name;
  String mobileNumber;
  String email;
  String message;
  String termsAndPolicy;

  RequestItemModel(
      {this.seoUrl,
      this.name,
      this.mobileNumber,
      this.email,
      this.message,
      this.termsAndPolicy});

  RequestItemModel.fromJson(Map<String, dynamic> json) {
    seoUrl = json['seo_url'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    message = json['message'];
    termsAndPolicy = json['terms_and_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seo_url'] = this.seoUrl;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['message'] = this.message;
    data['terms_and_policy'] = this.termsAndPolicy;
    return data;
  }
}
