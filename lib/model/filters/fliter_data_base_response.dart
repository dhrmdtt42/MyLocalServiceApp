import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/amenitites_base_response.dart';
import 'package:haarway_app/model/filters/attribute_base_response.dart';
import 'package:haarway_app/model/filters/attributes_response.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/locality_base_response.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/model/filters/radius_base_response.dart';
import 'package:haarway_app/model/filters/service.dart';
import 'package:haarway_app/model/filters/service_base_response.dart';
import 'package:haarway_app/model/filters/sortby_base_response.dart';
import 'package:haarway_app/model/service_search/category_response.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/cat_reqst.dart';

class FilterDataBaseResponse {
  SortByBaseResponse sortBy;
  RadiusBase radius;
  ResCategories categoryBaseResponse;
  ServiceBaseResponse serviceBaseResponse;
  AmenintiesBaseResponse amenintiesBaseResponse;
  LocalityBaseResponse localityBaseResponse;
  List<AttributesFilterResponse> attributes;
//  AttributeBaseResponse attributeBaseResponse;
//  List<CategoryFilterData> categories;
//  List<ServiceFilterData> services;
//  List<AmenitiesFilterData> amenities;
//  List<LocalityFilterData> locality;

  FilterDataBaseResponse(
      {this.sortBy,
      this.radius,
      this.categoryBaseResponse,
      this.serviceBaseResponse,
      this.amenintiesBaseResponse,
      this.localityBaseResponse,
      this.attributes});

  factory FilterDataBaseResponse.fromJson(Map<String, dynamic> filterJson) {
//    var list1 = filterJson['categories'] as List;
//    List<CategoryFilterData> categoryData =
//        list1.map((e) => CategoryFilterData.fromJson(e)).toList();
//
//    var list2 = filterJson['services'] as List;
//    List<ServiceFilterData> servicesData =
//        list2.map((e) => ServiceFilterData.fromJson(e)).toList();
//
//    var list3 = filterJson['amenities'] as List;
//    List<AmenitiesFilterData> amenitiesData =
//        list3.map((e) => AmenitiesFilterData.fromJson(e)).toList();
//
//    var list4 = filterJson['locality'] as List;
//    List<LocalityFilterData> localitydata =
//        list4.map((e) => LocalityFilterData.fromJson(e)).toList();
//
    var list5 = filterJson['attributes'] as List;
    List<AttributesFilterResponse> attributesData =
        list5.map((e) => AttributesFilterResponse.fromJson(e)).toList();

    return FilterDataBaseResponse(
        sortBy: SortByBaseResponse.fromJson(filterJson['sortby']),
        radius: RadiusBase.fromJson(filterJson['radius']),
        categoryBaseResponse: ResCategories.fromJson(filterJson['categories']),
        serviceBaseResponse:
            ServiceBaseResponse.fromJson(filterJson['services']),
        amenintiesBaseResponse:
            AmenintiesBaseResponse.fromJson(filterJson['amenities']),
        localityBaseResponse:
            LocalityBaseResponse.fromJson(filterJson['locality']),
        attributes: attributesData);
  }
}
