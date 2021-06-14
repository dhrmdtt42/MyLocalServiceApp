import 'package:haarway_app/model/filters/fliter_data_base_response.dart';
import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';
import 'package:haarway_app/model/home/service_search/service_data_model.dart';

class ServiceSearchBaseResponse {
  String status;
  List<APIParameterData> apiParameterList;
  FilterDataBaseResponse filterData;
  static int number = 0;

  ServiceSearchBaseResponse(
      {this.status, this.apiParameterList, this.filterData});

  factory ServiceSearchBaseResponse.fromJson(Map<String, dynamic> baseJson) {
    var list = baseJson['searchServiceData'] as List;
    print(list.runtimeType);
    List<APIParameterData> serviceDataList =
        list.map((e) => APIParameterData.fromJson(e)).toList();
    return ServiceSearchBaseResponse(
        status: baseJson['status'],
        apiParameterList: serviceDataList,
        filterData: FilterDataBaseResponse.fromJson(baseJson['filterData']));
  }
}
