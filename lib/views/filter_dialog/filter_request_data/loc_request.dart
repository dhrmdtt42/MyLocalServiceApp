class LocalityRequest {
  List<Localities> localities;

  LocalityRequest({this.localities});

  LocalityRequest.fromJson(Map<String, dynamic> json) {
    if (json['localities'] != null) {
      localities = new List<Localities>();
      json['localities'].forEach((v) {
        localities.add(new Localities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localities != null) {
      data['localities'] = this.localities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Localities {
  String locality;

  Localities({this.locality});

  Localities.fromJson(Map<String, dynamic> json) {
    locality = json['locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locality'] = this.locality;
    return data;
  }
}
