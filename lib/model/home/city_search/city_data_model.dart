class CityDataModel {
  String city_id;
  String countries_id;
  String zone_id;
  String city_name;
  String latitude;
  String longitude;
  String city_state;
  String popular;
  String city_status;

  CityDataModel(
      {this.city_id,
      this.countries_id,
      this.zone_id,
      this.city_name,
      this.latitude,
      this.longitude,
      this.city_state,
      this.popular,
      this.city_status});

  factory CityDataModel.fromJson(Map<String, dynamic> cityJson) {
    return CityDataModel(
        city_id: cityJson['city_id'],
        countries_id: cityJson['countries_id'],
        zone_id: cityJson['zone_id'],
        city_name: cityJson['city_name'],
        latitude: cityJson['latitude'],
        longitude: cityJson['longitude'],
        city_state: cityJson['city_state'],
        popular: cityJson['popular'],
        city_status: cityJson['city_status']);
  }
}
