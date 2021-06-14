class ItemPopularCities {
  String city_id;
  String city_name;

  ItemPopularCities({this.city_id, this.city_name});

  factory ItemPopularCities.fromJson(Map<String, dynamic> cityJson) {
    return ItemPopularCities(
      city_id: cityJson['city_id'],
      city_name: cityJson['city_name'],
    );
  }
}
