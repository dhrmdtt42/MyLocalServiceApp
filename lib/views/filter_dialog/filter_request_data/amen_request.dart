class AmenitiesRequest {
  List<Amenities> amenities;

  AmenitiesRequest({this.amenities});

  AmenitiesRequest.fromJson(Map<String, dynamic> json) {
    if (json['amenities'] != null) {
      amenities = new List<Amenities>();
      json['amenities'].forEach((v) {
        amenities.add(new Amenities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amenities != null) {
      data['amenities'] = this.amenities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amenities {
  String amenitiesID;

  Amenities({this.amenitiesID});

  Amenities.fromJson(Map<String, dynamic> json) {
    amenitiesID = json['amenitiesID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amenitiesID'] = this.amenitiesID;
    return data;
  }
}
