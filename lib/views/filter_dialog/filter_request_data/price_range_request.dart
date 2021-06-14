class PriceRangeRequest {
  PriceRange priceRange;

  PriceRangeRequest({this.priceRange});

  PriceRangeRequest.fromJson(Map<String, dynamic> json) {
    priceRange = json['price_range'] != null
        ? new PriceRange.fromJson(json['price_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priceRange != null) {
      data['price_range'] = this.priceRange.toJson();
    }
    return data;
  }
}

class PriceRange {
  String min;
  String max;

  PriceRange({this.min, this.max});

  PriceRange.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
