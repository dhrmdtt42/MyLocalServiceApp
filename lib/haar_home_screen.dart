import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/home/city_search/city_base_response.dart';
import 'package:haarway_app/model/home/city_search/city_data_model.dart';
import 'package:haarway_app/model/home/education_jobs/education_job_data_model.dart';
import 'package:haarway_app/model/home/education_jobs/education_jobs_base_response.dart';
import 'package:haarway_app/model/home/events_party/event_party_base_response.dart';
import 'package:haarway_app/model/home/events_party/event_party_data_model.dart';
import 'package:haarway_app/model/home/health_care/health_care_base_response.dart';
import 'package:haarway_app/model/home/health_care/health_care_data_model.dart';
import 'package:haarway_app/model/home/home_improvement/home_improvement_base_response.dart';
import 'package:haarway_app/model/home/home_improvement/home_improvement_data_model.dart';
import 'package:haarway_app/model/home/home_offices/home_office_base_response.dart';
import 'package:haarway_app/model/home/home_offices/home_office_data_model.dart';
import 'package:haarway_app/model/home/main_categories.dart';
import 'package:haarway_app/model/home/popular_services_category.dart';
import 'package:haarway_app/model/home/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';
import 'package:haarway_app/model/home/trending_services/trending_services_base_response.dart';
import 'package:haarway_app/model/home/trending_services/trending_servies_data_model.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/model/location/location_services.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:haarway_app/model/responses/main_category_response.dart';
import 'package:haarway_app/model/responses/popular_cat_data_response.dart';
import 'package:haarway_app/model/responses/popular_service_category_base_response.dart';
import 'package:haarway_app/model/sub_categories/subcat__request_data_model.dart';
import 'package:haarway_app/providers/location_provider.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/image_resize_factor.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/home/search_pages/category_search_page.dart';
import 'package:haarway_app/views/home/search_pages/city_search_page.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:haarway_app/views/sub_categories.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:haarway_app/global_variables.dart' as globals;

class HaarHomeScreen extends StatefulWidget {
  final List<MainCategoryData> m_mainCategoryList;
  final List<PopularCategoryData> m_popularCategoryList;
  final List<EventsPartyData> m_eventPartyList;
  final List<HomeImprovementData> m_homeImprovementList;
  final List<EducationJobsData> m_educationJobsDataList;
  final List<TrendingServicesData> m_trendingServicesDataList;
  final List<HomeOfficeDataModel> m_homeofficesDatalist;
  final List<HealthCareDataModel> m_healthCareDataList;

  HaarHomeScreen(
      {this.m_mainCategoryList,
      this.m_popularCategoryList,
      this.m_eventPartyList,
      this.m_homeImprovementList,
      this.m_educationJobsDataList,
      this.m_trendingServicesDataList,
      this.m_homeofficesDatalist,
      this.m_healthCareDataList});

  @override
  _HaarHomeScreenState createState() => _HaarHomeScreenState();
}

