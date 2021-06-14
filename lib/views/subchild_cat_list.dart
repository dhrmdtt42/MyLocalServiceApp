import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/sub_categories/all_cat_data.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_base_response.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_data_model.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_request_data_model.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubChildCategoryList extends StatefulWidget {
  final String mainCat;
  final String categoryID;

  SubChildCategoryList({this.mainCat, this.categoryID});

  @override
  _SubChildCategoryListState createState() => _SubChildCategoryListState();
}

class _SubChildCategoryListState extends State<SubChildCategoryList> {
  List<String> events_partyList;

  SubChildCatDataModelRequest subcatData = new SubChildCatDataModelRequest();
  List<SubChildCatDataModel> subcatItemList;
  SubChildCatBaseResponse baseResponseDataModel = new SubChildCatBaseResponse();
  SubChildCatDataModel subcatDataItem = new SubChildCatDataModel();
  AllCatDataModel allCatDAtaModel = new AllCatDataModel();
  List<AllCatDataModel> allDataList = new List<AllCatDataModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

    getSubCatResponses(
      widget.mainCat,
      widget.categoryID,
    );
  }

  void getSubCatResponses(
    String mainCat,
    String categoryID,
  ) async {
//    Map responseData = new Map();
    SubChildCatDataModelRequest subCatDataModel =
        new SubChildCatDataModelRequest();
    subCatDataModel.mainCat = mainCat;
    subCatDataModel.categoryID = categoryID;

    var response = await Provider.of<ProviderModel>(context, listen: false)
        .getSubChildCategoryApiCall(subCatDataModel, context);
    baseResponseDataModel =
        SubChildCatBaseResponse.fromJson(jsonDecode(response.body));
//    allCatDAtaModel = baseResponseDataModel.allCatDataModel;
    setState(() {
      subcatItemList = baseResponseDataModel.subChildCatList;
    });
//    subcatItemList = baseResponseDataModel.subCatDataList;
  }

  int _selectedIndex = 0;
  CommonData commonData = new CommonData();
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          automaticallyImplyLeading: false,
//          backgroundColor: Colors.white,
//          title: Align(
//            alignment: Alignment.topLeft,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Container(
//                    child: Image.asset(
//                  'assets/haarway.png',
//                  width: 140,
//                  height: 80.0,
//                )),
//              ],
//            ),
//          ),
//          bottomOpacity: 5.0,
//        ),
        body: subcatItemList == null
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Center(
                              child: Text(
                                "Choose what type of services do you want ?",
                                style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(
                              "All Options",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        )),

//              Container(
//                decoration: BoxDecoration(),
//                width: MediaQuery.of(context).size.width * 0.95,
//                height: MediaQuery.of(context).size.height * 0.075,
//                child: allDataList == null
//                    ? Center(
//                        child: Container(),
//                      )
//                    : ListView.builder(
//                        itemCount: allDataList.length,
//                        scrollDirection: Axis.vertical,
//                        itemBuilder: (BuildContext context, int index) {
//                          AllCatDataModel allCatData = new AllCatDataModel();
//                          allCatData = allDataList[index];
//                          String title = allCatData.category_title;
//                          String imageUrl = events_partyList[0];
//                          String mainCat = subcatDataItem.mainCat;
//                          String catId = subcatDataItem.categoryID;
//                          return AllCatDataWidget(allDataList, context, index,
//                              title, imageUrl, mainCat, catId);
//                        }),
//              ),

                    Container(
                      decoration: BoxDecoration(),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: subcatItemList == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: subcatItemList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                subcatDataItem = subcatItemList[index];
                                String title = subcatDataItem.name;
                                String imageUrl = events_partyList[0];
                                String seo_url = subcatDataItem.seo_url;
                                return WidgetEventsAndParty(
                                    context, index, title, imageUrl, seo_url);
                              }),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/home_icon.png",
                fit: BoxFit.fitWidth,
                height: 30.0,
                width: 30.0,
              ),
//            ImageIcon(
//              AssetImage("assets/home_icon.png"),
////                color: colorFromHex("#e95d5d")
//            ),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/my_request.png"),
//                size: 40.0,
                  color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Request',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/pay_icon.png"),
                  size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Pay',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/explore_icon.png"),
                  size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Explore',
                style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/more_icon.png"),
                color: colorFromHex("#e95d5d"),
                size: 30,
//                colorFromHex('#e95d5d')
              ),
              title: Text(
                'More',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: (_selectedIndex) {
//          _onItemTapped(_selectedIndex);
            _openEndDrawer();
          },
        ),
        endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 1.0,
          color: colorFromHex("#e95d5d"),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/profile_icon.png",
                      height: 52.0,
                      width: 52.0,
                    ),
                    title: Text(
                      "Dharam Dutt Mishra",
                      style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      "9002618898",
                      style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
//                    trailing: RaisedButton.icon(
//                        color: colorFromHex("#e95d5d"),
//                        onPressed: () {},
//                        icon: Icon(
//                          Icons.power_settings_new,
//                          color: Colors.white,
//                        ),
//                        label: Text(
//                          "Logout",
//                          style: GoogleFonts.poppins(
//                              fontSize: 10.0,
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold),
//                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
//                  width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.782,
//              color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(65),
                            topLeft: Radius.circular(65))),
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
                              onPressed: () {},
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
                          leading: Image.asset(
                            "assets/advertise.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Advertise"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/settings.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Settings"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/account.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Account Info"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/location.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Location"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/privacy.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Privacy"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/help_support.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Help & Support"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/language.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Language"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/rating.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Rate Us"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/about.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("About Us"),
                        ),
                        ListTile(
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
              ],
            ),
          ),
        ));
  }

  Widget WidgetEventsAndParty(BuildContext context, int index, String title,
      String imageUrl, String seoUrl) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProductSearchPageList(
                        seo_url: seoUrl,
                        cityText: "",
                      )));
        },
        leading: Image.asset(imageUrl),
        title: Text(
          "$title",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          "Please Visit us again",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget myWidget() {}

  Widget AllCatDataWidget(
      List<AllCatDataModel> subcatList,
      BuildContext context,
      int index,
      String title,
      String imageUrl,
      String mainCat,
      String catID) {
    return Card(
      child: ListTile(
        onTap: () {
//          if (list.isNotEmpty) {
//            getSubCatResponses(mainCat, catID);
//          } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProductSearchPageList(
//                      mainCat: mainCat,
//                      categoryID: catID,
                      )));
//          }
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 25.0,
          color: Colors.black,
        ),
        title: Text(
          "All $title Options",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
