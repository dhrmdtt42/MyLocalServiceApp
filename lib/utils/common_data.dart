import 'package:flutter/material.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonData {
  CommonData();
  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value, [bool isNum]) {
    Pattern pattern;
    if (value != null && value != "" && isNum != true) {
      pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return (!regex.hasMatch(value)) ? false : true;
    } else if (isNum == true && value.length != 10 && value != "") {
      return false;
    } else
      return true;
  }

  void saveLoginUser(String dataString) async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    saveUser.setString(Constants.USER, dataString);
    print(dataString);
  }

  static saveUserData(Map dataList) async {
    String campaignData = dataList.toString();
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    saveUser.setString(Constants.USER, campaignData);
  }

  Future<String> getUser() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String prefUser = sharedPrefrences.getString(Constants.USER);
    print(prefUser);
    return prefUser;
  }

  removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(Constants.USER);
  }

  static saveUserLocation(List<LocationRequestDataModel> userLocation) async {
    String locationData = userLocation.toString();
    SharedPreferences saveLocation = await SharedPreferences.getInstance();
    saveLocation.setString(Constants.USER_LOCATION, locationData);
  }

  Future<String> getLocationData() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String prefLocation = sharedPrefrences.getString(Constants.USER_LOCATION);
    print(prefLocation);
    return prefLocation;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text("$message."),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: [
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(
                        false); // dismisses only the dialog and returns false
                  },
                  child: Text('OK'),
                ),
              ],
            ));
  }

  void viewContactDialog(BuildContext context, String message,
      String serviceName, String mobileNumber) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text("$serviceName"),
                  SizedBox(
                    height: 20,
                  ),
                  Text("$message."),
                ],
              ),
              content: Column(
                children: [
                  Text("$mobileNumber"),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        launch("tel:+91$mobileNumber");
                        print("tel:+91$mobileNumber");
                      },
                      child: Icon(
                        Icons.call,
                        color: Colors.red,
                      ))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: [
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(
                        false); // dismisses only the dialog and returns false
                  },
                  child: Text('OK'),
                ),
              ],
            ));
  }
}
