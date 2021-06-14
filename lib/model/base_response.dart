import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/social_links.dart';

class BaseResponse {
  String status;
  Data data;
  List<SocialLinks> socialLinks;
//  List<SocialLinks> socialResult;

  BaseResponse.info({this.status, this.data, this.socialLinks});
  BaseResponse();
  factory BaseResponse.fromJson(Map<String, dynamic> jsonData) {
    return BaseResponse.info(
      status: jsonData['status'],
      data: Data.fromJson(jsonData['data']),
//      socialLinks: resultList,
    );
  }
}
