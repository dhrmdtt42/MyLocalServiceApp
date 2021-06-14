import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';

class ServiceDataModel {
  String name;
  String api_url;
  String api_method;
  APIParameterData api_parameter;

  ServiceDataModel(
      {this.name, this.api_url, this.api_method, this.api_parameter});

  factory ServiceDataModel.fromJson(Map<String, dynamic> serviceJson) {
    return ServiceDataModel(
        name: serviceJson['name'],
        api_method: serviceJson['api_method'],
        api_url: serviceJson['api_url'],
        api_parameter: APIParameterData.fromJson(serviceJson['api_parameter']));
  }
}
