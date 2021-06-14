import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/radius.dart';

class LocalityBaseResponse {
  String title;
  List<LocalityFilterData> localityFilterData;

  LocalityBaseResponse({this.title, this.localityFilterData});

  factory LocalityBaseResponse.fromJson(Map<String, dynamic> amenJson) {
    var list = amenJson['localityData'] as List;
    List<LocalityFilterData> LocalityData =
        list.map((e) => LocalityFilterData.fromJson(e)).toList();
    return LocalityBaseResponse(
        title: amenJson['title'], localityFilterData: LocalityData);
  }
}
