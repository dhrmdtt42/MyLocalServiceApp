import 'package:haarway_app/model/home/city_search/city_data_model.dart';

class CityBaseResponse {
  String status;
  List<CityDataModel> cities;

  CityBaseResponse({this.status, this.cities});

  factory CityBaseResponse.fromJson(Map<String, dynamic> cityBaseJson) {
    var list = cityBaseJson['data'] as List;
    print(list.runtimeType);
    List<CityDataModel> cityList =
        list.map((e) => CityDataModel.fromJson(e)).toList();
    return CityBaseResponse(
      status: cityBaseJson['status'],
      cities: cityList,
    );
  }
}
