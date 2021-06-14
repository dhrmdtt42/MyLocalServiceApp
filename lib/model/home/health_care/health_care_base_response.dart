import 'package:haarway_app/model/home/health_care/health_care_data_model.dart';

class HealthCareBaseResponse {
  String status;
  List<HealthCareDataModel> healthCareList;

  HealthCareBaseResponse({this.status, this.healthCareList});

  factory HealthCareBaseResponse.fromJson(Map<String, dynamic> healthBaseJson) {
    var list = healthBaseJson['healthCareData'] as List;
    print(list.runtimeType);
    List<HealthCareDataModel> healthCareDataList =
        list.map((e) => HealthCareDataModel.fromJson(e)).toList();

    return HealthCareBaseResponse(
        status: healthBaseJson['healthBaseJson'],
        healthCareList: healthCareDataList);
  }
}
