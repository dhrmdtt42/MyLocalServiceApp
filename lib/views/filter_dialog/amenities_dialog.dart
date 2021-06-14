import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/views/filter_dialog/allcheck_items/ameniti_check_items.dart';
import 'package:haarway_app/views/filter_dialog/my_constants.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:haarway_app/global_variables.dart' as globals;

class AmenitiesCustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final List<AmenitiesFilterData> amenities;
//  final List<CategoryFilterData> categrories;
//  final List<LocalityFilterData> localities;
//  final List<RadiusFilterData> radiusList;
//  final List<String> sortBy;

  const AmenitiesCustomDialogBox({
    Key key,
    this.title,
    this.descriptions,
    this.text,
    this.img,
    this.amenities,
//      this.categrories,
//      this.localities,
//      this.radiusList,
//      this.sortBy
  }) : super(key: key);

  @override
  _AmenitiesCustomDialogBoxState createState() =>
      _AmenitiesCustomDialogBoxState();
}

class _AmenitiesCustomDialogBoxState extends State<AmenitiesCustomDialogBox> {
  var isSelected = false;
  var mycolor = Colors.white;
  GlobalKey tileKey = new GlobalKey();
  bool _checked = false;
  bool _selected = false;

  Color _activeColor = Colors.green;
  Color _checkColor = Colors.black;

  ValueNotifier<int> _activeColorNotifier;
  ValueNotifier<int> _checkColorNotifier;

  @override
  void initState() {
    // TODO: implement initState

    _activeColorNotifier = ValueNotifier(0);
    _checkColorNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: MyConstants.padding,
              top: MyConstants.avatarRadius + MyConstants.padding,
              right: MyConstants.padding,
              bottom: MyConstants.padding),
          margin: EdgeInsets.only(top: MyConstants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(MyConstants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                    itemCount: widget.amenities.length,
                    itemBuilder: (BuildContext context, int index) {
                      AmenitiesFilterData amData = widget.amenities[index];
                      String title = amData.amenities_name;
                      String id = amData.amenitiesID;
                      return CheckAmenitiesItem(
                          activeNotifier: _activeColorNotifier,
                          checkNotifier: _checkColorNotifier,
                          title: title,
                          id: id);
                    }),
              ),

              SizedBox(
                height: 15,
              ),
              // Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              // SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductSearchPageList(
                                    isFromHomePage: true,
                                    cityText: globals.cityText,
                                    seo_url: globals.seo_url,
//                                    sortBytxt: globals.sortByTitle,
                                  )),
                          (route) => false);
                    },
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 5.0,
                      color: Colors.deepOrangeAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
