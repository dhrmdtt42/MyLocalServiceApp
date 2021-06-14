class BathRoomTypeRequest {
  List<Bathrooms> bathrooms;

  BathRoomTypeRequest({this.bathrooms});

  BathRoomTypeRequest.fromJson(Map<String, dynamic> json) {
    if (json['bathrooms'] != null) {
      bathrooms = new List<Bathrooms>();
      json['bathrooms'].forEach((v) {
        bathrooms.add(new Bathrooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bathrooms != null) {
      data['bathrooms'] = this.bathrooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bathrooms {
  String bathroomID;

  Bathrooms({this.bathroomID});

  Bathrooms.fromJson(Map<String, dynamic> json) {
    bathroomID = json['bathroomID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bathroomID'] = this.bathroomID;
    return data;
  }
}
