import 'dart:core';

class SocialLinks {
  String customerID;
  String socialID;
  String social_url;
  String social_name;
  String font_awesome;
  String sort_order;
  String status;

  SocialLinks(
      {this.customerID,
      this.socialID,
      this.social_url,
      this.social_name,
      this.font_awesome,
      this.sort_order,
      this.status});

  factory SocialLinks.fromJson(Map<String, dynamic> socialData) {
    return SocialLinks(
        customerID: socialData['customerID'],
        socialID: socialData['socialID'],
        social_url: socialData['social_url'],
        social_name: socialData['social_name'],
        font_awesome: socialData['font_awsome'],
        sort_order: socialData['sort_order'],
        status: socialData['status']);
  }
}
