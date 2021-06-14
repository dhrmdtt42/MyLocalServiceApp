import 'package:haarway_app/model/service_search/item_data_model.dart';
import 'package:haarway_app/model/service_search/item_details_data_model.dart';
import 'package:haarway_app/model/service_search/item_page_data_model.dart';

class ServiceCatSearchResponseData {
  PageDataModel page;
  int total_items;
  List<SearchItemDataModel> items;
  final List<SearchItemDataModel> serviceItemlist;
  ServiceCatSearchResponseData(
      {this.page, this.total_items, this.items, this.serviceItemlist});

  factory ServiceCatSearchResponseData.fromJson(
      Map<String, dynamic> serviceCatJson) {
//    List<SearchItemDataModel> serviceItemlist = new List<SearchItemDataModel>();
    var list = serviceCatJson['items'] as List;
//    if (list.isNotEmpty) {
    print(list.runtimeType);
    List<SearchItemDataModel> serviceItemlist =
        list.map((e) => SearchItemDataModel.fromJson(e)).toList();
//    }
    return ServiceCatSearchResponseData(
        page: PageDataModel.fromJson(serviceCatJson['page']),
        total_items: serviceCatJson['total_items'],
        items: serviceItemlist);
  }
}
