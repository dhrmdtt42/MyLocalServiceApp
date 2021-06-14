class AttributeFilterData {
  String attributeID;
  String categoryID;
  String name;
  String description;
  String font;
  String type;
  String status;
  String sort_order;
  String create_date;
  String modified_date;

  AttributeFilterData(
      {this.attributeID,
      this.categoryID,
      this.name,
      this.description,
      this.font,
      this.type,
      this.status,
      this.sort_order,
      this.create_date,
      this.modified_date});

  factory AttributeFilterData.fromJson(Map<String, dynamic> attriJson) {
    return AttributeFilterData(
      attributeID: attriJson['attributeID'],
      categoryID: attriJson['categoryID'],
      name: attriJson['name'],
      description: attriJson['description'],
      font: attriJson['font'],
      type: attriJson['type'],
      status: attriJson['status'],
      sort_order: attriJson['sort_order'],
      create_date: attriJson['create_date'],
      modified_date: attriJson['modified_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'attributeID': attributeID,
        'categoryID': categoryID,
        'name': name,
        'description': description,
        'font': font,
        'type': type,
        'status': status,
        'sort_order': sort_order,
        'create_date': create_date,
        'modified_date': modified_date
      };
}
