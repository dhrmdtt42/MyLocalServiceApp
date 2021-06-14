class ServiceRequestData {
  String seo_url;
  String city;

  ServiceRequestData({this.seo_url, this.city});

  factory ServiceRequestData.fromJson(Map<String, dynamic> reqJson) {
    return ServiceRequestData(
        seo_url: reqJson['seo_url'], city: reqJson['city']);
  }

  Map<String, dynamic> toJson() => {
        'seo_url': seo_url,
        'city': city,
      };
}
