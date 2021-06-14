import 'package:flutter/material.dart';
//import 'package:global_variables.dart' as GlobalVaraible;
import 'package:haarway_app/global_variables.dart' as globals;
import 'package:haarway_app/views/filter_dialog/filter_request_data/loc_request.dart';

class CheckLocalityItems extends StatefulWidget {
  final ValueNotifier activeNotifier;
  final ValueNotifier checkNotifier;
  final String title;
  final int index;
  CheckLocalityItems(
      {Key key,
      @required this.index,
      @required this.activeNotifier,
      @required this.checkNotifier,
      @required this.title})
      : super(key: key);

  @override
  _CheckLocalityItemsState createState() => _CheckLocalityItemsState();
}

class _CheckLocalityItemsState extends State<CheckLocalityItems> {
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

  LocalityRequest localityRequest = new LocalityRequest();

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
            globals.local = widget.title;

//            if (_checked == false) {
//
//              count--;
//              globals.locCount = count;
//            }
//            if (_checked == true) {
//              count++;
//              globals.locCount = count;
//            }

            if (_checked == true) {
              Localities locality = new Localities();
              locality.locality = widget.title;
              localityRequest.localities.add(locality);
              globals.locality.add(localityRequest);
              globals.locIndex.add(widget.index);
              print(globals.locality);
            }
            if (_checked == false && globals.locIndex.contains(widget.index)) {
              globals.locIndex.remove(widget.index);
              globals.locality.remove(widget.index);
              print(globals.locality);
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
