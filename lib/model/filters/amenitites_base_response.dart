import 'package:haarway_app/model/filters/amenities.dart';

class AmenintiesBaseResponse {
  String title;
  List<AmenitiesFilterData> amenitiesFilterData;

  AmenintiesBaseResponse({this.title, this.amenitiesFilterData});

  factory AmenintiesBaseResponse.fromJson(Map<String, dynamic> amenJson) {
    var list3 = amenJson['facilitiesData'] as List;
    List<AmenitiesFilterData> amenitiesData =
        list3.map((e) => AmenitiesFilterData.fromJson(e)).toList();

    return AmenintiesBaseResponse(
        title: amenJson['title'], amenitiesFilterData: amenitiesData);
  }
}
