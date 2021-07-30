import 'package:flutter/material.dart';
import 'package:untitled/second_page.dart';

class CheckBoxList extends StatefulWidget {
  CheckBoxList({this.myList});
  final myList;

  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  List<String> checkedList = [];

  int makeCheckedList() {
    checkedList = [];
    for (int i=0; i<widget.myList.length; i++) {
      if (widget.myList[i].checked) {
        checkedList.add(widget.myList[i].title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: widget.myList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          makeCheckedList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(checkedList: checkedList),
            ),
          );
        },
        tooltip: 'Go',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
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