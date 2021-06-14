class AmenitiesRequest {
  String amenitiesID;

  AmenitiesRequest({this.amenitiesID});

  AmenitiesRequest.fromJson(Map<String, dynamic> json) {
    amenitiesID = json['amenitiesID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amenitiesID'] = this.amenitiesID;
    return data;
  }
}
