import 'dart:convert';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/firebase_dynamic_link/dynamic_link.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/amenitites_base_response.dart';
import 'package:haarway_app/model/filters/attribute_base_response.dart';
import 'package:haarway_app/model/filters/attributes_response.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/fliter_data_base_response.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/locality_base_response.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/model/filters/radius_base_response.dart';
import 'package:haarway_app/model/filters/service_base_response.dart';
import 'package:haarway_app/model/filters/sortby_base_response.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:haarway_app/model/service_search/ServiceCatSearchWithNoFilterBaseResponse.dart';
import 'package:haarway_app/model/service_search/category_response.dart';
import 'package:haarway_app/model/service_search/item_data_model.dart';
import 'package:haarway_app/model/service_search/service_cat_search_response_data.dart';
import 'package:haarway_app/model/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/service_search/single_service_cat_search_response.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/details_page/service_details_page.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/amen_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/attribute_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/bathroom_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/bedroom_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/cat_reqst.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/furnish_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/loc_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/price_range_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/property_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/services_request.dart';
import 'package:haarway_app/views/filter_dialog/locality_dialog.dart';
import 'package:haarway_app/views/filter_dialog/radius_dialog.dart';
import 'package:haarway_app/views/filter_dialog/sort_by_dialog.dart';
import 'package:haarway_app/views/home/home_screen.dart';
import 'package:haarway_app/views/home/search_pages/category_search_page.dart';
import 'package:haarway_app/views/home/search_pages/city_search_page.dart';
import 'package:haarway_app/views/login_page.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as globals;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
int _selectedIndex = 0;
//BuildContext mcontext;

class ProductSearchPageList extends StatefulWidget {
  final String cityText;
  final String seo_url;
  final String sortBytxt;
  final bool isFromHomePage;

  ProductSearchPageList(
      {this.cityText, this.seo_url, this.sortBytxt, this.isFromHomePage});

  @override
  _ProductSearchPageListState createState() => _ProductSearchPageListState();
}

class _ProductSearchPageListState extends State<ProductSearchPageList> {
  String cityName;
  TextEditingController searchTextController = new TextEditingController();
  List<String> events_partyList;
  Map<String, dynamic> filterMapData = new Map<String, dynamic>();
  List<dynamic> filterList;
  ScrollPhysics _physics = BouncingScrollPhysics();
  CommonData commonData = new CommonData();
  Data myUserData = new Data();
  bool _isCreatingLink = false;
  bool isOverlay = false;
  String _linkMessage;
//  int _selectedIndex = 0;
  LocationRequestDataModel locationInfo = new LocationRequestDataModel();
  List<SearchItemDataModel> searchItemList = new List<SearchItemDataModel>();
  ServiceCatSearchResponseData serviceCatSearchResponseData =
      new ServiceCatSearchResponseData();
  SortByBaseResponse sortBy;
  List<String> sortby = new List<String>();
  RadiusBase radiusBaseResponse;
  RadiusFilterData radiusFilterData = new RadiusFilterData();
  List<RadiusFilterData> radiusList = new List<RadiusFilterData>();
  ResCategories categoryBaseResponse;
//  List<CategoryData> categoriesList = new List<CategoryData>();
  ServiceBaseResponse serviceBaseResponse;
  AmenintiesBaseResponse amenintiesBaseResponse;
  List<AmenitiesFilterData> amenitiesList = new List<AmenitiesFilterData>();
  LocalityBaseResponse localityBaseResponse;
  List<LocalityFilterData> localityData = new List<LocalityFilterData>();
  AttributeBaseResponse attributeBaseResponse;
  List<AttributesFilterResponse> attributes =
      new List<AttributesFilterResponse>();
  FilterDataBaseResponse filterResponse = new FilterDataBaseResponse();
  SingleServiceSearchCatResponseData singleServiceSearchCatResponseData =
      new SingleServiceSearchCatResponseData();
  SearchItemDataModel searchItemData = new SearchItemDataModel();

