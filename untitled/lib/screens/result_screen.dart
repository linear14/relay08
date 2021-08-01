import 'package:flutter/material.dart';
import 'package:untitled/components/YoutubeItem.dart';
import 'package:untitled/components/BookItem.dart';

class ResultPage extends StatefulWidget {
  ResultPage({this.checkedList});
  List<String> checkedList;
  final dummyData = {
    "자격증1": {
      "bookList": [
        Book("자격증1", 29700, "길벗R&D, 강윤석, 김용갑", "길벗",
            'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
        Book("자격증1", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증1", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증1", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
      ],
      "youtubeUrlList": [
        "l18HCZqBs6I",
        "rqtTmj4LTTI",
        "VeIk8WSIQ2o",
        "Yc56NpYW1DM"
      ]
    },
    "자격증2": {
      "bookList": [
        Book("자격증2", 29700, "길벗R&D, 강윤석, 김용갑", "길벗",
            'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
        Book("자격증2", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증2", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증2", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
      ],
      "youtubeUrlList": [
        "KQpBt4lDx_8",
        "O0RcKP1YzGM",
        "VeIk8WSIQ2o",
        "Yc56NpYW1DM"
      ]
    },
    "자격증3": {
      "bookList": [
        Book("자격증3", 29700, "길벗R&D, 강윤석, 김용갑", "길벗",
            'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
        Book("자격증3", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증3", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증3", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
      ],
      "youtubeUrlList": [
        "EVnk8hb_R7M",
        "qUDIEyKEeec",
        "VeIk8WSIQ2o",
        "Yc56NpYW1DM"
      ]
    },
    "자격증4": {
      "bookList": [
        Book("자격증4", 29700, "길벗R&D, 강윤석, 김용갑", "길벗",
            'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
        Book("자격증4", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증4", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증4", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
      ],
      "youtubeUrlList": [
        "z0KqM3oAnus",
        "VtiHd7gjsOc",
        "VeIk8WSIQ2o",
        "Yc56NpYW1DM"
      ]
    },
    "자격증5": {
      "bookList": [
        Book("자격증5", 29700, "길벗R&D, 강윤석, 김용갑", "길벗",
            'https://bookthumb-phinf.pstatic.net/cover/189/873/18987351.jpg?type=m1&udate=20210616'),
        Book("자격증5", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증5", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713'),
        Book("자격증5", 4800, "저자2", "출판사2",
            'https://bookthumb-phinf.pstatic.net/cover/206/111/20611154.jpg?type=m1&udate=20210713')
      ],
      "youtubeUrlList": [
        "nxKfi-6EtmY",
        "0xJxgvJO2Xo",
        "VeIk8WSIQ2o",
        "Yc56NpYW1DM"
      ]
    },
  };

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _value = 0;
  var selectedMenu;

  @override
  void initState() {
    selectedMenu = widget.checkedList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Theme(
          child: new DropdownButtonHideUnderline(
            child: DropdownButton(
                // dropdown 위젯
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
                    selectedMenu = widget.checkedList[value];
                  });
                }),
          ),
          data: new ThemeData.dark(),
        ),
      ),
      body: SafeArea(
          child: ListView(
              //결과 페이지
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TitleText("추천 도서"),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.dummyData[selectedMenu]["bookList"].length,
                  itemBuilder: (context, index) {
                    final book = widget.dummyData[selectedMenu]["bookList"];
                    return BookItem(book[index]);
                  }),
              TitleText("추천 영상"),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    var url = widget.dummyData[selectedMenu]["youtubeUrlList"];
                    return YoutubeItem(url[index]);
                  }),
            ]),
          ])),
    );
  }
}

class TitleText extends StatelessWidget {
  final String str;
  TitleText(this.str);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        str,
        style: TextStyle(
          fontFamily: "Cafe24SsurroundAir",
          fontSize: 30,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
