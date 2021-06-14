class CategoryRequest {
  List<ReqCategories> categories;

  CategoryRequest({this.categories});

  CategoryRequest.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<ReqCategories>();
      json['categories'].forEach((v) {
        categories.add(new ReqCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReqCategories {
  String categoryID;

  ReqCategories({this.categoryID});

  ReqCategories.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryID'] = this.categoryID;
    return data;
  }
}
