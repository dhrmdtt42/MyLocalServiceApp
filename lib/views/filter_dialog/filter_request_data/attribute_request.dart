class AttributeRequest {
  List<Attributes> attributes;

  AttributeRequest({this.attributes});

  AttributeRequest.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String attributeID;
  List<Values> values;

  Attributes({this.attributeID, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeID = json['attributeID'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeID'] = this.attributeID;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String valueID;

  Values({this.valueID});

  Values.fromJson(Map<String, dynamic> json) {
    valueID = json['valueID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valueID'] = this.valueID;
    return data;
  }
}
