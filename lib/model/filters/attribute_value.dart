class AttributeValuesFilterData {
  String valueID;
  String attributeID;
  String categoryID;
  String name;
  String font;
  String create_date;
  String modified_date;

  AttributeValuesFilterData(
      {this.valueID,
      this.attributeID,
      this.categoryID,
      this.name,
      this.font,
      this.create_date,
      this.modified_date});

  factory AttributeValuesFilterData.fromJson(Map<String, dynamic> attValJson) {
    return AttributeValuesFilterData(
        valueID: attValJson['valueID'],
        attributeID: attValJson['attributeID'],
        categoryID: attValJson['categoryID'],
        name: attValJson['name'],
        font: attValJson['font'],
        create_date: attValJson['create_date'],
        modified_date: attValJson['modified_date']);
  }

  Map<String, dynamic> toJson() => {
        'valueID': valueID,
        'attributeID': attributeID,
        'categoryID': categoryID,
        'name': name,
        'font': font,
        'create_date': create_date,
        'modified_date': modified_date,
      };
}
