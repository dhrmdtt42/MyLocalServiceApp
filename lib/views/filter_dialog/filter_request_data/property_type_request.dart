class PropertyTypeRequest {
  List<Propertytypes> propertytypes;

  PropertyTypeRequest({this.propertytypes});

  PropertyTypeRequest.fromJson(Map<String, dynamic> json) {
    if (json['propertytypes'] != null) {
      propertytypes = new List<Propertytypes>();
      json['propertytypes'].forEach((v) {
        propertytypes.add(new Propertytypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertytypes != null) {
      data['propertytypes'] =
          this.propertytypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Propertytypes {
  String propertytypeID;

  Propertytypes({this.propertytypeID});

  Propertytypes.fromJson(Map<String, dynamic> json) {
    propertytypeID = json['propertytypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertytypeID'] = this.propertytypeID;
    return data;
  }
}
