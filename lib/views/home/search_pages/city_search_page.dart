import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/home/city_search/city_base_response.dart';
import 'package:haarway_app/model/home/city_search/city_data_model.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/providers/location_provider.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';

class CitySearchPage extends StatefulWidget {
  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  TextEditingController searchTextEditController = new TextEditingController();
  List<CityDataModel> cityDataList;
  CityDataModel cityDataItem = new CityDataModel();
  static List<String> notGettingRationReasonType = new List<String>();
  int len;
  bool isSelected = false;
  Position currentPosition;
  String latitude;
  String longitude;
  String stateName;
  String locality;

  final List<DropdownMenuItem<String>> _dropDownreasonNotGettingRationItems =
      notGettingRationReasonType
          .map((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
//          Positioned(
//              left: 10.0,
//              top: 40.0,
//              child: InkWell(
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                child: Icon(
//                  Icons.arrow_back_ios,
//                  color: Colors.black,
//                  size: 25.0,
//                ),
//              )),
          Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    controller: searchTextEditController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25.0,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.mic,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                      hintText: "Search City Here",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
//                      border: const OutlineInputBorder(),
//                      enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                          borderSide: BorderSide(color: Colors.black)
//                      )
                    ),
                    onChanged: (val) {
                      String searchText = searchTextEditController.text.trim();
                      getCityApiCall(context, searchText);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    currentPosition =
                        Provider.of<LocationProvider>(context, listen: false)
                            .getCurrentLocation();

//                   locationData.city_name = currentPosition.
                    setState(() {
                      latitude = currentPosition.latitude.toString();
                      longitude = currentPosition.longitude.toString();
                      getLocationInfo(latitude, longitude);
                    });
                  },
                  selected: isSelected,
                  title: Text(
                    "Detect My Location",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: Text(
                      " ${locality == null ? "" : locality},  ${stateName == null ? "" : stateName}"),
                  leading: Icon(
                    Icons.location_searching,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: cityDataList == null
                    ? Center(
                        child: Container(
                          child: Text(
                            "No Data Found",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cityDataList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          cityDataItem = cityDataList[index];
                          String cityname = cityDataItem.city_name;
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            onTap: () {
                              Navigator.pop(context, cityname);
                            },
                            title: Text("$cityname"),
                            subtitle: Text("${cityDataItem.city_state}"),
                            dense: false,
                            selected: isSelected,
                          );
                        }),
              )
            ],
          ),
        ]),
      ),
    );
  }

  void getCityApiCall(BuildContext context, String searchText) async {
    CityBaseResponse cityBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getCityDataApiCall(context, searchText);

    setState(() {
      cityDataList = cityBaseResponse.cities;
      len = cityDataList.length;
      for (int i = 0; i < len; i++) {
        cityDataItem = cityDataList[i];
        notGettingRationReasonType.add(cityDataItem.city_name);
        print(notGettingRationReasonType);
      }
      print(cityDataList);
    });
  }

  void getLocationInfo(String latitude, String longitude) async {
    LocationRequestDataModel locationInfo = LocationRequestDataModel();
    Placemark myCurrentPlace =
        await Provider.of<LocationProvider>(context, listen: false)
            .getAddressFromLatLng();
    locationInfo.longitude = longitude;
    locationInfo.latitude = latitude;
    locationInfo.zone_name = myCurrentPlace.administrativeArea;
    locationInfo.city_name = myCurrentPlace.locality;
    locationInfo.countries_name = myCurrentPlace.country;
    List<LocationRequestDataModel> locationList =
        new List<LocationRequestDataModel>();
    locationList.add(locationInfo);
    setState(() {
      stateName = myCurrentPlace.administrativeArea;
      locality = myCurrentPlace.locality;
      CommonData.saveUserLocation(locationList);
    });

    Provider.of<LocationProvider>(context, listen: false)
        .AddLocationDataAPICall(locationInfo, context);
  }
}