class _HaarHomeScreenState extends State<HaarHomeScreen> {
  String reasonNotGettingRationType;
  List<String> imageList;
  List<String> events_partyList;
  List<String> wedding_plannerImgList;
  List<String> realEstate_rentalsImgList;
  List<MainCategoryData> mainCategoryList;
  List<PopularCategoryData> popularCategoryList;
  List<EventsPartyData> eventPartyList;
  List<HomeImprovementData> homeImprovementList;
  List<EducationJobsData> educationJobsDataList;
  List<TrendingServicesData> trendingServicesDataList;
  List<HomeOfficeDataModel> homeofficesDatalist;
  List<HealthCareDataModel> healthCareDataList;
  List<CityDataModel> cityDataList;
  PopularCategoryData popularCategoryDataItem = new PopularCategoryData();
  EventsPartyData eventPartyDataItem = new EventsPartyData();
  HomeImprovementData homeImprovementData = new HomeImprovementData();
  EducationJobsData educationJobsData = new EducationJobsData();
  TrendingServicesData trendingServicesData = new TrendingServicesData();
  HomeOfficeDataModel homeOfficeDataModel = new HomeOfficeDataModel();
  HealthCareDataModel healthCareDataItem = new HealthCareDataModel();
  CityDataModel cityDataItem = new CityDataModel();
  Uint8List targetSizeUint8Data;
  int len;
  String cityName;
  Map serviceSubData = new Map();
  bool mainCatFlag = true;
  bool poCatFlag = true;
  bool eventFlag = true;
  bool homeFlag = true;
  bool eduFlag = true;
  bool trendFlag = true;
  bool homeOffFlag = true;
  bool healthFlag = true;
  bool resFlag = true;
  int mlen;
  bool isSelected = false;
  Position currentPosition;
  String latitude;
  String longitude;
  String stateName;
  String locality;
  String seo_url1;
  String seo_url2;
  String seo_url3;
  String seo_url4;
  String seo_url5;
  String seo_url6;
  String seo_url7;
  String seo_url8;
  String seo_url9;
  String seo_urlX;

  bool getFlagResult() {
    if (mainCategoryList != null &&
        popularCategoryList != null &&
        eventPartyList != null &&
        homeImprovementList != null &&
        educationJobsDataList != null &&
        trendingServicesDataList != null &&
        homeofficesDatalist != null &&
        healthCareDataList != null)
      return true;
    else
      return false;
  }

  TextEditingController searchTextController = new TextEditingController();
  static List<String> notGettingRationReasonType = <String>[""];

