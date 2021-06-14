import 'package:haarway_app/model/home/trending_services/trending_servies_data_model.dart';

class TrendingServicesBaseResponse {
  String status;
  List<TrendingServicesData> trendingServices;

  TrendingServicesBaseResponse({this.status, this.trendingServices});

  factory TrendingServicesBaseResponse.fromJson(
      Map<String, dynamic> trendBaseJson) {
    var list = trendBaseJson['trendingData'] as List;
    print(list.runtimeType);
    List<TrendingServicesData> trendingServicesDataList =
        list.map((e) => TrendingServicesData.fromJson(e)).toList();
    return TrendingServicesBaseResponse(
        status: trendBaseJson['status'],
        trendingServices: trendingServicesDataList);
  }
}
