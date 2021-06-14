class BedRoomTypeRequest {
  List<Bedrooms> bedrooms;

  BedRoomTypeRequest({this.bedrooms});

  BedRoomTypeRequest.fromJson(Map<String, dynamic> json) {
    if (json['bedrooms'] != null) {
      bedrooms = new List<Bedrooms>();
      json['bedrooms'].forEach((v) {
        bedrooms.add(new Bedrooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bedrooms != null) {
      data['bedrooms'] = this.bedrooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bedrooms {
  String bedroomID;

  Bedrooms({this.bedroomID});

  Bedrooms.fromJson(Map<String, dynamic> json) {
    bedroomID = json['bedroomID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bedroomID'] = this.bedroomID;
    return data;
  }
}
