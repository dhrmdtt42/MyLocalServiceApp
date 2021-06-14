class RadiusBaseResponse {
  RadiusBase radius;

  RadiusBaseResponse({this.radius});

  RadiusBaseResponse.fromJson(Map<String, dynamic> json) {
    radius =
        json['radius'] != null ? new RadiusBase.fromJson(json['radius']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.radius != null) {
      data['radius'] = this.radius.toJson();
    }
    return data;
  }
}

class RadiusBase {
  String title;
  DistanceData distanceData;

  RadiusBase({this.title, this.distanceData});

  RadiusBase.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    distanceData = json['distanceData'] != null
        ? new DistanceData.fromJson(json['distanceData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.distanceData != null) {
      data['distanceData'] = this.distanceData.toJson();
    }
    return data;
  }
}

class DistanceData {
  String min;
  String max;
  String step;

  DistanceData({this.min, this.max, this.step});

  DistanceData.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    step = json['step'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    data['step'] = this.step;
    return data;
  }
}
