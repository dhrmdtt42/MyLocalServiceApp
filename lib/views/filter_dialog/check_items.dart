import 'package:flutter/material.dart';
//import 'package:global_variables.dart' as GlobalVaraible;
import 'package:haarway_app/global_variables.dart' as globals;

class CheckItem extends StatefulWidget {
  final ValueNotifier activeNotifier1;
  final ValueNotifier checkNotifier1;
  final String title;
  final int index;
  CheckItem(
      {Key key,
      @required this.index,
      @required this.activeNotifier1,
      @required this.checkNotifier1,
      @required this.title})
      : super(key: key);

  @override
  _CheckItemState createState() => _CheckItemState();
}

class _CheckItemState extends State<CheckItem> {
  bool _checked = false;
  bool _selected = false;
  int count = 0;

  Color _activeColor = Colors.deepOrangeAccent;
  Color _checkColor = Colors.white;

  @override
  void initState() {
    widget.checkNotifier1.addListener(() {
      setState(() {
        _checkColor = Colors.primaries[widget.checkNotifier1.value];
      });
    });

    widget.activeNotifier1.addListener(() {
      setState(() {
        _activeColor = Colors.primaries[widget.activeNotifier1.value];
      });
    });

    super.initState();
  }

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
            globals.sortByTitle = widget.title;

            if (_checked == false) {
              count--;
              globals.sortByCount = count;
            }
            if (_checked == true) {
              count++;
              globals.sortByCount = count;
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
