import 'package:haarway_app/model/service_search/item_data_model.dart';
import 'package:haarway_app/model/service_search/item_details_data_model.dart';
import 'package:haarway_app/model/service_search/item_page_data_model.dart';

class SingleServiceSearchCatResponseData {
  PageDataModel page;
  int total_items;
  SearchItemDetailsModel items;

  SingleServiceSearchCatResponseData({this.page, this.total_items, this.items});

  factory SingleServiceSearchCatResponseData.fromJson(
      Map<String, dynamic> singleCatJson) {
    return SingleServiceSearchCatResponseData(
        page: PageDataModel.fromJson(singleCatJson['page']),
        total_items: singleCatJson['total_items'],
        items: SearchItemDetailsModel.fromJson(singleCatJson['items']));
  }
}
