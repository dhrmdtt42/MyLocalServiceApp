import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:haarway_app/model/review/review_request.dart';
import 'package:haarway_app/model/service_search/ServiceCatSearchWithNoFilterBaseResponse.dart';
import 'package:haarway_app/model/service_search/item_categories.dart';
import 'package:haarway_app/model/service_search/item_data_model.dart';
import 'package:haarway_app/model/service_search/item_details_data_model.dart';
import 'package:haarway_app/model/service_search/item_page_data_model.dart';
import 'package:haarway_app/model/service_search/item_related_services_data.dart';
import 'package:haarway_app/model/service_search/item_service_data.dart';
import 'package:haarway_app/model/service_search/mode_of_payment.dart';
import 'package:haarway_app/model/service_search/service_cat_search_response_data.dart';
import 'package:haarway_app/model/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/service_search/single_service_cat_search_response.dart';
import 'package:haarway_app/model/service_search/user_review.dart';
import 'package:haarway_app/model/service_search/working_hours_model.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/add_review/add_review_page.dart';
import 'package:haarway_app/views/details_page/box_map_view.dart';
import 'package:haarway_app/views/details_page/request_item_category.dart';
import 'package:haarway_app/views/details_page/request_item_page.dart';
import 'package:haarway_app/views/home/search_pages/category_search_page.dart';
import 'package:haarway_app/views/home/search_pages/city_search_page.dart';
import 'package:haarway_app/views/login_page.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsPage extends StatefulWidget {
  final String cityText;
  final String seo_url;
  ServiceDetailsPage({this.cityText, this.seo_url});

  @override
  _ServiceDetailsPageState createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  bool flagService = true;
  String cityName;
  Data myUserData = new Data();
  int _selectedIndex = 0;
  bool _isCreatingLink = false;
  String _linkMessage;

  CommonData commonData = new CommonData();
  LocationRequestDataModel locationInfo = new LocationRequestDataModel();
  PageDataModel page = new PageDataModel();
  TextEditingController searchTextController = new TextEditingController();
  List<String> realEstate_rentalsImgList = new List<String>();
  List<ItemRelatedServices> itemRelatedServices =
      new List<ItemRelatedServices>();
  List<UserReview> userReviewList = new List<UserReview>();
  List<Widget> filterList = new List<Widget>();
//  LocationRequestDataModel locationInfo = new LocationRequestDataModel();
  List<SearchItemDataModel> searchItemList = new List<SearchItemDataModel>();
  List<WorkingHoursDataModel> workingHourData =
      new List<WorkingHoursDataModel>();
  List<ModeOfPayments> modeofPayments = new List<ModeOfPayments>();
  ServiceCatSearchResponseData serviceCatSearchResponseData =
      new ServiceCatSearchResponseData();
  SingleServiceSearchCatResponseData singleServiceSearchCatResponseData =
      new SingleServiceSearchCatResponseData();
  SearchItemDetailsModel searchItemData = new SearchItemDetailsModel();
  List<ItemCategories> itemCategories = new List<ItemCategories>();
  List<ItemServiceData> itemServices = new List<ItemServiceData>();
  ServiceCatSearchBaseResponse catServiceSearchBaseResponse =
      new ServiceCatSearchBaseResponse();
  SeriviceCatSearchWithNoFilterBaseResponse
      serviceCatSearchWithNoFilterBaseResponse =
      new SeriviceCatSearchWithNoFilterBaseResponse();

  bool _saving = false;
  bool isReview = false;
  bool isShowMore = false;
  MapboxMapController mapController;
