import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViwState createState() => _HomeViwState();
}

class _HomeViwState extends State<HomeView> {
  final Geolocator geolocator = new Geolocator();
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
            Text(
                'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
          ],
        ),
      ),
    );
  }

// _getCurrentLocation() {
//   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//       .then((Position position) {
//     setState(() {
//       _currentPosition = position;
//     });
//
//     _getAddressFromLatLng();
//   }).catchError((e) {
//     print(e);
//   });
// }

// _getAddressFromLatLng() async {
//   try {
//     List<Placemark> p = await geolocator.placemarkFromCoordinates(
//         _currentPosition.latitude, _currentPosition.longitude);
//
//     Placemark place = p[0];
//
//     setState(() {
//       _currentAddress =
//       "${place.locality}, ${place.postalCode}, ${place.country}";
//     });
//   } catch (e) {
//     print(e);
//   }
// }
}
