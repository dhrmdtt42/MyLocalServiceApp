import 'package:flutter/material.dart';

class WorkingHoursDataModel {
  String dayID;
  String day_name;
  String from_hour;
  String to_hour;
  String day_status;

  WorkingHoursDataModel(
      {this.dayID,
      this.day_name,
      this.from_hour,
      this.to_hour,
      this.day_status});

  factory WorkingHoursDataModel.fromJson(Map<String, dynamic> workJson) {
    return WorkingHoursDataModel(
        dayID: workJson['dayID'],
        day_name: workJson['day_name'],
        from_hour: workJson['from_hour'],
        to_hour: workJson['to_hour'],
        day_status: workJson['day_status']);
  }
}