  final List<DropdownMenuItem<String>> _dropDownreasonNotGettingRationItems =
      notGettingRationReasonType
          .map((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList = <String>[
      "assets/image_wedding.png",
      "assets/image_wedding.png",
      "assets/image_wedding.png",
      "assets/image_wedding.png",
    ];
    events_partyList = <String>[
      "assets/events_party.png",
      "assets/events_party_scnd.png",
      "assets/image_wedding.png",
      "assets/events_party.png",
    ];
    wedding_plannerImgList = <String>[
      "assets/wedding_planner.png",
      "assets/matrimonial.png",
      "assets/wedding_planner.png",
      "assets/matrimonial.png",
    ];
    realEstate_rentalsImgList = <String>[
      "assets/realestate.png",
      "assets/rentals.png",
      "assets/realestate.png",
      "assets/rentals.png",
    ];

//    mainCategoryList.addAll(widget.m_mainCategoryList);
//    popularCategoryList.addAll(widget.m_popularCategoryList);
//    eventPartyList.addAll(widget.m_eventPartyList);
//    homeImprovementList.addAll(widget.m_homeImprovementList);
//    educationJobsDataList.addAll(widget.m_educationJobsDataList);
//    trendingServicesDataList.addAll(widget.m_trendingServicesDataList);
//    homeofficesDatalist.addAll(widget.m_homeofficesDatalist);
//    healthCareDataList.addAll(widget.m_healthCareDataList);

    getMainCategoryData();
    getPopularCategoryData();
    getEventPartyData();
    getHomeImprovementData();
    getEducationJobApiCall();
    getTrendingServiesApiCall();
    getHomeAndOfficesApiCall();
    getHealthCareApiCall();
    getCityApiCall();
//    detectMyLocation();
  }

  @override
  Widget build(BuildContext context) {
//    getMainCategoryData();
//    getPopularCategoryData();
//    getEventPartyData();
//    getHomeImprovementData();
//    getEducationJobApiCall();
//    getTrendingServiesApiCall();
//    getHomeAndOfficesApiCall();
//    getHealthCareApiCall();
    var userLocation = Provider.of<UserLocation>(context);
//    print(userLocation);
//    globals.selectedCity = userLocation.currentAddress;
    return Scaffold(
      body: getFlagResult() == false
          ? Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("assets/background.png"),
                              )),
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 2.0,
                              right: 0.0,
                              top: 30.0,
                              child: SafeArea(
                                left: true,
                                right: true,
                                minimum: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 130.0,
                                      height: 35.0,
//                                padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: RaisedButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          String myCity = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        CitySearchPage()),
                                          );

                                          setState(() {
                                            if (myCity != null) {
                                              cityName = myCity;
                                              globals.selectedCity = cityName;
                                            } else
                                              cityName = stateName;
                                          });
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            if (userLocation == null &&
                                                globals.selectedCity != null)
                                              Text("${globals.selectedCity}"),
                                            if (globals.selectedCity == null &&
                                                userLocation != null)
                                              Text(
                                                  "${userLocation.currentAddress}"),
                                            if (userLocation.currentAddress !=
                                                    null &&
                                                globals.selectedCity != null)
                                              Text("${globals.selectedCity}"),
                                            if (userLocation == null &&
                                                globals.selectedCity == null)
                                              Text("Select"),
//                                            if (globals.selectedCity == null &&
//                                                userLocation == null)
//                                              Container(
//                                                  child: userLocation
//                                                              .currentAddress ==
//                                                          null
//                                                      ? Text("Select")
//                                                      : Text(
//                                                          "${userLocation.currentAddress}"))
//                                            else if (userLocation
//                                                        .currentAddress !=
//                                                    null &&
//                                                globals.selectedCity != null)
//                                              Container(
//                                                  child: globals.selectedCity !=
//                                                          null
//                                                      ? Text(
//                                                          "${globals.selectedCity}")
//                                                      : Text("Select")),
//                                            else
//                                              Container(
//                                                  child: userLocation
//                                                              .currentAddress ==
//                                                          null
//                                                      ? Text("Select")
//                                                      : Text(
//                                                          "${userLocation.currentAddress}")),
                                            Spacer(),
                                            Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
//                              Container(
//                                width: 130.0,
//                                height: 35.0,
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                decoration: BoxDecoration(
//                                    border: Border.all(color: Colors.white),
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(5)),
//                                child: DropdownButtonHideUnderline(
//                                  child: new DropdownButton(
//                                    onTap: () async {
//                                      cityName = await Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (BuildContext context) =>
//                                                CitySearchPage()),
//                                      );
//                                      print(cityName);
//                                    },
//                                    hint: Text("Select"),
//                                    isExpanded: true,
//                                    items:
//                                        notGettingRationReasonType.map((item) {
//                                      return new DropdownMenuItem(
//                                        child: new Text(item),
//                                        value: item.toString(),
//                                      );
//                                    }).toList(),
//                                    onChanged: (newVal) {
//                                      setState(() {
////                                        newVal = cityName;
//                                        reasonNotGettingRationType = cityName;
//                                      });
//                                    },
//                                    value: reasonNotGettingRationType,
//                                  ),
//                                ),
//                              ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Container(
                                      width: 220.0,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          MainSearchPage()));
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.mic,
                                            size: 25.0,
                                            color: Colors.redAccent,
                                          ),
                                          hintText: "What are you looking for?",
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 12.0,
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
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      onTap: () {
//                                  String searchString = searchTextController
//                                      .text
//                                      .toString()
//                                      .trim();
//                                  getSearchServiceDataApiCall(searchString);
                                      },
                                      child: Container(
                                        width: 35.0,
                                        height: 35.0,
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
//                      Positioned(
//                        left: 150.0,
//                        top: 80.0,
//                        child: Container(
//                          color: Colors.white,
////                          decoration: BoxDecoration(),
//                          width: MediaQuery.of(context).size.width * 0.95,
//                          height: MediaQuery.of(context).size.width * 0.50,
//                          child: ListView.builder(
//                              itemCount: serviceSubData.length,
//                              scrollDirection: Axis.vertical,
//                              itemBuilder: (BuildContext context, int index) {
//                                Map subData = new Map();
//                                subData = serviceSubData['${index + 1}'];
//                                String title = subData['name'];
//
//                                return Container(
//                                  width: 250.0,
//                                  child: ListTile(
//                                    title: Text(
//                                      "$title",
//                                      style: TextStyle(
//                                        fontSize: 10.0,
//                                        color: Colors.black,
//                                      ),
//                                    ),
////                                  isThreeLine: true,
//                                  ),
//                                );
//                              }),
//                        ),
//                      )
                          ])),
