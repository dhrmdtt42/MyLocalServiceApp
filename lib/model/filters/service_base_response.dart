import 'package:haarway_app/model/filters/service.dart';

class ServiceBaseResponse {
  String title;
  List<ServiceFilterData> serviceFilterData;

  ServiceBaseResponse({this.title, this.serviceFilterData});

  factory ServiceBaseResponse.fromJson(Map<String, dynamic> amenJson) {
    var list = amenJson['servicesData'] as List;
    List<ServiceFilterData> radiusData =
        list.map((e) => ServiceFilterData.fromJson(e)).toList();

    return ServiceBaseResponse(
        title: amenJson['title'], serviceFilterData: radiusData);
  }
}
