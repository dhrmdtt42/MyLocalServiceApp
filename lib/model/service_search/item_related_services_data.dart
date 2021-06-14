class ItemRelatedServices {
  String ID;
  String name;
  String seo_url;
  String image;

  ItemRelatedServices({this.ID, this.name, this.seo_url, this.image});

  factory ItemRelatedServices.fromJson(Map<String, dynamic> relatedServJson) {
    return ItemRelatedServices(
        ID: relatedServJson['ID'],
        name: relatedServJson['name'],
        seo_url: relatedServJson['seo_url'],
        image: relatedServJson['image']);
  }
}
