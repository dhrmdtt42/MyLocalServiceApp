class LocalityFilterData {
  String localityID;
  String city_id;
  String locality;
  String popular;
  String status;

  LocalityFilterData(
      {this.localityID,
      this.city_id,
      this.locality,
      this.popular,
      this.status});

  factory LocalityFilterData.fromJson(Map<String, dynamic> localJson) {
    return LocalityFilterData(
        locality: localJson['locality'],
        city_id: localJson['city_id'],
        localityID: localJson['localityID'],
        popular: localJson['popular'],
        status: localJson['status']);
  }

  Map<String, dynamic> toJson() => {
        'locality': locality,
        'city_id': city_id,
        'localityID': localityID,
        'popular': popular,
        "status": status,
      };
}
