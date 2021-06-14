import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/views/filter_dialog/my_constants.dart';
import 'package:haarway_app/views/home/search_pages/product_search_page.dart';
import 'package:item_selector/item_selector.dart';
import 'package:haarway_app/global_variables.dart' as globals;

class RadiusCustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
//  final List<AmenitiesFilterData> amenities;
//  final List<CategoryFilterData> categrories;
//  final List<LocalityFilterData> localities;
  final RadiusFilterData radius;
//  final List<String> sortBy;

  const RadiusCustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.radius})
      : super(key: key);

  @override
  _RadiusCustomDialogBoxState createState() => _RadiusCustomDialogBoxState();
}

class _RadiusCustomDialogBoxState extends State<RadiusCustomDialogBox> {
  bool _checked1 = false;
  bool _checked2 = false;
  bool _checked3 = false;
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;
  int count = 0;

  Color _activeColor = Colors.deepOrangeAccent;
  Color _checkColor = Colors.white;
  ValueNotifier<int> _activeColorNotifier;
  ValueNotifier<int> _checkColorNotifier;

  @override
  void initState() {
    // TODO: implement initState

    _activeColorNotifier = ValueNotifier(0);
    _checkColorNotifier = ValueNotifier(0);

    _checkColorNotifier.addListener(() {
      setState(() {
        _checkColor = Colors.primaries[_checkColorNotifier.value];
      });
    });

    _activeColorNotifier.addListener(() {
      setState(() {
        _activeColor = Colors.primaries[_activeColorNotifier.value];
      });
    });

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
          child: ItemSelectionController(
            selection: ItemSelection(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CheckboxListTile(
                  title: Text('max : ${widget.radius.max}'),
                  value: _checked1,
                  activeColor: _activeColor,
                  checkColor: _checkColor,
                  onChanged: (bool value) {
                    setState(() {
                      _checked1 = value;
                      _selected1 = value;
                      globals.radius = widget.title;

                      if (_checked1 == false) {
                        count--;
                        globals.radCount = count;
                      }
                      if (_checked1 == true) {
                        count++;
                        globals.radCount = count;
                      }
                    });
                  },
                  selected: _selected1,
//      secondary: Icon(Icons.beach_access),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                CheckboxListTile(
                  title: Text('min : ${widget.radius.min}'),
                  value: _checked2,
                  activeColor: _activeColor,
                  checkColor: _checkColor,
                  onChanged: (bool value) {
                    setState(() {
                      _checked2 = value;
                      _selected2 = value;
                      globals.radius = widget.title;

                      if (_checked2 == false) {
                        count--;
                        globals.radCount = count;
                      }
                      if (_checked2 == true) {
                        count++;
                        globals.radCount = count;
                      }
                    });
                  },
                  selected: _selected2,
//      secondary: Icon(Icons.beach_access),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                CheckboxListTile(
                  title: Text('step : ${widget.radius.step}'),
                  value: _checked3,
                  activeColor: _activeColor,
                  checkColor: _checkColor,
                  onChanged: (bool value) {
                    setState(() {
                      _checked3 = value;
                      _selected3 = value;
                      globals.radius = widget.title;

                      if (_checked3 == false) {
                        count--;
                        globals.radCount = count;
                      }
                      if (_checked3 == true) {
                        count++;
                        globals.radCount = count;
                      }
                    });
                  },
                  selected: _selected3,
//      secondary: Icon(Icons.beach_access),
                  controlAffinity: ListTileControlAffinity.trailing,
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
                                      cityText: globals.cityText,
                                      seo_url: globals.seo_url,
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
}
