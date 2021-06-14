import 'package:haarway_app/model/filters/fliter_data_base_response.dart';
import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';
import 'package:haarway_app/model/service_search/service_cat_search_response_data.dart';

class ServiceCatSearchBaseResponse {
  String status;
  ServiceCatSearchResponseData serviceCatSearchResponseData;
  FilterDataBaseResponse filterData;
//  static int number = 0;

  ServiceCatSearchBaseResponse(
      {this.status, this.serviceCatSearchResponseData, this.filterData});

  factory ServiceCatSearchBaseResponse.fromJson(
      Map<String, dynamic> baseSearchJson) {
//    var list = baseSearchJson['searchServiceData'] as List;
//    print(list.runtimeType);
//    List<APIParameterData> serviceDataList =
//    list.map((e) => APIParameterData.fromJson(e)).toList();
    return ServiceCatSearchBaseResponse(
        status: baseSearchJson['status'],
        serviceCatSearchResponseData: ServiceCatSearchResponseData.fromJson(
            baseSearchJson['searchResultData']),
        filterData:
            FilterDataBaseResponse.fromJson(baseSearchJson['filterData']));
  }
}
