import 'package:haarway_app/model/sub_categories/subchild_cat_data_model.dart';

class SubChildCatBaseResponse {
  String status;
  List<SubChildCatDataModel> subChildCatList;

  SubChildCatBaseResponse({this.status, this.subChildCatList});

  factory SubChildCatBaseResponse.fromJson(Map<String, dynamic> subBaseJson) {
    var list = subBaseJson['data'] as List;
    print(list.runtimeType);
    List<SubChildCatDataModel> subchildDataItemList =
        list.map((e) => SubChildCatDataModel.fromJson(e)).toList();

    return SubChildCatBaseResponse(
        status: subBaseJson['status'], subChildCatList: subchildDataItemList);
  }
}
