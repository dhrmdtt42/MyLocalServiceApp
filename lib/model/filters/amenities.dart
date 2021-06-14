class AmenitiesFilterData {
  String amenitiesID;
  String categoryID;
  String amenities_name;
  String font;
  String amenities_description;
  String amenities_status;
  String sort_order;
  String create_date;
  String modified_date;

  AmenitiesFilterData(
      {this.amenitiesID,
      this.categoryID,
      this.amenities_name,
      this.font,
      this.amenities_description,
      this.amenities_status,
      this.sort_order,
      this.create_date,
      this.modified_date});

  factory AmenitiesFilterData.fromJson(Map<String, dynamic> amenitiesJson) {
    return AmenitiesFilterData(
        amenitiesID: amenitiesJson['amenitiesID'],
        categoryID: amenitiesJson['categoryID'],
        amenities_name: amenitiesJson['amenities_name'],
        font: amenitiesJson['fonts'],
        amenities_description: amenitiesJson['amenities_description'],
        amenities_status: amenitiesJson['amenities_status'],
        sort_order: amenitiesJson['sort_order'],
        create_date: amenitiesJson['create_date'],
        modified_date: amenitiesJson['modified_date']);
  }

  Map<String, dynamic> toJson() => {
        'amenitiesID': amenitiesID,
        'categoryID': categoryID,
        'amenities_name': amenities_name,
        'font': font,
        'amenities_description': amenities_description,
        'amenities_status': amenities_status,
        'sort_order': sort_order,
        'create_date': create_date,
        'modified_date': modified_date
      };
}
