import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;
  Location location = Location();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition = new Position();

  Future<UserLocation> getLocation() async {
    try {
//     UserLocation userLocation = new UserLocation();
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) async {
          if (locationData != null) {
            Placemark place = await getAddressFromLatLng(
                locationData.latitude, locationData.longitude);
            String userLocationData =
                "   ${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea})}";
            print(userLocationData);
            _locationController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
                currentAddress: place.locality));
          }
        });
      }
    });
  }

  Future<Placemark> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lng);
      Placemark place = p[0];
      String userLocation =
          "${place.locality}, ${place.postalCode}, ${place.country}, ${place.subAdministrativeArea})}";
      print(userLocation);

//      notifyListeners();
      return place;
    } catch (e) {
      print(e);
    }
  }
}
