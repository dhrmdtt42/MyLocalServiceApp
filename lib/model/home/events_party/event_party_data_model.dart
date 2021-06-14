class EventsPartyData {
  String event_categoryID;
  String parentID;
  String category_title;
  String keyword_name;
  String amenities_label_text;
  String seo_url;
  String category_description;
  String category_image;
  String category_banner_image;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String sort_order;
  String deletable;
  String create_date;
  String modified_date;
  String status;
  String total_items;

  EventsPartyData(
      {this.event_categoryID,
      this.parentID,
      this.category_title,
      this.keyword_name,
      this.amenities_label_text,
      this.seo_url,
      this.category_description,
      this.category_image,
      this.category_banner_image,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.sort_order,
      this.deletable,
      this.create_date,
      this.modified_date,
      this.status,
      this.total_items});

  factory EventsPartyData.fromJson(Map<String, dynamic> eventPartJson) {
    return EventsPartyData(
        event_categoryID: eventPartJson['event_categoryID'],
        parentID: eventPartJson['parentID'],
        category_title: eventPartJson['category_title'],
        keyword_name: eventPartJson['keyword_name'],
        amenities_label_text: eventPartJson['amenities_label_text'],
        seo_url: eventPartJson['seo_url'],
        category_description: eventPartJson['category_description'],
        category_image: eventPartJson['category_image'],
        category_banner_image: eventPartJson['category_banner_image'],
        seo_title: eventPartJson['seo_title'],
        seo_keyword: eventPartJson['seo_keyword'],
        seo_description: eventPartJson['seo_description'],
        sort_order: eventPartJson['sort_order'],
        deletable: eventPartJson['deletable'],
        create_date: eventPartJson['create_date'],
        modified_date: eventPartJson['modified_date'],
        status: eventPartJson['status'],
        total_items: eventPartJson['total_items']

    );
  }
}
