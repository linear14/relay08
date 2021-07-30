import 'package:flutter/material.dart';
import 'package:untitled/components/YoutubeItem.dart';
import 'package:untitled/components/BookItem.dart';

class SecondPage extends StatefulWidget {
  SecondPage({this.checkedList});
  List<String> checkedList;
  final bookList = [
    Book(
        "[국내도서] 시나공 정보처리기사 필기(2021) : 소프트웨어 설계, 소프트웨어 개발, 데이터베이스 구축 [전 2권]",
        29700,
        "길벗R&D, 강윤석, 김용갑",
        "길벗",
        'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
    Book("책 제목2", 4800, "저자2", "출판사2",
        'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
    Book("책 제목3", 4800, "저자2", "출판사2",
        'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
    Book("책 제목4", 4800, "저자2", "출판사2",
        'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
  ];
  final urlList = ['l18HCZqBs6I', "rqtTmj4LTTI", "VeIk8WSIQ2o", "Yc56NpYW1DM"];

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Theme(
          child: new DropdownButtonHideUnderline(
            child: DropdownButton(
                value: _value,
                items: List.generate(widget.checkedList.length, (int index) {
                  return DropdownMenuItem(
                    child: Text(widget.checkedList[index]),
                    value: index,
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                }),
          ),
          data: new ThemeData.dark(),
        ),
      ),
      body: SafeArea(
          child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.bookList.length,
                  itemBuilder: (context, index) {
                    final book = widget.bookList[index];
                    return BookItem(book);
                  }),
              GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    return YoutubeItem(widget.urlList[index]);
                  })),
            ]),
          ])),
    );
  }
}


