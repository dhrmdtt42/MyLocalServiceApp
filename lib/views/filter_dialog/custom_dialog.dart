import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haarway_app/model/filters/amenities.dart';
import 'package:haarway_app/model/filters/attribute.dart';
import 'package:haarway_app/model/filters/filter_category.dart';
import 'package:haarway_app/model/filters/locality.dart';
import 'package:haarway_app/model/filters/radius.dart';
import 'package:haarway_app/views/filter_dialog/my_constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final List<AmenitiesFilterData> amenities;
  final List<dynamic> categrories;
  final List<LocalityFilterData> localities;
  final List<RadiusFilterData> radiusList;
  final List<dynamic> attributes;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.amenities,
      this.categrories,
      this.localities,
      this.radiusList,
      this.attributes})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: getAttributeData(),
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
              ListTile(
                subtitle: Text(
                  "View Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                hoverColor: Colors.grey,
              ),
              ListTile(
                subtitle: Text(
                  "Updated Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                hoverColor: Colors.grey,
              ),

              ListTile(
                subtitle: Text(
                  "Update Location",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                hoverColor: Colors.grey,
              ),
              ListTile(
                subtitle: Text(
                  "Raise Refill Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                hoverColor: Colors.grey,
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
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18),
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

  getAttributeData() {
    return Container(
      child: ListView.builder(
          itemCount: widget.attributes.length,
          itemBuilder: (BuildContext context, int index) {
            AttributeFilterData attributeFilterData =
                new AttributeFilterData.fromJson(widget.attributes[index]);
            String attributeTitle = attributeFilterData.name;

            return getAttributeList(attributeTitle, index);
          }),
    );
  }

  getAttributeList(String title, int index) {
    Map checkIndex = new Map();
    bool isSelected = false;
    return Container(
      child: ListTile(
        key: UniqueKey(),
        selected: isSelected,
        onTap: () {
          isSelected = true;
          checkIndex.putIfAbsent(index, () => title);
        },
        title: Text("$title"),
      ),
    );
  }
}
