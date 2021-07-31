import 'package:flutter/material.dart';
import 'package:untitled/components/checkBox.dart';
import 'package:untitled/second_page.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.myList});
  final myList;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  List<String> checkedList = [];
  List<Widget> searchedList = [];

  int makeCheckedList() {
    checkedList = [];
    for (int i = 0; i < widget.myList.length; i++) {
      if (widget.myList[i].checked) {
        checkedList.add(widget.myList[i].title);
      }
    }
  }

  int makeSearchedList() {
    searchedList = [];
    for (int i = 0; i < widget.myList.length; i++) {
      if (widget.myList[i].title.toString().contains(_searchText)) {
        searchedList.add(widget.myList[i]);
      }
    }
  }

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
                color: Colors.blue,
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 6,
                        child: TextField(
                            onSubmitted: (String str) {
                              setState(() {
                                makeSearchedList();
                              });
                            },
                            focusNode: focusNode,
                            style: TextStyle(fontSize: 15),
                            autofocus: true,
                            controller: _filter,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              suffixIcon: focusNode.hasFocus
                                  ? IconButton(
                                      icon: Icon(Icons.cancel, size: 20),
                                      onPressed: () {
                                        setState(() {
                                          _filter.clear();
                                          _searchText = "";
                                        });
                                      },
                                    )
                                  : Container(),
                              hintText: "검색",
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ))),
                    focusNode.hasFocus
                        ? Expanded(
                            child: FlatButton(
                            child: Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                makeSearchedList();
                                focusNode.unfocus();
                              });
                            },
                          ))
                        : Expanded(
                            child: Container(),
                            flex: 0,
                          )
                  ],
                )),
            searchedList.length == 0
                ? ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: widget.myList)
                : ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: searchedList)
          ],
        )),
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
