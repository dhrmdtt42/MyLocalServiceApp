import 'package:flutter/material.dart';

class ServiceFilterData {
  String keywordID;
  String seo_url;
  String categoryID;
  String name;
  String code;
  String description;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String status;
  String create_date;
  String modified_date;

  ServiceFilterData(
      {this.keywordID,
      this.seo_url,
      this.categoryID,
      this.name,
      this.code,
      this.description,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.status,
      this.create_date,
      this.modified_date});

  factory ServiceFilterData.fromJson(Map<String, dynamic> serviceJson) {
    return ServiceFilterData(
        keywordID: serviceJson['keywordID'],
        seo_url: serviceJson['seo_url'],
        categoryID: serviceJson['categoryID'],
        name: serviceJson['name'],
        code: serviceJson['code'],
        description: serviceJson['description'],
        seo_title: serviceJson['seo_title'],
        seo_keyword: serviceJson['seo_keyword'],
        seo_description: serviceJson['seo_description'],
        status: serviceJson['status'],
        create_date: serviceJson['create_date'],
        modified_date: serviceJson['modified_date']);
  }

  Map<String, dynamic> toJson() => {
        'keywordID': keywordID,
        'seo_url': seo_url,
        'categoryID': categoryID,
        'name': name,
        "code": code,
        'description': description,
        'seo_title': seo_url,
        'seo_keyword': seo_keyword,
        'seo_description': seo_description,
        'status': status,
        'create_date': create_date,
        'modified_date': modified_date
      };
}
