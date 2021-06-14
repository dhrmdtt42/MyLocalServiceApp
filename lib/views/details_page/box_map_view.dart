import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ServiceMapView extends StatefulWidget {
  @override
  _ServiceMapViewState createState() => _ServiceMapViewState();
}

class _ServiceMapViewState extends State<ServiceMapView> {
  final String token =
      'pk.eyJ1IjoiaGFhcndheSIsImEiOiJja212ajVqZWMwNDA4MnZwOW9oYWdranNmIn0.HziiQNO71kdOtN72E7g1Qw';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
            options: new MapOptions(
                center: new LatLng(27.175002, 78.0421170902921), minZoom: 17.0),
            layers: [
          new TileLayerOptions(
              urlTemplate: "Generated Template",
              additionalOptions: {
                'accessToken': '$token',
                'id': 'mapbox.mapbox-streets-v8'
              }),
        ]));
  }
}
