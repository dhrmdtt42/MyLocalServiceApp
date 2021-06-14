import 'package:haarway_app/model/social_links.dart';

class Data {
  String customerID;
  String categoryID;
  String category_title;
  String auth_provider;
  String auth_uid;
  String customer_name;
  String customer_mobile;
  String customer_business_number;
  String customer_email;
  String customer_short_bio;
  String customer_about_me;
  String customer_profile_photo;
  String customer_gender;
  String customer_date_of_birth;
  String countries_id;
  String zone_i;
  String city_id;
  String customer_locality;
  String customer_zipcode;
  String customer_Password;
  String website;
  String reset_key;
  String mobile_activated;
  String email_activated;
  String create_date;
  String modified_date;
  String customer_status;
  String countries_name;
  String zone_name;
  String city_name;
  List<SocialLinks> socialLinks;

  Data(
      {this.customerID,
      this.categoryID,
      this.category_title,
      this.auth_provider,
      this.auth_uid,
      this.customer_name,
      this.customer_mobile,
      this.customer_business_number,
      this.customer_email,
      this.customer_short_bio,
      this.customer_about_me,
      this.customer_profile_photo,
      this.customer_gender,
      this.customer_date_of_birth,
      this.countries_id,
      this.zone_i,
      this.city_id,
      this.customer_locality,
      this.customer_zipcode,
      this.customer_Password,
      this.website,
      this.reset_key,
      this.mobile_activated,
      this.email_activated,
      this.create_date,
      this.modified_date,
      this.customer_status,
      this.countries_name,
      this.zone_name,
      this.city_name,
      this.socialLinks});

  factory Data.fromJson(Map<String, dynamic> dataJson) {
    var list = dataJson['social_links'] as List;
    print(list.runtimeType);
    List<SocialLinks> resultList =
        list.map((i) => SocialLinks.fromJson(i)).toList();
    print(resultList);
    return Data(
        customerID: dataJson['customerID'],
        categoryID: dataJson['categoryID'],
        category_title: dataJson['category_title'],
        auth_provider: dataJson['auth_provider'],
        auth_uid: dataJson['auth_uid'],
        customer_name: dataJson['customer_name'],
        customer_mobile: dataJson['customer_mobile'],
        customer_business_number: dataJson['customer_business_number'],
        customer_email: dataJson['customer_email'],
        customer_short_bio: dataJson['customer_short_bio'],
        customer_about_me: dataJson['customer_about_me'],
        customer_profile_photo: dataJson['customer_profile_photo'],
        customer_gender: dataJson['customer_gender'],
        customer_date_of_birth: dataJson['customer_date_of_birth'],
        countries_id: dataJson['countries_id'],
        zone_i: dataJson['zone_i'],
        city_id: dataJson['city_id'],
        customer_locality: dataJson['customer_locality'],
        customer_zipcode: dataJson['customer_zipcode'],
        customer_Password: dataJson['customer_Password'],
        website: dataJson['website'],
        reset_key: dataJson['reset_key'],
        mobile_activated: dataJson['mobile_activated'],
        email_activated: dataJson['email_activated'],
        create_date: dataJson['create_date'],
        modified_date: dataJson['modified_date'],
        customer_status: dataJson['customer_status'],
        countries_name: dataJson['countries_name'],
        zone_name: dataJson['zone_name'],
        city_name: dataJson['city_name'],
        socialLinks: resultList);
  }

  Map<String, dynamic> toJson() => {
        'customerID': customerID,
        'categoryID': categoryID,
        'category_title': category_title,
        'auth_provider': auth_provider,
        'auth_uid': auth_uid,
        'customer_name': customer_name,
        'customer_mobile': customer_mobile,
        'customer_business_number': customer_business_number,
        'customer_email': customer_email,
        'customer_short_bio': customer_short_bio,
        'customer_about_me': customer_about_me,
        'customer_profile_photo': customer_profile_photo,
        'customer_gender': customer_gender,
        'customer_date_of_birth': customer_date_of_birth,
        'countries_id': countries_id,
        'zone_i': zone_i,
        'city_id': city_id,
        'customer_locality': customer_locality,
        'customer_zipcode': customer_zipcode,
        'customer_Password': customer_Password,
        'website': website,
        'reset_key': reset_key,
        'mobile_activated': mobile_activated,
        'email_activated': email_activated,
        'create_date': create_date,
        'modified_date': modified_date,
        'customer_status': customer_status,
        'countries_name': countries_name,
        'zone_name': zone_name,
        'city_name': city_name,
        "socialLinks": socialLinks
      };
}
