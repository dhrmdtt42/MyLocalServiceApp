import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';

class SingleServiceSearchBaseResponse {
  String status;
  List<APIParameterData> searchServiceData;

  SingleServiceSearchBaseResponse({this.status, this.searchServiceData});

  factory SingleServiceSearchBaseResponse.fromJson(
      Map<String, dynamic> singleSearchJson) {
    var list = singleSearchJson['searchServiceData'] as List;
    List<APIParameterData> searchServiceDataList =
        list.map((e) => APIParameterData.fromJson(e)).toList();

    return SingleServiceSearchBaseResponse(
        status: singleSearchJson['status'],
        searchServiceData: searchServiceDataList);
  }
}
