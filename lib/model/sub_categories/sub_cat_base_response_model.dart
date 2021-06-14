import 'package:haarway_app/model/sub_categories/sub_cat_data_model.dart';
import 'package:haarway_app/model/sub_categories/all_cat_data.dart';

class SubCatBaseResponseDataModel {
  String status;
  AllCatDataModel allCatDataModel;
  List<SubCatDataModel> subCatDataList;

  SubCatBaseResponseDataModel(
      {this.status, this.allCatDataModel, this.subCatDataList});

  factory SubCatBaseResponseDataModel.fromJson(
      Map<String, dynamic> subcatJson) {
    var list = subcatJson['subCategoriesData'] as List;
    print(list.runtimeType);
    List<SubCatDataModel> subCatDataItemList =
        list.map((e) => SubCatDataModel.fromJson(e)).toList();

    return SubCatBaseResponseDataModel(
        status: subcatJson['status'],
        allCatDataModel: AllCatDataModel.fromJson(subcatJson['all_cat_data']),
        subCatDataList: subCatDataItemList);
  }
}
