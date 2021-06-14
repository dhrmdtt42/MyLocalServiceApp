import 'package:flutter/material.dart';
import 'package:haarway_app/model/filters/attribute.dart';
import 'package:haarway_app/model/filters/attribute_value.dart';

class AttributesFilterResponse {
  AttributeFilterData attribute;
  List<AttributeValuesFilterData> attribute_value;

  AttributesFilterResponse({this.attribute, this.attribute_value});

  factory AttributesFilterResponse.fromJson(
      Map<String, dynamic> attFilResJson) {
    var list = attFilResJson['attribute_value'] as List;
    print(list.runtimeType);
    List<AttributeValuesFilterData> attributeValueFilterData =
        list.map((e) => AttributeValuesFilterData.fromJson((e))).toList();
    return AttributesFilterResponse(
        attribute: AttributeFilterData.fromJson(attFilResJson['attribute']),
        attribute_value: attributeValueFilterData);
  }
}