//  globals.isLoggedIn = false;

  void _submit(String mseoUrl, String cityText) {
    setState(() {
      _saving = true;
//      globals.isLoggedIn = _saving;
    });

    //Simulate a service call
    print('submitting to backend...');
    getSearchServiceList(mseoUrl, cityText);
    _saving = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchServiceList(widget.seo_url, widget.cityText);
    getUserDatafromLocal();
  }

  void getSearchServiceList(String seo_url, String city) async {
    var response = await Provider.of<ProviderModel>(context, listen: false)
        .getSearchResultListDataApiCall(
      context: context,
      seo_url: seo_url,
      city: city,
    );

    Map responseData = new Map();
    responseData = jsonDecode(response.body);

    setState(() {
      if (responseData.containsKey("filterData")) {
        catServiceSearchBaseResponse =
            ServiceCatSearchBaseResponse.fromJson(responseData);
        serviceCatSearchResponseData =
            catServiceSearchBaseResponse.serviceCatSearchResponseData;
        searchItemList.addAll(serviceCatSearchResponseData.items);
        print(searchItemList);
      } else {
        serviceCatSearchWithNoFilterBaseResponse =
            SeriviceCatSearchWithNoFilterBaseResponse.fromJson(responseData);
        singleServiceSearchCatResponseData =
            serviceCatSearchWithNoFilterBaseResponse
                .serviceCatSearchResponseData;
        searchItemData = singleServiceSearchCatResponseData.items;
        itemRelatedServices.addAll(searchItemData.related_services);
        page = singleServiceSearchCatResponseData.page;
        workingHourData.addAll(searchItemData.working_hours);
        modeofPayments.addAll(searchItemData.modes_of_payment);

        if (searchItemData.categories.isNotEmpty)
          itemCategories.addAll(searchItemData.categories);
        if (searchItemData.services.isNotEmpty)
          itemServices.addAll(searchItemData.services);
        if (searchItemData.reviews.isNotEmpty)
          userReviewList.addAll(searchItemData.reviews);
        print(searchItemData);
      }
    });
  }

//  void addReview(BuildContext context, ReviewRequest reviewRequest) async {
//    var response = await Provider.of<ProviderModel>(context, listen: false)
//        .addReviewApiCall(context, reviewRequest);
//    Map responseData = new Map();
//    responseData = jsonDecode(response.body);
//  }
  final String token =
      'pk.eyJ1IjoiaGFhcndheSIsImEiOiJja212ajVqZWMwNDA4MnZwOW9oYWdranNmIn0.HziiQNO71kdOtN72E7g1Qw';
  final String style = 'mapbox://styles/mapbox/streets-v11';
  @override
  Widget build(BuildContext context) {
//    var userLocation = Provider.of<UserLocation>(context);
//

    if (searchItemData.additional_images == null ||
//        searchItemData.additional_images.isEmpty ||
//        searchItemList.isEmpty ||
        searchItemList == null) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        )),
      );
    } else
      return Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          child: buildingDetailsWidget(context, "Kolkata", searchItemData),
          inAsyncCall: _saving,
          dismissible: true,
