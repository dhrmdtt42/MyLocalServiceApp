import 'dart:typed_data';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/haar_home_screen.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/drawer_items/get_page_model.dart';
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
import 'package:haarway_app/model/home/trending_services/trending_services_base_response.dart';
import 'package:haarway_app/model/home/trending_services/trending_servies_data_model.dart';
import 'package:haarway_app/model/location/location_request.dart';
import 'package:haarway_app/model/responses/main_category_response.dart';
import 'package:haarway_app/model/responses/popular_cat_data_response.dart';
import 'package:haarway_app/model/responses/popular_service_category_base_response.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/custom_dialog.dart';
import 'package:haarway_app/utils/image_resize_factor.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/details_page/service_details_page.dart';
import 'package:haarway_app/views/edit_profile/edit_profile_page.dart';
import 'package:haarway_app/views/home/home_screen.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:haarway_app/views/home/search_pages/category_search_page.dart';
import 'package:haarway_app/views/login_page.dart';
import 'package:haarway_app/views/nav_drawer_items/help_and_support.dart';
import 'package:haarway_app/views/user_request/user_request_dashboard_page.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  CommonData commonData = new CommonData();

  static List<MainCategoryData> mainCategoryList;
  static List<PopularCategoryData> popularCategoryList;
  static List<EventsPartyData> eventPartyList;
  static List<HomeImprovementData> homeImprovementList;
  static List<EducationJobsData> educationJobsDataList;
  static List<TrendingServicesData> trendingServicesDataList;
  static List<HomeOfficeDataModel> homeofficesDatalist;
  static List<HealthCareDataModel> healthCareDataList;
  static List<CityDataModel> cityDataList;
  PopularCategoryData popularCategoryDataItem = new PopularCategoryData();
  EventsPartyData eventPartyDataItem = new EventsPartyData();
  HomeImprovementData homeImprovementData = new HomeImprovementData();
  EducationJobsData educationJobsData = new EducationJobsData();
  TrendingServicesData trendingServicesData = new TrendingServicesData();
  HomeOfficeDataModel homeOfficeDataModel = new HomeOfficeDataModel();
  HealthCareDataModel healthCareDataItem = new HealthCareDataModel();
  CityDataModel cityDataItem = new CityDataModel();
  int len;
  String cityName;
  String custId;
  Map serviceSubData = new Map();
  PersistentTabController _controller;
  bool _hideNavBar;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  String reasonNotGettingRationType;
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

  String home_ic = "assets/home_icon.png";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Container(child: HomeScreen()),
//    Container(
//        child: UserRequestPage(
//      customerID: "${myUserData.customerID}",
//    )),
    Container(),
    Center(
        child: Image.asset(
      "assets/coming_soon.png",
      height: 200.0,
    )),
//    Center(
//        child: Image.asset(
//      "assets/coming_soon.png",
//      height: 200.0,
//    )),
    Container(child: MainSearchPage()),
    Container(),
  ];

  Data myUserData = new Data();
  LocationRequestDataModel locationInfo = new LocationRequestDataModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    setState(() {
      getUserDatafromLocal();
      print(myUserData);
    });

    getMainCategoryData();
    getPopularCategoryData();
    getEventPartyData();
    getHomeImprovementData();
    getEducationJobApiCall();
    getTrendingServiesApiCall();
    getHomeAndOfficesApiCall();
    getHealthCareApiCall();