//                      Text(
//                          'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 300.0,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: mainCategoryList == null
                            ? Container()
                            : Carousel(
                                images: [
                                  GridView.count(
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      crossAxisCount: 3,
                                      scrollDirection: Axis.horizontal,
                                      // Generate 100 widgets that display their index in the List.
                                      children: List.generate(
                                          mainCategoryList.length, (index) {
                                        MainCategoryData mainCategoryData =
                                            new MainCategoryData();
                                        mainCategoryData =
                                            mainCategoryList[index];
                                        String iconUrl =
                                            mainCategoryData.icon_image;
//                                  getImageStringWithSize(iconUrl, 30, 30);

                                        return Center(
                                          child: InkWell(
                                            onTap: () {
                                              String mainCat =
                                                  mainCategoryData.mainCat;
                                              String parentId =
                                                  mainCategoryData.parentID;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          SubCategory(
                                                            mainCat: mainCat,
                                                            parentId: parentId,
                                                          )));
//                                        getSubCatResponses(
//                                            mainCat, parentId, context);
                                            },
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
//                                            Image.memory(targetSizeUint8Data),
                                                  Image.network(
                                                    iconUrl,
                                                    height: 30.0,
                                                    width: 30.0,
                                                  ),
                                                  Text(
                                                    '${mainCategoryData.category_title}',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
//                                    style: Theme.of(context).textTheme.headline5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/anything_onhire.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Anything \n\t\ton Hire",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ed_training.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\tEducation \nand Training",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/ondemand.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "On-Demand \n\t\t\t\t\tService",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/home_improvemnt.png",
                                                    height: 30,
                                                    width: 30.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "\t\t\t\t\tHome \nImprovement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/anything_onhire.png",
                                                      height: 30,
                                                      width: 30.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Anything \n\t\ton Hire",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/ed_training.png",
                                                      height: 30,
                                                      width: 30.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "\t\tEducation \nand Training",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/ondemand.png",
                                                      height: 30,
                                                      width: 30.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "On-Demand \n\t\t\t\t\tService",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    right: 8.0,
                                                    left: 8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/home_improvemnt.png",
                                                      height: 30,
                                                      width: 30.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "\t\t\t\t\tHome \nImprovement",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                dotSize: 8.0,
                                dotSpacing: 15.0,
                                autoplay: false,
                                dotColor: Colors.redAccent,
                                indicatorBgPadding: 5.0,
                                dotBgColor: Colors.white,
                                //                    borderRadius: true,
                              )),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Popular Services",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url1,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 150,
                    child: popularCategoryList == null
                        ? Container()
                        : ListView.builder(
                            itemCount: popularCategoryList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              popularCategoryDataItem =
                                  popularCategoryList[index];
                              String imageUrl =
                                  popularCategoryDataItem.category_image;
                              String title =
                                  popularCategoryDataItem.category_title;
                              seo_url1 = popularCategoryDataItem.seo_url;
                              return WidgetHotelsAndRestuarant(
                                  context, index, imageUrl, title, seo_url1);
                            }),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Events & Party",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url2,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 150,
                    child: eventPartyList == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: eventPartyList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              eventPartyDataItem = eventPartyList[index];
                              String imageUrl =
                                  eventPartyDataItem.category_image;
                              String title = eventPartyDataItem.category_title;
                              seo_url2 = eventPartyDataItem.seo_url;
                              return WidgetEventsAndParty(
                                  context, index, imageUrl, title, seo_url2);
                            }),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Home Improvements",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url3,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 120,
                    child: homeImprovementList == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: homeImprovementList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              homeImprovementData = homeImprovementList[index];
                              String imageUrl =
                                  homeImprovementData.category_image;
                              String title = homeImprovementData.category_title;
                              seo_url3 = homeImprovementData.seo_url;
                              print("health seo Url============::: $seo_url8");
                              return WidgetHomeAndImprovement(
                                  context, index, imageUrl, title, seo_url3);
                            }),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Education & Jobs",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url4,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 200,
                    child: educationJobsDataList == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: educationJobsDataList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              educationJobsData = educationJobsDataList[index];
                              String imageUrl =
                                  educationJobsData.category_image;
                              String title = educationJobsData.category_title;
                              seo_url4 = educationJobsData.seo_url;
                              print("health seo Url============::: $seo_url4");
                              return WidgetRealEstateAndRentals(
                                  context, index, imageUrl, title, seo_url4);
                            }),
                  ),

                  ///trending services list data display widget===============o=========
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Trending & Services",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url5,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 150,
                    child: trendingServicesDataList == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: trendingServicesDataList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              trendingServicesData =
                                  trendingServicesDataList[index];
                              String imageUrl =
                                  trendingServicesData.category_image;
                              String title =
                                  trendingServicesData.category_title;
                              seo_url6 = trendingServicesData.seo_url;
                              print("health seo Url============::: $seo_url6");
                              return WidgetTrendingServices(
                                  context, index, imageUrl, title, seo_url6);
                            }),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Home & Offices",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url7,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 150,
                    child: homeofficesDatalist == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: homeofficesDatalist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              homeOfficeDataModel = homeofficesDatalist[index];
                              String imageUrl =
                                  homeOfficeDataModel.category_image;
                              String title = homeOfficeDataModel.category_title;
                              seo_url7 = homeOfficeDataModel.seo_url;
                              print("health seo Url============::: $seo_url7");
                              return WidgetHomesAndOffices(
                                  context, index, imageUrl, title, seo_url7);
                            }),
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          "Health & Care",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 12.0, bottom: 12.0),
                          child: SizedBox(
                            width: 100.0,
                            height: 25.0,
                            child: RaisedButton(
                              focusElevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductSearchPageList(
                                            seo_url: seo_url8,
                                          )),
//                                    (route) => false
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                              color: new CommonData().colorFromHex("#e95d5d"),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: new CommonData()
                                        .colorFromHex("#e95d5d"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 150,
                    child: healthCareDataList == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: healthCareDataList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              healthCareDataItem = healthCareDataList[index];
                              String imageUrl =
                                  healthCareDataItem.category_image;
                              String title = healthCareDataItem.category_title;
                              seo_url8 = healthCareDataItem.seo_url;
                              print("health seo Url============::: $seo_url8");
                              return WidgetHealthAndCare(
                                  context, index, imageUrl, title, seo_url8);
                            }),
                  ),
                ],
              ),
            ),
    );
  }

  Widget WidgetHotelsAndRestuarant(BuildContext context, int index,
      String image, String title, String seo_url) {
    String defaultImage = imageList[0];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
                top: 70.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          )

