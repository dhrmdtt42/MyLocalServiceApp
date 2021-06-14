class SubChildCatDataModelRequest {
  String mainCat;
  String categoryID;

  SubChildCatDataModelRequest({this.mainCat, this.categoryID});

  Map<String, dynamic> toJson() => {
        'mainCat': mainCat,
        'categoryID': categoryID,
      };

  factory SubChildCatDataModelRequest.fromJson(Map<String, dynamic> reqJson) {
    return SubChildCatDataModelRequest(
        mainCat: reqJson['mainCat'], categoryID: reqJson['categoryID']);
  }
}
