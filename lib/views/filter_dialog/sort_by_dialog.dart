import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/views/filter_dialog/check_items.dart';
import 'package:haarway_app/views/filter_dialog/my_constants.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:haarway_app/global_variables.dart' as globals;

class SortByCustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
//  final List<AmenitiesFilterData> amenities;
//  final List<CategoryFilterData> categrories;
//  final List<LocalityFilterData> localities;
//  final List<RadiusFilterData> radiusList;
  final List<String> sortBy;
//  final ValueNotifier activeNotifier;
//  final ValueNotifier checkNotifier;

  const SortByCustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
//      this.activeNotifier,
//      this.checkNotifier,
//      this.localities,
//      this.radiusList,
      this.sortBy})
      : super(key: key);

  @override
  _SortByCustomDialogBoxState createState() => _SortByCustomDialogBoxState();
}

class _SortByCustomDialogBoxState extends State<SortByCustomDialogBox> {
  var isSelected = false;
  var mycolor = Colors.white;
  GlobalKey tileKey = new GlobalKey();
  bool _checked = false;
  bool _selected = false;
  List<String> sortByList = new List<String>();
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
//              left: MyConstants.padding,
              top: MyConstants.avatarRadius + MyConstants.padding,
//              right: MyConstants.padding,
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
                    itemCount: widget.sortBy.length,
                    itemBuilder: (BuildContext context, int index) {
                      sortByList = widget.sortBy;
                      String title = sortByList[index];
//                      return myListCard(title);
                      return CheckItem(
                          index: index,
                          activeNotifier1: _activeColorNotifier,
                          checkNotifier1: _checkColorNotifier,
                          title: widget.sortBy[index]);
                    }),
              ),
//              ListTile(
//                subtitle: Text(
//                  "View Details",
//                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                ),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                hoverColor: Colors.grey,
//              ),
//              ListTile(
//                subtitle: Text(
//                  "Updated Status",
//                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                ),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                hoverColor: Colors.grey,
//              ),
//              ListTile(
//                subtitle: Text(
//                  "Update Location",
//                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                ),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                hoverColor: Colors.grey,
//              ),
//              ListTile(
//                subtitle: Text(
//                  "Raise Refill Request",
//                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                ),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                hoverColor: Colors.grey,
//              ),

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
                                    cityText: globals.cityText,
                                    seo_url: globals.seo_url,
                                    sortBytxt: globals.sortByTitle,
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
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: MyConstants.padding,
          right: MyConstants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: MyConstants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(MyConstants.avatarRadius)),
                child: Image.asset("assets/model.jpeg")),
          ),
        ),
      ],
    );
  }

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor = Colors.white;
        isSelected = false;
      } else {
        mycolor = Colors.grey[300];
        isSelected = true;
      }
    });
  }

  myListCard(String title) {
    return Card(
      child: new ListTile(
          selected: isSelected,
          leading: const Icon(Icons.info),
          title: new Text("$title"),
          subtitle: new Text("Test Desc"),
          trailing: new Text("3"),
          onLongPress: toggleSelection // what should I put here,
          ),
    );
  }
}
