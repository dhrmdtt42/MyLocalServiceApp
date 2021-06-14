import 'package:haarway_app/model/home/home_improvement/home_improvement_data_model.dart';

class HomeImprovementBaseResponse {
  String status;
  List<HomeImprovementData> homeImprovementDataList;

  HomeImprovementBaseResponse({this.status, this.homeImprovementDataList});

  factory HomeImprovementBaseResponse.fromJson(
      Map<String, dynamic> homeBaseJson) {
    var list = homeBaseJson['homeImprovementsData'] as List;
    print(list.toString());
    List<HomeImprovementData> homeImprovementDataList =
        list.map((e) => HomeImprovementData.fromJson(e)).toList();

    return HomeImprovementBaseResponse(
        status: homeBaseJson['status'],
        homeImprovementDataList: homeImprovementDataList);
  }
}
