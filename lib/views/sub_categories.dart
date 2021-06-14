import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/sub_categories/all_cat_data.dart';
import 'package:haarway_app/model/sub_categories/sub_cat_base_response_model.dart';
import 'package:haarway_app/model/sub_categories/sub_cat_data_model.dart';
import 'package:haarway_app/model/sub_categories/subcat__request_data_model.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:haarway_app/views/subchild_cat_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubCategory extends StatefulWidget {
  final String mainCat;
  final String parentId;

  SubCategory({this.mainCat, this.parentId});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List<String> events_partyList;

  SubCatDataRequestModel subcatData = new SubCatDataRequestModel();
  List<SubCatDataModel> subcatItemList;
  SubCatBaseResponseDataModel baseResponseDataModel =
      new SubCatBaseResponseDataModel();
  SubCatDataModel subcatDataItem = new SubCatDataModel();
  AllCatDataModel allCatDAtaModel = new AllCatDataModel();
  List<AllCatDataModel> allDataList = new List<AllCatDataModel>();
  List<SubCatDataModel> list = new List<SubCatDataModel>();

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
      widget.parentId,
    );
  }

  void getSubCatResponses(
    String mainCat,
    String parentId,
  ) async {
//    Map responseData = new Map();
    SubCatDataRequestModel subCatDataModel = new SubCatDataRequestModel();
    subCatDataModel.mainCat = mainCat;
    subCatDataModel.parentID = parentId;

    var response = await Provider.of<ProviderModel>(context, listen: false)
        .getSubCategoryApiCall(subCatDataModel, context);
    baseResponseDataModel =
        SubCatBaseResponseDataModel.fromJson(jsonDecode(response.body));
    setState(() {
      list = baseResponseDataModel.subCatDataList;
      allCatDAtaModel = baseResponseDataModel.allCatDataModel;

      if (list.isNotEmpty) {
        subcatItemList = baseResponseDataModel.subCatDataList;
        allDataList.add(allCatDAtaModel);
      }
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
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
//              Container(
//                  child: Card(
//                elevation: 5.0,
//                child: ListTile(
//                  title: Text(
//                    "All Options",
//                    style: GoogleFonts.poppins(
//                      fontWeight: FontWeight.normal,
//                      fontSize: 14.0,
//                    ),
//                  ),
//                  trailing: Icon(
//                    Icons.arrow_forward_ios,
//                    size: 25.0,
//                    color: Colors.black,
//                  ),
//                ),
//              )),
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: allDataList == null
                        ? Center(
                            child: Container(),
                          )
                        : ListView.builder(
                            itemCount: allDataList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              AllCatDataModel allCatData =
                                  new AllCatDataModel();
                              allCatData = allDataList[index];
                              String title = allCatData.category_title;
                              String imageUrl = events_partyList[0];
                              String mainCat = subcatDataItem.mainCat;
                              String catId = subcatDataItem.categoryID;
                              return AllCatDataWidget(allDataList, context,
                                  index, title, imageUrl, mainCat, catId);
                            }),
                  ),
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
                              String title = subcatDataItem.category_title;
                              String imageUrl = events_partyList[0];
                              String mainCat = subcatDataItem.mainCat;
                              String catId = subcatDataItem.categoryID;
                              return WidgetEventsAndParty(
                                  subcatItemList,
                                  context,
                                  index,
                                  title,
                                  imageUrl,
                                  mainCat,
                                  catId);
                            }),
                  ),
                ],
              ),
            ),
    );
  }

  Widget WidgetEventsAndParty(
      List<SubCatDataModel> subcatList,
      BuildContext context,
      int index,
      String title,
      String imageUrl,
      String mainCat,
      String catID) {
    return Card(
      child: ListTile(
        onTap: () {
          if (list.isNotEmpty) {
//            String mainCat = subcatList[index]['']
            getSubCatResponses(mainCat, catID);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SubChildCategoryList(
                          mainCat: mainCat,
                          categoryID: catID,
                        )));
          }
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
