class SubCatDataRequestModel {
  String mainCat;
  String parentID;

  SubCatDataRequestModel({this.mainCat, this.parentID});

  Map<String, dynamic> toJson() => {
        'mainCat': mainCat,
        'parentID': parentID,
      };

  factory SubCatDataRequestModel.fromJson(Map<String, dynamic> reqJson) {
    return SubCatDataRequestModel(
        mainCat: reqJson['mainCat'], parentID: reqJson['parentID']);
  }
}
