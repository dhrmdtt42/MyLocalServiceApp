import 'package:haarway_app/model/home/popular_services_category.dart';
import 'package:haarway_app/model/responses/popular_cat_data_response.dart';

class PopularServiceCategoryResponse {
  String status;
  List<PopularCategoryData> popularCategoryData;

  PopularServiceCategoryResponse({this.status, this.popularCategoryData});

  factory PopularServiceCategoryResponse.fromJson(
      Map<String, dynamic> popJson) {
    var popList = popJson['popularServiceData'] as List;
    print(popList.toString());
    List<PopularCategoryData> popularCatResList =
        popList.map((e) => PopularCategoryData.fromJson(e)).toList();

    return PopularServiceCategoryResponse(
        status: popJson['status'], popularCategoryData: popularCatResList);
  }
}
