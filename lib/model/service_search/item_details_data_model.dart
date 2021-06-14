import 'package:flutter/material.dart';
import 'package:haarway_app/model/service_search/item_categories.dart';
import 'package:haarway_app/model/service_search/item_popular_services.dart';
import 'package:haarway_app/model/service_search/item_related_services_data.dart';
import 'package:haarway_app/model/service_search/item_service_data.dart';
import 'package:haarway_app/model/service_search/mode_of_payment.dart';
import 'package:haarway_app/model/service_search/user_review.dart';
import 'package:haarway_app/model/service_search/working_hours_model.dart';

class SearchItemDetailsModel {
  String ID;
  String categoryID;
  String keywordID;
  String customerID;
  String business_number;
  String business_email;
  String businesstypeID;
  String name;
  String seo_url;
  String city;
  String city_id;
  String location;
  String near_by;
  String latitude;
  String longitude;
  String house_number;
  String street_number;
  String route;
  String locality;
  String state;
  String postal_code;
  String country;
  String logo;
  String image;
  String header_image;
  String description;
  String status;
  String open_status;
  String seo_title;
  String seo_keyword;
  String meta_keyword;
  String seo_description;
  String sort_order;
//  String categories;
  List<dynamic> additional_images;
  List<WorkingHoursDataModel> working_hours;
  String year_established;
  List<ModeOfPayments> modes_of_payment;
  List<ItemCategories> categories;
  List<ItemServiceData> services;
  List<UserReview> reviews;
  List<ItemRelatedServices> related_services;
  List<ItemPopularServices> popular_services;
  String website;
  String create_date;
  String modified_date;
  var average_review;
  String review_count;
  String customer_email;
  String customer_mobile;
  String customer_business_number;
  String category_title;
  String font_awesome;
  String color;
  String distance;

  SearchItemDetailsModel(
      {this.ID,
      this.categoryID,
      this.keywordID,
      this.customerID,
      this.business_email,
      this.business_number,
      this.businesstypeID,
      this.name,
      this.seo_url,
      this.city,
      this.city_id,
      this.location,
      this.near_by,
      this.latitude,
      this.longitude,
      this.house_number,
      this.street_number,
      this.route,
      this.locality,
      this.state,
      this.postal_code,
      this.country,
      this.logo,
      this.image,
      this.header_image,
      this.description,
      this.status,
      this.open_status,
      this.seo_title,
      this.seo_keyword,
      this.meta_keyword,
      this.seo_description,
      this.sort_order,
      this.categories,
      this.additional_images,
      this.working_hours,
      this.year_established,
      this.modes_of_payment,
      this.popular_services,
      this.related_services,
      this.reviews,
      this.services,
      this.website,
      this.create_date,
      this.modified_date,
      this.average_review,
      this.review_count,
      this.customer_email,
      this.customer_mobile,
      this.customer_business_number,
      this.category_title,
      this.font_awesome,
      this.color,
      this.distance});

  factory SearchItemDetailsModel.fromJson(Map<dynamic, dynamic> itemJson) {
    var wList = itemJson['working_hours'] as List;
    var pList = itemJson['modes_of_payment'] as List;
    var iCatList = itemJson['categories'] as List;
    var iservList = itemJson['services'] as List;
    var rServList = itemJson['related_services'] as List;
    var pServList = itemJson['popular_services'] as List;
    var uReviews = itemJson['reviews'] as List;
    print(iCatList.runtimeType);
    print(iservList.runtimeType);
    print(rServList.runtimeType);
    print(wList.runtimeType);
    print(pList.runtimeType);
    List<WorkingHoursDataModel> wHrList =
        wList.map((e) => WorkingHoursDataModel.fromJson(e)).toList();
    List<ModeOfPayments> mpList =
        pList.map((e) => ModeOfPayments.fromJson(e)).toList();

    List<ItemCategories> iCategoryList =
        iCatList.map((e) => ItemCategories.fromJson(e)).toList();
    List<ItemServiceData> iServiceList =
        iservList.map((e) => ItemServiceData.fromJson(e)).toList();
    List<ItemRelatedServices> rServiceList =
        rServList.map((e) => ItemRelatedServices.fromJson(e)).toList();
    List<ItemPopularServices> pServiceList =
        pServList.map((e) => ItemPopularServices.fromJson(e)).toList();
    List<UserReview> reviews =
        uReviews.map((e) => UserReview.fromJson(e)).toList();

    return SearchItemDetailsModel(
      ID: itemJson['ID'],
      categoryID: itemJson['categoryID'],
      keywordID: itemJson['keywordID'],
      customerID: itemJson['cutomerID'],
      business_email: itemJson['business_email'],
      business_number: itemJson['business_number'],
      businesstypeID: itemJson['businesstypeID'],
      name: itemJson['name'],
      seo_url: itemJson['seo_url'],
      city_id: itemJson['city_id'],
      location: itemJson['location'],
      near_by: itemJson['near_by'],
      latitude: itemJson['latitude'],
      longitude: itemJson['longitude'],
      house_number: itemJson['house_number'],
      street_number: itemJson['street_number'],
      route: itemJson['route'],
      locality: itemJson['locality'],
      state: itemJson['state'],
      postal_code: itemJson['postal_code'],
      country: itemJson['country'],
      logo: itemJson['logo'],
      image: itemJson['image'],
      header_image: itemJson['header_image'],
      description: itemJson['description'],
      status: itemJson['status'],
      open_status: itemJson['open_status'],
      sort_order: itemJson['sort_order'],
      categories: iCategoryList,
      additional_images: itemJson['additional_images'] as List,
      working_hours: wHrList,
      services: iServiceList,
      related_services: rServiceList,
      popular_services: pServiceList,
      reviews: reviews,
      year_established: itemJson['year_established'],
      modes_of_payment: mpList,
      website: itemJson['website'],
      create_date: itemJson['create_date'],
      modified_date: itemJson['modified_date'],
      average_review: itemJson['average_review'],
      review_count: itemJson['total_reviews'],
      customer_email: itemJson['customer_email'],
      customer_business_number: itemJson['customer_business_number'],
      category_title: itemJson['category_title'],
      font_awesome: itemJson['font_awesome'],
      color: itemJson['color'],
      distance: itemJson['distance'],
    );
  }
}
