class RadiusFilterData {
  String min;
  String max;
  String step;

  RadiusFilterData({this.min, this.max, this.step});

  factory RadiusFilterData.fromJson(Map<String, dynamic> radiusJson) {
    return RadiusFilterData(
        min: radiusJson['min'],
        max: radiusJson['max'],
        step: radiusJson['step']);
  }

  Map<String, dynamic> toJson() => {"min": min, "max": max, "step": step};
}