  ServiceCatSearchBaseResponse catServiceSearchBaseResponse =
      new ServiceCatSearchBaseResponse();
  SeriviceCatSearchWithNoFilterBaseResponse
      serviceCatSearchWithNoFilterBaseResponse =
      new SeriviceCatSearchWithNoFilterBaseResponse();
  Map filterData = new Map();
  bool isTabSection = true;
  String serviceName;
  String sortByTextVal;
  String radiusTextVal;
  String categoryTextVal;
  String serviceTextVal;
  String localityTextVal;
  String attributeTextVal;
  static const notGettingRationReasonType = <String>[
    "English",
    "Hindi",
    "Bangla"
  ];
  final List<DropdownMenuItem<String>> _dropDownreasonNotGettingRationItems =
      notGettingRationReasonType
          .map((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList();
  OverlayEntry _overlayEntry;
  ValueNotifier<int> _activeColorNotifier;
  ValueNotifier<int> _checkColorNotifier;
  int _checkboxValue;

  @override
  void initState() {
    // TODO: implement initState

    events_partyList = <String>[
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/events_party.png",
      "assets/events_party_scnd.png",
    ];

    globals.cityText = widget.cityText;
    globals.seo_url = widget.seo_url;
    isTabSection = widget.isFromHomePage;
    setState(() {
      globals.locality.length;
      globals.locIndex.length;
      getUserDatafromLocal();
      print(myUserData);
    });

    getSearchServiceList(seo_url: widget.seo_url, city: widget.cityText);
    setState(() {
//      getUserLocationDatafromLocal();
      print(locationInfo);
    });
//    filterList = <Widget>[
//      Container(
//        width: 130.0,
//        height: 30.0,
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//            colors: [Colors.red[900], Colors.red[900]],
//          ),
//        ),
//        child: RaisedButton(
//          color: CommonData().colorFromHex("#ebebeb"),
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(0.0),
//          ),
//          onPressed: () async {
//            showDialog(
//                barrierDismissible: true,
//                context: scaffoldKey.currentContext,
//                builder: (BuildContext context) {
//                  return SortByCustomDialogBox(
//                    title: "Custom Dialog Demo",
//                    descriptions:
//                        "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                    text: "Yes",
//                    sortBy: sortby,
//                  );
//                });
//
////            setState(() {
////              cityName = myCity;
////            });
//          },
//          child: Row(
//            children: <Widget>[
////              Text("SortBy(${globals.sortByCount})"),
////              globals.sortByCount == null ?
//              Text("SortBy"),
////                  : Text("SortBy(${globals.sortByCount})"),
//              Spacer(),
//              Icon(Icons.arrow_drop_down),
//            ],
//          ),
//        ),
//      ),
//      Visibility(
//        visible: categoriesList.length == 0 ? false : true,
//        child: Container(
//          width: 130.0,
//          height: 30.0,
////          decoration: BoxDecoration(
////              border: Border.all(color: Colors.white),
////              color: Colors.white,
////              borderRadius: BorderRadius.circular(20)),
//          child: RaisedButton(
//            color: CommonData().colorFromHex("#ebebeb"),
//            shape: new RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(0.0),
//            ),
//            onPressed: () async {
//              showDialog(
//                  context: scaffoldKey.currentContext,
//                  builder: (BuildContext context) {
//                    return CategoryCustomDialogBox(
//                      title: "Custom Dialog Demo",
//                      descriptions:
//                          "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                      text: "Yes",
//                      categrories: categoriesList,
//                    );
//                  });
//
////            setState(() {
////              cityName = myCity;
////            });
//            },
//            child: Row(
//              children: <Widget>[
//                Text("Categroy"),
////              categoryBaseResponse.title == null ? Text("N/A") : Text("${categoryBaseResponse.title}"),
//                Spacer(),
//                Icon(Icons.arrow_drop_down),
//              ],
//            ),
//          ),
//        ),
//      ),
//      Visibility(
////        visible: amenitiesList.length == 0 ? false : true,
//        child: Container(
//          width: 130.0,
//          height: 30.0,
////          decoration: BoxDecoration(
////              border: Border.all(color: Colors.white),
////              color: Colors.white,
////              borderRadius: BorderRadius.circular(20)),
//          child: RaisedButton(
//            color: CommonData().colorFromHex("#ebebeb"),
//            shape: new RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(0.0),
//            ),
//            onPressed: () async {
//              showDialog(
//                  context: scaffoldKey.currentContext,
//                  builder: (BuildContext context) {
//                    return AmenitiesCustomDialogBox(
//                      title: "Custom Dialog Demo",
//                      descriptions:
//                          "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                      text: "Yes",
//                      amenities: amenitiesList,
//                    );
//                  });
//            },
//            child: Row(
//              children: <Widget>[
//                Text("Amenities"),
////              amenintiesBaseResponse.title == null ? Text("N/A") : Text("${amenintiesBaseResponse.title}"),
//                Spacer(),
//                Icon(Icons.arrow_drop_down),
//              ],
//            ),
//          ),
//        ),
//      ),
//      Container(
//        width: 130.0,
//        height: 30.0,
////          decoration: BoxDecoration(
////              border: Border.all(color: Colors.white),
////              color: Colors.white,
////              borderRadius: BorderRadius.circular(20)),
//        child: RaisedButton(
//          color: CommonData().colorFromHex("#ebebeb"),
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(0.0),
//          ),
//          onPressed: () async {
//            showDialog(
//                context: scaffoldKey.currentContext,
//                builder: (BuildContext context) {
//                  return RadiusCustomDialogBox(
//                    title: "Custom Dialog Demo",
//                    descriptions:
//                        "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                    text: "Yes",
//                    radius: radiusFilterData,
//                  );
//                });
//          },
//          child: Row(
//            children: <Widget>[
////              if (globals.radCount != 0)
//              Container(
//                  child: globals.radCount != 0
//                      ? Text(
//                          "Radius",
//                          //style: TextStyle(fontSize: 14.0),
//                        )
//                      : Text(
//                          "Radius(${globals.radCount})",
////                    style: TextStyle(fontSize: 14.0)
//                        )),
//              Spacer(),
//              Icon(Icons.arrow_drop_down),
//            ],
//          ),
//        ),
//      ),
//      Container(
//        width: 130.0,
//        height: 30.0,
////          decoration: BoxDecoration(
////              border: Border.all(color: Colors.white),
////              color: Colors.white,
////              borderRadius: BorderRadius.circular(20)),
//        child: RaisedButton(
//          color: CommonData().colorFromHex("#ebebeb"),
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(0.0),
//          ),
//          onPressed: () async {
//            showDialog(
//                context: scaffoldKey.currentContext,
//                builder: (BuildContext context) {
//                  return LocalityCustomDialogBox(
//                    title: "Custom Dialog Demo",
//                    descriptions:
//                        "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                    text: "Yes",
//                    localities: localityData,
//                  );
//                });
//          },
//          child: Row(
//            children: <Widget>[
//              Container(
//                  child: globals.locality == null
//                      ? Text(
//                          "Locality",
//                          //style: TextStyle(fontSize: 14.0),
//                        )
//                      : Text(
//                          "Locality(${globals.locality.length})",
////                    style: TextStyle(fontSize: 14.0)
//                        )),
////              localityBaseResponse.title == null ? Text("N/A") : Text("${localityBaseResponse.title}"),
//              Spacer(),
//              Icon(Icons.arrow_drop_down),
//            ],
//          ),
//        ),
//      ),
//      Visibility(
//        visible: attributes.length == 0 ? false : true,
//        child: Container(
//          width: 130.0,
//          height: 30.0,
//
////      padding: EdgeInsets.symmetric(horizontal: 10),
////          decoration: BoxDecoration(
////              border: Border.all(color: Colors.white),
////              color: Colors.white,
////              borderRadius: BorderRadius.circular(20)),
//
//          child: RaisedButton(
//            color: CommonData().colorFromHex("#ebebeb"),
//            shape: new RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(0.0),
//            ),
//            onPressed: () async {
//              showDialog(
//                  context: scaffoldKey.currentContext,
//                  builder: (BuildContext context) {
//                    return CustomDialogBox(
//                      title: "Custom Dialog Demo",
//                      descriptions:
//                          "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
//                      text: "Yes",
//                      attributes: attributes,
//                    );
//                  });
//            },
//            child: Row(
//              children: <Widget>[
//                Text("attribute"),
//                Spacer(),
//                Icon(Icons.arrow_drop_down),
//              ],
//            ),
//          ),
//        ),
//      ),
//    ];
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              //                  + 5.0,
              width: size.width,
              child: Material(
                elevation: 4.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text('Syria'),
                    ),
                    ListTile(
                      title: Text('Lebanon'),
                    )
                  ],
                ),
              ),
            ));
  }

  getUserLocationDatafromLocal() async {
    Future<String> userLocation = commonData.getLocationData();
    String myLocationString = await userLocation;
    Map jsonData = new Map();
    jsonData = jsonDecode(myLocationString);
    setState(() {
      try {
        locationInfo = LocationRequestDataModel.fromJson(jsonData);
        print(locationInfo);
      } catch (e) {
        debugPrint("Error found==========>>>>>> : $e");
      }
    });
  }

  getSearchServiceList(
      {String seo_url,
      String city,
      String sortByTxt,
      String radius,
      List<ReqCategories> mycategories,
      List<Services> services,
      List<Amenities> amenities,
      List<Localities> localities,
      List<Attributes> myattributes,
      PriceRange priceRange,
      List<Propertytypes> propertytypes,
      List<Furnishingtypes> furnishingtypes,
      List<Bedrooms> bedrooms,
      List<Bathrooms> bathrooms}) async {
    var response = await Provider.of<ProviderModel>(context, listen: false)
        .getSearchResultListDataApiCall(
            context: context,
            seo_url: seo_url,
            city: city,
            sortByTxt: sortByTxt,
            radius: radius,
            categories: mycategories,
            services: services,
            amenities: amenities,
            priceRange: priceRange,
            propertytypes: propertytypes,
            furnishingtypes: furnishingtypes,
            bedrooms: bedrooms,
            bathrooms: bathrooms);

    Map responseData = new Map();
    responseData = jsonDecode(response.body);

    setState(() {
      if (responseData.containsKey("filterData")) {
        catServiceSearchBaseResponse =
            ServiceCatSearchBaseResponse.fromJson(responseData);
        filterList = new List<dynamic>();

        FilterDataBaseResponse filterData =
            catServiceSearchBaseResponse.filterData;
        sortBy = filterData.sortBy;
        radiusBaseResponse = filterData.radius;
        categoryBaseResponse = filterData.categoryBaseResponse;
        serviceBaseResponse = filterData.serviceBaseResponse;
        amenintiesBaseResponse = filterData.amenintiesBaseResponse;
        localityBaseResponse = filterData.localityBaseResponse;
        attributes = filterData.attributes;
        if (sortBy != null) filterList.add(sortBy);
        if (radiusBaseResponse != null) filterList.add(radiusBaseResponse);
        if (categoryBaseResponse != null) filterList.add(categoryBaseResponse);

        if (serviceBaseResponse != null) filterList.add(serviceBaseResponse);

        if (amenintiesBaseResponse != null)
          filterList.add(amenintiesBaseResponse);

        if (localityBaseResponse != null) filterList.add(localityBaseResponse);

        if (attributeBaseResponse != null)
          filterList.add(attributeBaseResponse);

        serviceCatSearchResponseData =
            catServiceSearchBaseResponse.serviceCatSearchResponseData;
        searchItemList = serviceCatSearchResponseData.items;
        serviceName = serviceCatSearchResponseData.page.seo_title;
        print(searchItemList);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      isTabSection = true;
      if (index == 4) {
        scaffoldKey.currentState.openEndDrawer(); // CHANGE THIS LINE
      } else {
        _selectedIndex = index;
      }

      if (index == 0) {
        Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: HomeScreen());
      }
    });
  }

  String home_ic = "assets/home_icon.png";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context, listen: false);
    if (globals.selectedCity == null &&
        userLocation != null &&
        userLocation != "null")
      globals.selectedCity = userLocation.currentAddress;
    if (searchItemList == null || filterList == null) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        )),
      );
    } else
      return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: <Widget>[
              Divider(
                height: 2.0,
              ),
              Container(
                  child: Stack(children: <Widget>[
                SafeArea(
                  left: true,
                  right: true,
                  minimum: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 130.0,
                            height: 40.0,
//                                padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: RaisedButton(
                              color: Colors.white,
                              onPressed: () async {
                                String myCity = await Navigator.push(
                                  scaffoldKey.currentContext,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CitySearchPage()),
                                );

                                setState(() {
                                  if (myCity != null) {
                                    cityName = myCity;
                                    globals.selectedCity = cityName;
                                  } else if (userLocation != null &&
                                      userLocation != 'null') {
                                    globals.selectedCity =
                                        userLocation.currentAddress ??
                                            "Kolkata";
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "${globals.selectedCity ?? "Kolkata"}",
                                    style: GoogleFonts.poppins(fontSize: 10.0),
                                  ),
//                                  if (globals.selectedCity == null)
//                                    Container(
//                                        child: globals.selectedCity == null
//                                            ? Text("${globals.selectedCity}")
//                                            : Text(
//                                                "${userLocation.currentAddress ?? "Kolkata"}"))
//                                  else
//                                    Text(
//                                      "${globals.selectedCity}",
//                                      style:
//                                          GoogleFonts.poppins(fontSize: 10.0),
//                                    ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(child: Icon(Icons.arrow_drop_down)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            width: 220.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: searchTextController,
                              autofocus: false,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainSearchPage(
                                              cityText: locationInfo.city_name,
                                            )));
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),

                                suffixIcon: Icon(
                                  Icons.mic,
                                  size: 25.0,
                                  color: Colors.redAccent,
                                ),
                                hintText: "What are you looking for?",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
//                                  border: const OutlineInputBorder(),
//                                    enabledBorder: OutlineInputBorder(
//                                        borderRadius: BorderRadius.all(
//                                            Radius.circular(5.0)),
//                                        borderSide:
//                                            BorderSide(color: Colors.black))
                              ),
                              onSubmitted: (val) {
//                                  setState(() {
//                                    isNum = isNumeric(val);
//                                  });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            color: Colors.redAccent,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ])),
              Divider(height: 2.0, color: Colors.blueGrey),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: CommonData().colorFromHex("#ebebeb"),
                      ),
                      child: Center(
                        child: Text(
                          "${searchItemList.length - 1}+ ${serviceName} Service in ${userLocation != null ? userLocation.currentAddress : 'Kolkata'}",
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                height: 1.0,
                color: Colors.blueGrey,
              ),
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: CommonData().colorFromHex("#f6f6f6"),
                ),
//                          margin: EdgeInsets.all(5.0),
                child: ListView.builder(
                    itemCount: filterList.length,
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(
                        parent: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics())),
                    itemBuilder: (BuildContext context, int index) {
                      if (filterList[index] == sortBy) {
                        sortBy = filterList[index];
                        return SortByWidget(sortBy);
                      }
                      if (filterList[index] == radiusBaseResponse) {
                        radiusBaseResponse = filterList[index];
                        return radiusWidget(radiusBaseResponse);
                      }
                      if (filterList[index] == categoryBaseResponse) {
                        categoryBaseResponse = filterList[index];
                        return categoryWidget(categoryBaseResponse);
                      }
                      if (filterList[index] == serviceBaseResponse) {
                        serviceBaseResponse = filterList[index];
                        return serviceWidget(serviceBaseResponse);
                      }

                      if (filterList[index] == localityBaseResponse) {
                        localityBaseResponse = filterList[index];
                        return localityWidget(localityBaseResponse);
                      }
                      if (filterList[index] == amenintiesBaseResponse) {
                        amenintiesBaseResponse = filterList[index];
                        return amenitiesWidget(amenintiesBaseResponse);
                      }
//                    if (filterList[index]['title'] == 'Locality') {
//                      attributes = filterList[index];
//                      return attributeWidget(attributes);
//                    }

                      return Container();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.98,
                  height: MediaQuery.of(context).size.height * 0.65,
//                    MediaQuery.of(context).size.width * 0.98,
                  child: ListView.builder(
                      itemCount: searchItemList.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(
                          parent: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics())),
                      itemBuilder: (BuildContext context, int index) {
                        searchItemData = searchItemList[index];
                        String image = searchItemData.image;
                        String title = searchItemData.name;
                        String location = searchItemData.location;
                        String seo_url = searchItemData.seo_url;
                        String totReview = searchItemData.review_count;
                        var avgReview = searchItemData.sum_review_rating;
//                                  "total_review": "0",
//                                  "average_review": 0,
                        return myWidget(seo_url, image, context, title,
                            location, totReview, avgReview);
                      }),
                ),
              )
            ],
          ),
        )),
      );
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  getUserDatafromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      print(myUserData);
      print(
          "=========================>>>>>>>>>>>>>>>>>>> ${myUserData.customer_name}");
      print(
          "=========================>>>>>>>>>>>>>>>>>>> ${myUserData.customer_mobile}");
    });
  }

  myWidget(String seo_url, String imageUrl, BuildContext context, String title,
      String location, String totalReview, var avgReview) {
    String reviewString = avgReview.toString();
    double avReview = double.parse(reviewString);
    int tReview = int.parse(totalReview);
//    int avReview = int.parse(avgReview);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ServiceDetailsPage(
                        cityText: "Kolkata",
                        seo_url: seo_url,
                      )));
        },
        child: Card(
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 6.0),
                child: Container(
                  child: imageUrl == null
                      ? Image.asset(
                          events_partyList[0],
                          height: 100.0,
                          width: 100.0,
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4.0,
                              child: Image.network(
                                imageUrl,
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    title == null
                        ? Text(
                            "Naskar Green Town",
                            style: GoogleFonts.poppins(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "$title",
                            style: GoogleFonts.poppins(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: location == null
                              ? Text(
                                  "6c, Middleton Street, House Villa, 304,Mumbai East (Maharastra)",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.normal),
                                )
                              : Text(
                                  "$location",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.normal),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        children: <Widget>[
                          RatingBarIndicator(
                            rating: avReview,
//                            avgReview.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.redAccent,
                            ),
                            itemCount: 5,
                            itemSize: 10.0,
                            direction: Axis.horizontal,
                          ),
//                          Image.asset(
//                            "assets/rating_star.png",
//                            width: 50.0,
//                            height: 10.0,
//                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "${tReview}  reviews",
                            style: GoogleFonts.poppins(
                                fontSize: 8.0, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Config:  2 BHK House  | Super Built-up Area:  1250 sqm ",
                            style: GoogleFonts.poppins(
                                fontSize: 8.0, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/call.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        String shareUrl = await _createDynamicLink(
                            true, title, imageUrl, seo_url);
                        print("Share Url ::: $shareUrl");
                        Share.share(shareUrl);
                      },
                      child: Image.asset(
                        "assets/forward.png",
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openEndDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

//  import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
  Future<String> _createDynamicLink(
      bool short, title, imageUrl, shortDescription) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://haarway.page.link',
      link: Uri.parse('https://haarway.page.link/$shortDescription'),
      androidParameters: AndroidParameters(
        packageName: 'com.haarway.app',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(imageUrl),
        title: "$title",
        description: '$shortDescription',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });

    return url.toString();
  }

  Widget SortByWidget(SortByBaseResponse sortBy) {
    String title = sortBy.title;
    List<dynamic> sortByList = sortBy.sortbyData;
    if (sortByList.length == null) {
      return Container();
    }
    print(sortByList);

    return Container(
      width: 120.0,
      padding: EdgeInsets.symmetric(horizontal: 10),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black),
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(14)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            "$title",
            style: TextStyle(color: Colors.black),
          ),
          isExpanded: true,
          value: sortByTextVal,
//                              _currentSelectedType,
          isDense: true,
          onChanged: (String newValue) {
            setState(() {
              sortByTextVal = newValue;
              getSearchServiceList(
                  seo_url: widget.seo_url,
                  sortByTxt: sortByTextVal,
                  city: widget.cityText);
            });
          },
          items: sortByList
              .map((dynamic value) => DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(value,
                        style: GoogleFonts.poppins(
                            fontSize: 10.0, fontWeight: FontWeight.w500)),
                  )))
              .toList(),
        ),
      ),
    );
  }

  Widget radiusWidget(RadiusBase radiusObj) {
    String title;
    List<String> distance = new List<String>();
    DistanceData distanceData = new DistanceData();
    if (radiusObj == null) {
      return Container();
    } else {
      title = radiusObj.title;
      String max = radiusObj.distanceData.max;
      distance.add(max);
      String min = "5";
//          radiusObj.distanceData.min;
      distance.add(min);
      String step = "1";
//          radiusObj.distanceData.step;
      distance.add(step);
      return Container(
        width: 120.0,
        padding: EdgeInsets.symmetric(horizontal: 10),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black),
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(14)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "$title",
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            value: radiusTextVal,
//                              _currentSelectedType,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                radiusTextVal = newValue;
                getSearchServiceList(
                    seo_url: widget.seo_url,
                    radius: radiusTextVal,
                    city: widget.cityText);
              });
            },
            items: distance
                .map((String value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)))
                .toList(),
          ),
        ),
      );
    }
  }

  Widget categoryWidget(ResCategories categoryBaseResponse) {
    ResCategories resCategories = new ResCategories();
    ReqCategories reqCategory = new ReqCategories();
    List<ReqCategories> req_categories = new List<ReqCategories>();
    List<dynamic> categoryData = new List<dynamic>();
    String title;
    if (categoryBaseResponse == null) {
      return Container();
    } else {
//      categoryData = categoryBaseResponse.categoryData;
      resCategories = categoryBaseResponse;
      title = resCategories.title;
      for (int i = 0; i < resCategories.categoryData.length; i++) {
        categoryData.add(resCategories.categoryData[i].categoryTitle);
      }
      return Visibility(
        visible: resCategories.categoryData.isEmpty ? false : true,
        child: Container(
          width: 120.0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                "$title",
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              value: categoryTextVal,
//                              _currentSelectedType,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  categoryTextVal = newValue;
                  for (int i = 0; i < resCategories.categoryData.length; i++) {
                    if (resCategories.categoryData[i].categoryTitle ==
                        categoryTextVal) {
                      reqCategory.categoryID =
                          resCategories.categoryData[i].categoryID;
                      req_categories.add(reqCategory);
                    }
                    getSearchServiceList(
                        seo_url: widget.seo_url,
                        mycategories: req_categories,
                        city: widget.cityText);
                  }
                });
              },
              items: categoryData
                  .map((dynamic value) => DropdownMenuItem<String>(
                      value: value, child: Text(value)))
                  .toList(),
            ),
          ),
        ),
      );
    }
  }

  Widget serviceWidget(ServiceBaseResponse serviceBaseResponse) {
    String title;
    List<dynamic> serviceData = new List<dynamic>();
    Services serviceItem = new Services();
    List<Services> services = new List<Services>();
    if (serviceBaseResponse.serviceFilterData == null) {
      return Container();
    } else {
      title = serviceBaseResponse.title;

      for (int i = 0; i < serviceBaseResponse.serviceFilterData.length; i++) {
        serviceData.add(serviceBaseResponse.serviceFilterData[i].name);
      }
      return Container(
        width: 120.0,
        padding: EdgeInsets.symmetric(horizontal: 10),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black),
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(14)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "$title",
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            value: serviceTextVal,
//                              _currentSelectedType,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                serviceTextVal = newValue;
                Services serviceItem = new Services();
                serviceItem.name = serviceTextVal;
                services.add(serviceItem);
                getSearchServiceList(
                    seo_url: widget.seo_url,
                    services: services,
                    city: widget.cityText);
              });
            },
            items: serviceData
                .map((dynamic value) => DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(value,
                          style: GoogleFonts.poppins(
                              fontSize: 10.0, fontWeight: FontWeight.w500)),
                    )))
                .toList(),
          ),
        ),
      );
    }
  }

  Widget localityWidget(LocalityBaseResponse localityBaseResponse) {
    String title;
    List<dynamic> localityData = new List<dynamic>();

    LocalityFilterData localityFilterDataItem = new LocalityFilterData();
    List<LocalityFilterData> localitylist = new List<LocalityFilterData>();
    if (localityBaseResponse == null) {
      return Container();
    } else {
      title = localityBaseResponse.title;
      for (int i = 0; i < localityBaseResponse.localityFilterData.length; i++) {
        localityData.add(localityBaseResponse.localityFilterData[i].locality);
        localityFilterDataItem.locality =
            localityBaseResponse.localityFilterData[i].locality;
        localitylist.add(localityFilterDataItem);
      }
      return Container(
        width: 120.0,
        padding: EdgeInsets.symmetric(horizontal: 10),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black),
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(14)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "$title",
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            value: localityTextVal,
//                              _currentSelectedType,
            isDense: true,
            onChanged: (String newValue) {
              Localities mylocalItem;
              List<Localities> mylocalList = new List<Localities>();
              setState(() {
                mylocalItem.locality = newValue;
                mylocalList.add(mylocalItem);

                getSearchServiceList(
                    seo_url: widget.seo_url,
                    localities: mylocalList,
                    city: widget.cityText);
              });
            },
            items: localityData
                .map((dynamic value) => DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(value,
                          style: GoogleFonts.poppins(
                              fontSize: 10.0, fontWeight: FontWeight.w500)),
                    )))
                .toList(),
          ),
        ),
      );
    }
  }

  Widget attributeWidget(AttributeBaseResponse attributeBaseResponse) {}

  Widget amenitiesWidget(AmenintiesBaseResponse amenintiesBaseResponse) {}
}

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}
