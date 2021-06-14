import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/sub_categories/all_cat_data.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_base_response.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_data_model.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_request_data_model.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:haarway_app/views/user_request/user_request_details.dart';
import 'package:haarway_app/views/user_request/user_request_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserRequestPage extends StatefulWidget {
  final String customerID;

  UserRequestPage({@required this.customerID});

  @override
  _UserRequestPageState createState() => _UserRequestPageState();
}

class _UserRequestPageState extends State<UserRequestPage> {
  List<RequestData> requestDataList;
  UserRequestModel userRequestModel = new UserRequestModel();
  RequestData requestData = new RequestData();
  RequestDetails requestDetails = new RequestDetails();
  ProgressBar progressBar = new ProgressBar();
  Data myUserData = new Data();
  String custId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    widget.customerID = "5";
    getUserDatafromLocal();
  }

  getUserDatafromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      print(myUserData);
      custId = myUserData.customerID;
      if (custId != null) getSubCatResponses(custId);
    });
  }

  void getSubCatResponses(
    String customerID,
  ) async {
//    Map responseData = new Map();
    SubChildCatDataModelRequest subCatDataModel =
        new SubChildCatDataModelRequest();
//    subCatDataModel.mainCat = mainCat;
//    subCatDataModel.categoryID = categoryID;

    var response = await Provider.of<ProviderModel>(context, listen: false)
        .getRequestApiCall(customerID, context);
    userRequestModel = UserRequestModel.fromJson(jsonDecode(response.body));
    print(userRequestModel);
//    allCatDAtaModel = baseResponseDataModel.allCatDataModel;
    setState(() {
      requestDataList = userRequestModel.requestData;
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
            ],
          ),
        ),
        bottomOpacity: 5.0,
      ),
      body: requestDataList == null
          ? Container(
              width: double.infinity,
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
                        itemCount: 6,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () {
                  getSubCatResponses(custId);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: requestDataList.isEmpty
                          ? Center(
                              child: Text(
                                "Your Service Request is Empty ",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              itemCount: requestDataList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                requestData = requestDataList[index];
                                String name = requestData.itemName;
                                String rdate = requestData.createDate;
                                String status = requestData.status;
                                return WidgetEventsAndParty(
                                    context,
                                    index,
                                    name,
                                    rdate,
                                    status,
                                    requestData.requestDetails);
                              }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget WidgetEventsAndParty(BuildContext context, int index, String title,
      String rDate, String status, RequestDetails requestdetails) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UserRequestDetailsPage(
                        requestDetails: requestdetails,
                      )));
        },
        title: Text(
          "$title",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "$rDate",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
//                Text(
//                  "Status",
//                  style: GoogleFonts.poppins(
//                    fontWeight: FontWeight.w500,
//                    fontSize: 16.0,
//                  ),
//                ),
                Text(
                  "$status",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Colors.redAccent),
                ),
                Text(
                  "View Details",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Colors.redAccent),
                ),
              ],
            ),
          ],
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
