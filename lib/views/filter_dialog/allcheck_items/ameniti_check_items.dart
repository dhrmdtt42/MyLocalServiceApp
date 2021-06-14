import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:global_variables.dart' as GlobalVaraible;
import 'package:haarway_app/global_variables.dart' as globals;
import 'package:haarway_app/model/filters/amenities_request.dart';

class CheckAmenitiesItem extends StatefulWidget {
  final ValueNotifier activeNotifier;
  final ValueNotifier checkNotifier;
  final String title;
  final String id;
  CheckAmenitiesItem(
      {Key key,
      @required this.activeNotifier,
      @required this.checkNotifier,
      @required this.title,
      @required this.id})
      : super(key: key);

  @override
  _CheckAmenitiesItemState createState() => _CheckAmenitiesItemState();
}

class _CheckAmenitiesItemState extends State<CheckAmenitiesItem> {
  bool _checked = false;
  bool _selected = false;
  int count = 0;

  Color _activeColor = Colors.deepOrangeAccent;
  Color _checkColor = Colors.white;

  @override
  void initState() {
    widget.checkNotifier.addListener(() {
      setState(() {
        _checkColor = Colors.primaries[widget.checkNotifier.value];
      });
    });

    widget.activeNotifier.addListener(() {
      setState(() {
        _activeColor = Colors.primaries[widget.activeNotifier.value];
      });
    });

    super.initState();
  }

  AmenitiesRequest amenitiesRequest = new AmenitiesRequest();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Text('${widget.title}'),
        value: _checked,
        activeColor: _activeColor,
        checkColor: _checkColor,
        onChanged: (bool value) {
          setState(() {
            _checked = value;
            _selected = value;
//            amenitiesRequest.amenitiesID = widget.title;
//            globals.amenReq.add(amenitiesRequest);
            globals.amenities = widget.id;

            if (_checked == false) {
              count++;
              globals.amenitiesCount = count;
            }
            if (_checked == true) {
              count--;
              globals.amenitiesCount = count;
            }
          });
        },
        selected: _selected,
//      secondary: Icon(Icons.beach_access),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
