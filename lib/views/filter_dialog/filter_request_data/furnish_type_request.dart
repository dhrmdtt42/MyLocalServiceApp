class FurnishTypeRequest {
  List<Furnishingtypes> furnishingtypes;

  FurnishTypeRequest({this.furnishingtypes});

  FurnishTypeRequest.fromJson(Map<String, dynamic> json) {
    if (json['furnishingtypes'] != null) {
      furnishingtypes = new List<Furnishingtypes>();
      json['furnishingtypes'].forEach((v) {
        furnishingtypes.add(new Furnishingtypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.furnishingtypes != null) {
      data['furnishingtypes'] =
          this.furnishingtypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Furnishingtypes {
  String name;

  Furnishingtypes({this.name});

  Furnishingtypes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
