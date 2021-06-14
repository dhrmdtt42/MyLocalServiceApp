import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends ChangeNotifier {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition = new Position();
  String _currentAddress;

  Position getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
//      notifyListeners();
    }).catchError((e) {
      print(e);
    });
    return currentPosition;
  }

  Future<Placemark> getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea})}";
      notifyListeners();
      return place;
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> AddLocationDataAPICall(
      LocationRequestDataModel locationRequest, BuildContext context) async {
    var url = 'https://www.haarway.com/api/location/get_current_location';
    //encode Map to JSON
    var body = json.encode(locationRequest.toJson());
    print(body);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String status = responseData['status'];

    if (status == "success") {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Navigator.pop(context, locationRequest.zone_name);
    }
    print("${response.body}");
    return response;
  }
}
