import 'package:haarway_app/model/filters/attributes_response.dart';
import 'package:haarway_app/model/filters/radius.dart';

class AttributeBaseResponse {
  String title;
  List<AttributesFilterResponse> attributesFilterData;
  AttributeBaseResponse({this.title, this.attributesFilterData});

  factory AttributeBaseResponse.fromJson(Map<String, dynamic> amenJson) {
    var attList = new List();
    var list = amenJson['attributes'] as List;
    if (list != null) {
      List<AttributesFilterResponse> attributesData =
          list.map((e) => AttributesFilterResponse.fromJson(e)).toList();
      attList = attributesData;
    } else {
      attList = list;
    }
    return AttributeBaseResponse(
        title: amenJson['title'], attributesFilterData: attList);
  }
}