//          opacity: 10.0,
        ),
      );
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getUserDatafromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      print(myUserData.customerID);
    });
  }

  Widget WidgetHotelsAndRestuarant(BuildContext context, int index,
      String image, String titleName, String seoUrl) {
    return InkWell(
      onTap: () {
//        setState(() {
//          getSearchServiceList(seoUrl, "Kolkata");fghfvghjvgh
        _submit(seoUrl, "Kolkata");
//        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.2,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
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
                      child: new Text('$titleName',
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
          ),
        ),
      ),
    );
  }

  Widget buildingDetailsWidget(BuildContext context, String userLocation,
      SearchItemDetailsModel pSearchItemData) {
    print(pSearchItemData);
    var avgReview = pSearchItemData.average_review;
    String reviewString = avgReview.toString();
    double avReview = double.parse(reviewString);
    return SingleChildScrollView(
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
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CitySearchPage()),
                            );

                            setState(() {
                              if (myCity != null) cityName = myCity;
                              globals.selectedCity = cityName;
//                                      else if (locationInfo != null)
//                                        cityName = locationInfo.city_name;
//                                      else
//                                        cityName = null;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              if (globals.selectedCity == null)
                                Container(
                                    child: globals.selectedCity == null
                                        ? Text("Select")
                                        : Text("$userLocation"))
                              else
                                Text(
                                  "${globals.selectedCity ?? ""}",
                                  style: GoogleFonts.poppins(fontSize: 10.0),
                                ),
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
          Divider(height: 10.0, color: Colors.grey),
          Row(
            children: [
              pSearchItemData.header_image == null
                  ? Container(
                      child: Image.asset(
                        "assets/realestate.png",
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Card(
                        elevation: 8.0,
                        child: Image.network(
                          pSearchItemData.header_image,
                          height: 160.0,
                          width: 180.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
//                          searchItemData.additional_images == null
              Container(
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Card(
                  elevation: 8.0,
                  child: pSearchItemData == null
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                        ))
                      : GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          scrollDirection: Axis.horizontal,
                          crossAxisCount: 3,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(
                              pSearchItemData.additional_images.length,
                              (index) {
                            String imageUrl =
                                pSearchItemData.additional_images[index];
                            print(imageUrl);
                            return Center(
                              child: imageUrl == null
                                  ? Container(
                                      child: Image.asset(
                                        "assets/events_party.png",
                                        height: 52.0,
                                        width: 52.0,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3.0),
                                      child: Card(
                                        elevation: 5.0,
                                        child: Image.network(
                                          imageUrl,
                                          height: 42.0,
                                          width: 52.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                            );
                          }),
                        ),
                ),
              )
            ],
          ),
          Divider(
            thickness: 5.0,
            color: Colors.grey,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    '${page.seo_title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        '${page.seo_description}',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 8.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListTile(
                  leading: Container(
                    child: Image.asset(
                      "assets/time.png",
                      height: 24.0,
                      width: 24.0,
                    ),
                  ),
                  title: Text(
                    'Open Now ${workingHourData[0].from_hour} - ${workingHourData[0].to_hour}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                  subtitle: Text(
                    'Mon - Sun ${workingHourData[0].from_hour} - ${workingHourData[0].to_hour}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal, fontSize: 8.0),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RatingBarIndicator(
                  rating: avReview,
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
                  "${pSearchItemData.review_count}  reviews",
                  style: GoogleFonts.poppins(
                      fontSize: 8.0, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, top: 12.0, bottom: 12.0),
                  child: SizedBox(
                    width: 150.0,
                    height: 25.0,
                    child: RaisedButton(
                      focusElevation: 5.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RequestItemPage(seoUrl: widget.seo_url),
                          ),
//                                    (route) => false
                        );
                      },
                      child: Text(
                        'View Contacts',
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
                            color: new CommonData().colorFromHex("#e95d5d"),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Visibility(
                  visible: pSearchItemData.website == null ? true : false,
                  child: Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Image.asset(
                              "assets/globe.png",
                              height: 24.0,
                              width: 24.0,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Website',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10.0),
                            ),
                            Container(
                              width: 120.0,
                              child: Text(
                                '${pSearchItemData.website}',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 8.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.redAccent.withOpacity(0.4),
                  width: 1,
                ),
                Visibility(
                  visible:
                      pSearchItemData.business_email == null ? true : false,
                  child: Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Image.asset(
                              "assets/mail.png",
                              height: 24.0,
                              width: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 8.0),
                              ),
                              Text(
                                '${pSearchItemData.business_email ?? " "}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 8.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          launch("tel:+919002647157");
                          print("tel:+919002647157");
                        },
                        child: Image.asset(
                          "assets/call.png",
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                      SizedBox(width: 50.0),
                      Image.asset(
                        "assets/forward.png",
                        height: 24.0,
                        width: 24.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5.0,
            color: Colors.grey,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: Card(
              elevation: 5,
              child: MapboxMap(
                accessToken: token,
                styleString: style,
                scrollGesturesEnabled: true,
                onMapCreated: (MapboxMapController controller) {
                  controller.addSymbol(SymbolOptions(
                    geometry: LatLng(double.parse(pSearchItemData.latitude),
                        double.parse(pSearchItemData.longitude)),
                    iconImage: "assets/location.png",
                    iconSize: 10,
                  ));
                  controller.addLine(LineOptions(
                    geometry: [
                      LatLng(-33.86711, 151.1947171),
                      LatLng(-33.86711, 151.1947171),
                      LatLng(-32.86711, 151.1947171),
                      LatLng(-33.86711, 152.1947171),
                    ],
                    lineColor: "#ff0000",
                    lineWidth: 7.0,
                    lineOpacity: 0.5,
                  ));
                },
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  zoom: 15.0,
                  target: LatLng(double.parse(pSearchItemData.latitude),
                      double.parse(pSearchItemData.longitude)),
                ),
              ),
//              Image.asset(
//                "assets/map.png",
//                fit: BoxFit.cover,
//              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: Image.asset(
                          "assets/mail.png",
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal, fontSize: 8.0),
                        ),
                        Container(
                          width: 250.0,
                          child: Text(
                            '${pSearchItemData.location}',
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 8.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: 100.0,
                  height: 32.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.redAccent),
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      String myCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ServiceMapView()),
                      );

                      setState(() {
                        cityName = myCity;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Navigate",
                          style: GoogleFonts.poppins(
                              fontSize: 10.0, color: Colors.redAccent),
                        ),
//                                    Spacer(),
//                                    Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: commonData.colorFromHex("e1e1e1"),
              ),
              margin: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Visibility(
                    visible: false,
                    child: Container(
                      width: 130.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 5.0,
                        shape: new RoundedRectangleBorder(
                          side: BorderSide(color: Colors.redAccent),
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          String myCity = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CitySearchPage()),
                          );

                          setState(() {
                            cityName = myCity;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.redAccent),
                            Spacer(),
                            Text(
                              "Check In",
                              style: GoogleFonts.poppins(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        width: 130.0,
                        height: 40.0,
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                            side: BorderSide(color: Colors.redAccent),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: () async {
                            String myCity = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CitySearchPage()),
                            );

                            setState(() {
                              cityName = myCity;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.bookmark_border_sharp,
                                  color: Colors.redAccent),
                              Spacer(),
                              Text(
                                "Twitter",
                                style: GoogleFonts.poppins(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 130.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 5.0,
                        shape: new RoundedRectangleBorder(
                          side: BorderSide(color: Colors.redAccent),
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          String shareUrl = await _createDynamicLink(
                              true,
                              page.seo_title,
                              searchItemData.header_image,
                              searchItemData.seo_url);
                          print("Share Url ::: $shareUrl");
                          Share.share(shareUrl);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.share,
                              color: Colors.redAccent,
                            ),
                            Spacer(),
                            Text(
                              "Share",
                              style: GoogleFonts.poppins(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              child: ListTile(
            title: Text(
              "About us",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: [
                isShowMore == false
                    ? Text(
                        "${pSearchItemData.description}",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.normal),
                      )
                    : Text(
                        "${pSearchItemData.description}",
                        maxLines: 20,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.normal),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isShowMore = !isShowMore;
                        });
                      },
                      child: isShowMore == false
                          ? Text(
                              "Show More",
                              style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "Show Less",
                              style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )),
          Divider(thickness: 2.0, color: Colors.grey),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Text(
                      "Services",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60.0,
                      child: ListView.builder(
                          itemCount: itemServices.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            String service_title = itemServices[index].name;
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50.0,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.redAccent,
                                    size: 14.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Text(
                                      "$service_title",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ))
              ],
            ),
          ),
          Divider(thickness: 2.0, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Payment Related",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 60.0,
                      child: ListView.builder(
                          itemCount: modeofPayments.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            String pay_title = modeofPayments[index].name;
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 50.0,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 14.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      child: Text(
                                        "$pay_title",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 2.0, color: Colors.grey),
          Divider(thickness: 2.0, color: Colors.grey),
          Container(
            decoration: BoxDecoration(
              color: commonData.colorFromHex("ebebeb"),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [commonData.colorFromHex("ebebeb"), Colors.white],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
//                              color: commonData.colorFromHex("ebebeb"),
//                              gradient: LinearGradient(
//                                begin: Alignment.centerLeft,
//                                end: Alignment.centerRight,
//                                colors: [Colors.red[100], Colors.red[900]],
//                              ),
                      ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isReview = true;
                      });
                    },
                    child: Text(
                      "Reviews & Ratings",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                    height: 45, child: VerticalDivider(color: Colors.red)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddReviewPage(
                                  seoUrl: widget.seo_url,
                                  customerID: myUserData.customerID,
                                )));
                    getSearchServiceList(widget.seo_url, widget.cityText);
                  },
                  child: Text(
                    "Write a Review",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Divider(thickness: 2.0, color: Colors.grey),
          Visibility(
            visible: isReview == true ? true : false,
            child: Container(
              height: userReviewList.length != 0
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.0,
              child: ListView.builder(
                  itemCount: userReviewList.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserReview reviewItem = userReviewList[index];
                    String rating = reviewItem.reviewRating;
                    String userName = reviewItem.customerName;
                    String createdDate = reviewItem.modifiedDate;
                    String userImage = reviewItem.customerProfilePhoto;

                    return reviewWidget(reviewItem);
                  }),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  "Related Products",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Visibility(
                visible: false,
                child: Align(
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
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (BuildContext context) =>
//                                              OTPScreen()));
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
                              color: new CommonData().colorFromHex("#e95d5d"),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          itemRelatedServices == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                      itemCount: itemRelatedServices.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        ItemRelatedServices items = itemRelatedServices[index];
                        String imageUrl = items.image;
                        String title = items.name;
                        String seo_url = items.seo_url;
                        return WidgetHotelsAndRestuarant(
                            context, index, imageUrl, title, seo_url);
                      }),
                ),
        ],
      ),
    );
  }

  Widget reviewWidget(UserReview reviewDetails) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset(
                    "assets/profile_icon.png",
                    height: 54.0,
                    width: 54.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      " ${reviewDetails.customerName}",
                      style: GoogleFonts.poppins(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "${reviewDetails.reviewTitle}",
                    style: GoogleFonts.poppins(
                        fontSize: 12.0, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ratings ",
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        RatingBarIndicator(
                          rating:
                              int.parse(reviewDetails.reviewRating).toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.redAccent,
                          ),
                          itemCount: 5,
                          itemSize: 10.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Review Descriptions :",
                style: GoogleFonts.poppins(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 12.0, right: 12.0, bottom: 3.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "${reviewDetails.reviewDesc}",
                style: GoogleFonts.poppins(
                    fontSize: 12.0, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                " Date : ${reviewDetails.createDate}",
                style: GoogleFonts.poppins(
                    fontSize: 12.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Divider(
              thickness: 4.0,
            ),
          )
        ],
      ),
    );
  }

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

  /*void onMapCreated(MapboxMapController controller) {
    controller.addSymbol(SymbolOptions(
        geometry: LatLng(
          center.latitude,
          center.longitude,
        ),
        iconImage: "airport-15"));
    controller.addLine(
      LineOptions(
        geometry: [
          LatLng(-33.86711, 151.1947171),
          LatLng(-33.86711, 151.1947171),
          LatLng(-32.86711, 151.1947171),
          LatLng(-33.86711, 152.1947171),
        ],
        lineColor: "#ff0000",
        lineWidth: 7.0,
        lineOpacity: 0.5,
      ),
    );
  }*/
}
