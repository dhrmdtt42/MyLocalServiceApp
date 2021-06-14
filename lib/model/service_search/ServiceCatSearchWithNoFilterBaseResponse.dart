import 'package:haarway_app/model/service_search/service_cat_search_response_data.dart';
import 'package:haarway_app/model/service_search/single_service_cat_search_response.dart';

class SeriviceCatSearchWithNoFilterBaseResponse {
  String status;
  SingleServiceSearchCatResponseData serviceCatSearchResponseData;

  SeriviceCatSearchWithNoFilterBaseResponse(
      {this.status, this.serviceCatSearchResponseData});

  factory SeriviceCatSearchWithNoFilterBaseResponse.fromJson(
      Map<String, dynamic> serviceJson) {
    return SeriviceCatSearchWithNoFilterBaseResponse(
        status: serviceJson['status'],
        serviceCatSearchResponseData:
            SingleServiceSearchCatResponseData.fromJson(
                serviceJson['searchResultData']));
  }
}