//    postRequest();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/home_icon.png",
          fit: BoxFit.fitWidth,
          height: 30.0,
          width: 30.0,
        ),
        title: "Home",
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/my_request.png"),
//                size: 40.0,
            color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
            ),
        title: ("Request"),
        onPressed: () {
          UserRequestPage(customerID: "${myUserData.customerID}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      UserRequestPage(customerID: "${myUserData.customerID}")));
        },
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/pay_icon.png"),
            size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
            ),
        title: ("Pay"),
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/explore_icon.png"),
            size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
            ),
        title: ("Explore"),
        activeColor: Colors.indigo,
        inactiveColor: Colors.grey,
        /* onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainSearchPage(
                      isExploreIcon: true,
                    )));
          }*/
      ),
      PersistentBottomNavBarItem(
          icon: ImageIcon(ExactAssetImage("assets/more_icon.png"),
              color: colorFromHex("#e95d5d"), size: 30.0
//                colorFromHex('#e95d5d')
              ),
          title: ("More"),
          activeColor: Colors.indigo,
          inactiveColor: Colors.grey,
          onPressed: () {
            _openEndDrawer();
          }),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    dependOnInheritedWidgetOfExactType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
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
                Spacer(),
                Container(
                  width: 120.0,
                  padding: EdgeInsets.symmetric(horizontal: 10),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black),
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(14)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        "${notGettingRationReasonType[0]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      value: reasonNotGettingRationType,
//                              _currentSelectedType,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          reasonNotGettingRationType = newValue;
//                        if(reasonNotGettingRationType == "Others")
//                          othersForRCReason = true;
//                        else
//                          othersForRCReason = false;
//                            state.didChange(newValue);
                        });
                      },
                      items: this._dropDownreasonNotGettingRationItems,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomOpacity: 5.0,
        ),
        body: LayoutBuilder(builder: (context, size) {
          return PersistentTabView(
            controller: _controller,
            screens: _widgetOptions,
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            hideNavigationBar: _hideNavBar,
            margin: EdgeInsets.all(10.0),
            popActionScreens: PopActionScreensType.once,
            bottomScreenMargin: 72.0,
            // onWillPop: () async {
            //   await showDialog(
            //     context: context,
            //     useSafeArea: true,
            //     builder: (context) => Container(
            //       height: 50.0,
            //       width: 50.0,
            //       color: Colors.white,
            //       child: RaisedButton(
            //         child: Text("Close"),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //   );
            //   return false;
            // },
            decoration: NavBarDecoration(
                colorBehindNavBar: Colors.white,
                borderRadius: BorderRadius.circular(20.0)),
            popAllScreensOnTapOfSelectedTab: true,
            itemAnimationProperties: ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style12, // Choose the nav bar style with this property
          );

//            Stack(
//            children: <Widget>[
//              _widgetOptions.elementAt(_selectedIndex),
//            ],
//          );
        }),
//        bottomNavigationBar: BottomNavigationBar(
//          showUnselectedLabels: true,
//          items: <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Image.asset(
//                "assets/home_icon.png",
//                fit: BoxFit.fitWidth,
//                height: 30.0,
//                width: 30.0,
//              ),
////            ImageIcon(
////              AssetImage("assets/home_icon.png"),
//////                color: colorFromHex("#e95d5d")
////            ),
//              title: Text(
//                'Home',
//                style: GoogleFonts.poppins(
//                    color: Colors.black,
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.normal),
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: ImageIcon(AssetImage("assets/my_request.png"),
////                size: 40.0,
//                  color: colorFromHex("#e95d5d")
////                colorFromHex('#e95d5d')
//                  ),
//              title: Text(
//                'Request',
//                style: GoogleFonts.poppins(
//                    color: Colors.black,
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.normal),
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: ImageIcon(AssetImage("assets/pay_icon.png"),
//                  size: 30.0, color: colorFromHex("#e95d5d")
////                colorFromHex('#e95d5d')
//                  ),
//              title: Text(
//                'Pay',
//                style: GoogleFonts.poppins(
//                    color: Colors.black,
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.normal),
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: ImageIcon(AssetImage("assets/explore_icon.png"),
//                  size: 30.0, color: colorFromHex("#e95d5d")
////                colorFromHex('#e95d5d')
//                  ),
//              title: Text(
//                'Explore',
//                style: GoogleFonts.poppins(
//                    fontSize: 12.0,
//                    color: Colors.black,
//                    fontWeight: FontWeight.normal),
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: ImageIcon(ExactAssetImage("assets/more_icon.png"),
//                  color: colorFromHex("#e95d5d"), size: 30.0
////                colorFromHex('#e95d5d')
//                  ),
//              title: Text(
//                'More',
//                style: GoogleFonts.poppins(
//                    color: Colors.black,
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.normal),
//              ),
//            ),
//          ],
//          currentIndex: _selectedIndex,
//          selectedItemColor: Colors.black,
//          onTap: (_selectedIndex) {
//            _onItemTapped(_selectedIndex);
//            if (_selectedIndex == 4) _openEndDrawer();
//          },
//        ),
        endDrawer: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 1.0,
            color: colorFromHex("#e95d5d"),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ListTile(
                    leading: myUserData != null
                        ? Container(
                            height: 52.0,
                            width: 52.0,
                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(50.0),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: myUserData.customer_profile_photo != null
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        myUserData.customer_profile_photo,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      myUserData.customer_name
                                              .substring(0, 1) ??
                                          "",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ))
//                        ? Image.network(
//                                  myUserData.customer_profile_photo,
//                            height: 52.0,
//                            width: 52.0,
//                            fit: BoxFit.cover,
//                          )
                        : Image.asset(
                            "assets/profile_icon.png",
                            height: 52.0,
                            width: 52.0,
                          ),
                    title: myUserData != null
                        ? Text(
                            "${myUserData.customer_name}",
                            style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          )
                        : Text(
                            "N/A",
                            style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                    subtitle: myUserData != null
                        ? Text(
                            "${myUserData.customer_mobile}",
                            style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          )
                        : Container(),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditProfilePage()));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                  child: Container(
//                  width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.782,
//              color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(65),
                            topLeft: Radius.circular(65))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 32.0),
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset(
                              "assets/bssn_owner.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text(
                              "Are you a business owner?",
                              style: GoogleFonts.poppins(
                                  fontSize: 10.0, fontWeight: FontWeight.bold),
                            ),
                            trailing: Container(
                              width: 150.0,
                              child: RaisedButton(
                                color: colorFromHex("#e95d5d"),
                                onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (BuildContext context) =>
//                                            EditProfilePage()));
                                },
                                child: Text(
                                  "List your Business/AD",
                                  style: GoogleFonts.poppins(
                                      fontSize: 9.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              "assets/advertise.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Advertise"),
                          ),

                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              "assets/settings.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Settings"),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              "assets/account.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Account Info"),
                          ),
