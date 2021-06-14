import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';
import 'package:haarway_app/model/home/service_search/service_data_model.dart';
import 'package:haarway_app/model/home/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/home/service_search/single_service_base_response.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/views/details_page/service_details_page.dart';
import 'package:haarway_app/views/home/search_pages/city_search_page.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:provider/provider.dart';
import 'package:haarway_app/global_variables.dart' as globals;

class MainSearchPage extends StatefulWidget {
  final String cityText;
  final bool isExploreIcon;
  MainSearchPage({@required this.cityText, @required this.isExploreIcon});

  @override
  _MainSearchPageState createState() => _MainSearchPageState();
}

class _MainSearchPageState extends State<MainSearchPage> {
  TextEditingController searchTextEditController = new TextEditingController();
//  APIParameterData serviceDataModel = new APIParameterData();
  APIParameterData apiParameterData = new APIParameterData();
  List<APIParameterData> serviceDataList = new List<APIParameterData>();
  bool isSelected = false;
  String cityName;
  @override
  Widget build(BuildContext context) {
    var userLocation = new UserLocation();
    userLocation = Provider.of<UserLocation>(context, listen: false);
    print(userLocation);
//    userLocation.currentAddress = "";
    if (globals.selectedCity == null &&
        userLocation != null &&
        userLocation != "null")
      globals.selectedCity = userLocation.currentAddress;
    return Scaffold(
      appBar: widget.isExploreIcon == true
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                      'assets/haarway.png',
                      width: 140,
                      height: 80.0,
                    )),
                  ],
                ),
              ),
              bottomOpacity: 5.0,
            )
          : null,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      String myCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CitySearchPage()),
                      );

                      setState(() {
                        if (myCity != null) {
                          cityName = myCity;
                          globals.selectedCity = cityName;
                        } else if (userLocation != null) {
                          globals.selectedCity = userLocation.currentAddress;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${globals.selectedCity ?? "Kolkata"}'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: searchTextEditController,
                        autofocus: true,

//
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          suffixIcon: Icon(
                            Icons.mic,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                          hintText: "Search Services Here",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        onChanged: (val) {
                          String searchText =
                              searchTextEditController.text.trim();
                          getSearchServiceDataApiCall(context, searchText);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
//                          decoration: BoxDecoration(),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                    itemCount: serviceDataList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      apiParameterData = serviceDataList[index];
                      String title = apiParameterData.name;
                      String seo_Url = apiParameterData.seo_url;
                      String type = apiParameterData.type;

                      return ListTile(
                        onTap: () {
                          setState(() {
                            print(title);
                            isSelected = true;
                            searchTextEditController.text = title;
                            if (type == Constants.type1)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProductSearchPageList(
                                          cityText: "Kolkata",
                                          seo_url: seo_Url,
                                        )),
//                                  (route) => false
                              );
                            if (type == Constants.type2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ServiceDetailsPage(
                                          cityText: "Kolkata",
                                          seo_url: seo_Url,
                                        )),
//                                  (route) => false
                              );
                            }

//                            Navigator.pushAndRemoveUntil(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (BuildContext context) =>
//                                        ServiceDetailsPage()),
//                                (route) => false);
                          });
                        },
                        selected: isSelected,
                        title: Text(
                          "$title",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
//                                  isThreeLine: true,
                      );
                    }),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void getSearchServiceDataApiCall(
      BuildContext context, String searchText) async {
    SingleServiceSearchBaseResponse serviceSearchBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getSearchServiceDataApiCall(context, searchText);
    setState(() {
      serviceDataList = serviceSearchBaseResponse.searchServiceData;
      print(serviceDataList);
    });
  }
}
