import 'package:haarway_app/model/home/home_improvement/home_improvement_data_model.dart';
import 'package:haarway_app/model/home/home_offices/home_office_data_model.dart';

class HomeOfficeBaseResponse {
  String status;
  List<HomeOfficeDataModel> homeOfficeDataList;

  HomeOfficeBaseResponse({this.status, this.homeOfficeDataList});

  factory HomeOfficeBaseResponse.fromJson(Map<String, dynamic> homeBaseJson) {
    var list = homeBaseJson['homeOfficeData'] as List;
    print(list.runtimeType);
    List<HomeOfficeDataModel> homeOfficeListData =
        list.map((e) => HomeOfficeDataModel.fromJson(e)).toList();

    return HomeOfficeBaseResponse(
        status: homeBaseJson['status'], homeOfficeDataList: homeOfficeListData);
  }
}
