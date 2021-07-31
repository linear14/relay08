import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget { // checkBox 하나하나입니다.
  MyCheckBox({@required this.title});
  final String title;
  bool checked = false;

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: widget.checked,
      onChanged: (bool value) {
        setState(() {
          widget.checked = value;
        });
      },
      secondary: const Icon(Icons.assignment),
      isThreeLine: false,
      selected: widget.checked,
    );
  }
}
