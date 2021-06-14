class LocationRequestDataModel {
  String countries_name;
  String zone_name;
  String city_name;
  String latitude;
  String longitude;

  LocationRequestDataModel(
      {this.countries_name,
      this.zone_name,
      this.city_name,
      this.latitude,
      this.longitude});

  factory LocationRequestDataModel.fromJson(Map<String, dynamic> locationJson) {
    return LocationRequestDataModel(
        countries_name: locationJson['countries_name'],
        zone_name: locationJson['zone_name'],
        city_name: locationJson['city_name'],
        latitude: locationJson['latitude'],
        longitude: locationJson['longitude']);
  }

  Map<String, dynamic> toJson() => {
        'countries_name': countries_name,
        'zone_name': zone_name,
        'city_name': city_name,
        'latitude': latitude,
        'longitude': longitude,
      };
}