//      Card(
//        elevation: 5,
//        child: image != null
//            ? Image.network(
//                image,
//                fit: BoxFit.fill,
//              )
//            : Image.asset(
//                defaultImage,
//                fit: BoxFit.fill,
//              ),
//      ),
          ),
    );
  }

  Widget WidgetEventsAndParty(BuildContext context, int index, String image,
      String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 0.0,
                top: 50.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  Widget WidgetHomeAndImprovement(BuildContext context, int index, String image,
      String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.20,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 0.0,
                top: 50.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  Widget WidgetRealEstateAndRentals(BuildContext context, int index,
      String image, String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.30,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 0.0,
                top: 100.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  Widget WidgetTrendingServices(BuildContext context, int index, String image,
      String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.20,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 50.0,
                top: 70.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  Widget WidgetHomesAndOffices(BuildContext context, int index, String image,
      String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
//      MediaQuery.of(context).size.width * 0.35,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 50.0,
                top: 70.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  Widget WidgetHealthAndCare(BuildContext context, int index, String image,
      String title, String seo_url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductSearchPageList(
                    seo_url: seo_url,
                    isFromHomePage: true,
                  )),
//                                    (route) => false
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image))),
          child: Stack(
            children: <Widget>[
              new Positioned(
                left: 0.0,
                right: 0.0,
//              bottom: 50.0,
                top: 70.0,
                child: Card(
                  elevation: 6,
                  color: Colors.black26,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('$title',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new Icon(Icons.star),
              ),
            ],
          )),
    );
  }

  void getMainCategoryData() async {
    ChangeNotifier provider = new ChangeNotifier();
    MainCategoryResponse mainCategoryResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getMainCategoryApiCall(context);
    mainCategoryList = mainCategoryResponse.mainCategory;
    print(mainCategoryList);
    provider.notifyListeners();
  }

  void getPopularCategoryData() async {
    ChangeNotifier provider = new ChangeNotifier();
    PopularServiceCategoryResponse popularCategoryResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getPopularServiceApiCall(context);
    setState(() {
      popularCategoryList = popularCategoryResponse.popularCategoryData;
      print(popularCategoryList);
    });
  }

  void getEventPartyData() async {
    EventsPartyBaseResponse eventsPartyBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getEventsAndPartyApiCall(context);
    setState(() {
      eventPartyList = eventsPartyBaseResponse.eventPartyList;
      print(eventPartyList);
    });
  }

  void getHomeImprovementData() async {
    HomeImprovementBaseResponse homeImprovementBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getHomeImprovementApiCall(context);
    setState(() {
      homeImprovementList = homeImprovementBaseResponse.homeImprovementDataList;
      print(homeImprovementList);
    });
  }

  void getEducationJobApiCall() async {
    EducationJobsBaseResponse educationJobsBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getEducationJobApiCall(context);
    setState(() {
      educationJobsDataList = educationJobsBaseResponse.educationJobsDataList;
      print(educationJobsDataList);
    });
  }

  void getTrendingServiesApiCall() async {
    TrendingServicesBaseResponse trendingServicesBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getTrendingServiceApiCall(context);
    setState(() {
      trendingServicesDataList = trendingServicesBaseResponse.trendingServices;
      print(trendingServicesDataList);
    });
  }

  void getHomeAndOfficesApiCall() async {
    HomeOfficeBaseResponse homeOfficeBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .gteHomeAndOfficeApiCall(context);
    setState(() {
      homeofficesDatalist = homeOfficeBaseResponse.homeOfficeDataList;
      print(homeofficesDatalist);
    });
  }

  void getHealthCareApiCall() async {
    HealthCareBaseResponse healthCareBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getHealthAndCareApiCall(context);
    setState(() {
      healthCareDataList = healthCareBaseResponse.healthCareList;
      print(healthCareDataList);
    });
  }

  void getCityApiCall() async {
    CityBaseResponse cityBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getCityDataApiCall(context, "KOl");

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

  void getImageStringWithSize(String image, int height, int width) async {
    ResizeImageAtLevel resizeImageAtLevel = new ResizeImageAtLevel();
    Uint8List targetSizeUint8List =
        await resizeImageAtLevel.resizeImage(image, height, width);

    setState(() {
      targetSizeUint8Data = targetSizeUint8List;
      print(targetSizeUint8Data);
    });

//    return targetSizeUint8List;
  }

  void detectMyLocation() async {
    currentPosition =
        await Provider.of<LocationProvider>(context, listen: false)
            .getCurrentLocation();

//                   locationData.city_name = currentPosition.

    setState(() {
      latitude = currentPosition.latitude.toString();
      longitude = currentPosition.longitude.toString();
      getLocationInfo(latitude, longitude);
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