//                        ListTile(
//                          leading: Image.asset(
//                            "assets/location.png",
//                            height: 20.0,
//                            width: 20.0,
//                          ),
//                          title: Text("Location"),
//                        ),
                          ListTile(
                            onTap: () async {
                              GetPageModel getPrivacyPolicy =
                                  await Provider.of<ProviderModel>(context,
                                          listen: false)
                                      .getPageApiCall(context);
                              print(getPrivacyPolicy);
                            },
                            leading: Image.asset(
                              "assets/privacy.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Privacy"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HelpAndSupportScreen()));
                            },
                            leading: Image.asset(
                              "assets/help_support.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Help & Support"),
                          ),
//                        ListTile(
//                          leading: Image.asset(
//                            "assets/language.png",
//                            height: 20.0,
//                            width: 20.0,
//                          ),
//                          title: Text("Language"),
//                        ),
                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              "assets/rating.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("Rate Us"),
                          ),
                          ListTile(
                            onTap: () async {
                              GetPageModel getPrivacyPolicy =
                                  await Provider.of<ProviderModel>(context,
                                          listen: false)
                                      .aboutUsApiCall(context);
                              print(getPrivacyPolicy);
                            },
                            leading: Image.asset(
                              "assets/about.png",
                              height: 20.0,
                              width: 20.0,
                            ),
                            title: Text("About Us"),
                          ),
                          ListTile(
                            onTap: () async {
                              if (myUserData != null) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                //Remove String
                                prefs.remove(Constants.USER);
                                Future<String> userData = commonData.getUser();
                                String myUserString = await userData;
                                Map jsonData = new Map();
                                if (myUserString == null) {
                                  setState(() {
                                    myUserData = null;
                                    print(myUserData);
                                  });
                                }
                              }
                              if (myUserData == null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignInPage()),
                                    (route) => false);

                                Toast.show("Log Off", context,
                                    gravity: 1, duration: Toast.LENGTH_LONG);
                              }
                            },
                            leading: Icon(
                              Icons.power_settings_new,
                              size: 20,
                              color: Colors.black,
                            ),

//                          Image.asset(
//                            "assets/about.png",
//                            height: 20.0,
//                            width: 20.0,
//                          ),
                            title: Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }
  // collect user data from the shared preferences================

  getUserDatafromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      print(myUserData);
      custId = myUserData.customerID;
    });
  }

  getUserLocationDatafromLocal() async {
    Future<String> userLocation = commonData.getLocationData();
    String myLocationString = await userLocation;
    Map jsonData = new Map();
    jsonData = jsonDecode(myLocationString);
    setState(() {
      locationInfo = LocationRequestDataModel.fromJson(jsonData);
      print(locationInfo);
    });
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

//    setState(() {
//      print(targetSizeUint8List);
//    });
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ServiceDetailsPage(
                      cityText: "Kolkata",
                      seo_url: deepLink.path.substring(1, deepLink.path.length),
                    )));
//        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ServiceDetailsPage(
                    cityText: "Kolkata",
                    seo_url: deepLink.path.substring(1, deepLink.path.length),
                  )));
//      Navigator.pushNamed(context, deepLink.path);
    }
  }
}
