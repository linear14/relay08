import 'package:flutter/material.dart';
import 'package:untitled/screens/result_screen.dart';

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

  int makeCheckedList() { //체크된 리스트의 타이틀만 저장합니다.
    checkedList = [];
    for (int i = 0; i < widget.myList.length; i++) {
      if (widget.myList[i].checked) {
        checkedList.add(widget.myList[i].title);
      }
    }
  }

  int makeSearchedList() { //체크된 리스트의 위젯자체를 저장합니다.
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

  _dialogEmpty() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("검색할 자격증을 선택해주세요."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child:SafeArea(
        child: Container(
            child: Column(
              children: [
                Container(
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        Expanded( // 검색부인데 저도 오픈소스에서 코드보고 조금 수정해서 적용했습니다..
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
                searchedList.length == 0 // searchedList 확인해서 0이면 전체를, 아니면 있는것만 반환합니다.
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          makeCheckedList();
          if(checkedList.length>0){
            Navigator.push( // ResultPage 스크린을 띄웁니다.
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(checkedList: checkedList),
              ),
            );
          }else{
            _dialogEmpty();
          }
        },
        tooltip: 'Go',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
