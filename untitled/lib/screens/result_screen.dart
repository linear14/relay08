import 'package:flutter/material.dart';
import 'package:untitled/api/apiWorkbook.dart';
import 'package:untitled/components/WorkbookList.dart';
import 'package:untitled/components/YoutubeItem.dart';
import 'package:untitled/components/BookItem.dart';
import 'package:untitled/data/SearchKeyword.dart';
import '../api/apiYoutubeUrl.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  ResultPage({this.checkedList});
  List<String> checkedList;
  List bookList = [
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
  // List urlList = ['l18HCZqBs6I', "rqtTmj4LTTI", "VeIk8WSIQo", "Yc56NpYW1DM"];

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _value;
  Future _futureYoutube;

  // 수정 필요

  // 1. api 호출 init 처리
  // 2. 유튜브 플레이어 업데이트 이슈
  //      1. 에러와 함께 썸네일이 빨간색 x자가 뜬다.
  //      2. 순서 업데이트 문제
  // 3. 자격증 목록 api실패 -> json으로 연동
  // 4. 책 목록 api 연동 (node쓰시고 싶으면 바꾸셔도 괜찮아요~)
  // 5. 자격기술서 api 연동
  //
  // 하면 끝! 프론트분들 잘짜주셔서 놀라면서 금방했어요. 감사하네요 ㅎㅎ

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._value = 0;
    final String checkedCertificate = widget.checkedList[this._value];
    this._futureYoutube =  apiYoutubeUrl(checkedCertificate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Theme(
          child: new DropdownButtonHideUnderline(
            child: DropdownButton( // dropdown 위젯
                value: _value,
                items: List.generate(widget.checkedList.length, (int index) {
                  return DropdownMenuItem(
                    child: Text(widget.checkedList[index]),
                    value: index,
                  );
                }),
                onChanged: (value) {
                  final String checkedCertificate = widget.checkedList[value];
                  setState(() {
                    this._value = value;
                    this._futureYoutube =  apiYoutubeUrl(checkedCertificate);
                  });
                }),
          ),
          data: new ThemeData.dark(),
        ),
      ),
      body: SafeArea(
          child: ListView( //결과 페이지
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TitleText("추천 도서"),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.bookList.length,
                      itemBuilder: (context, index) {
                        final book = widget.bookList[index];
                        return BookItem(book);
                      }),
                  TitleText("추천 영상"),
                  FutureBuilder<YoutubeData>(
                    future: this._futureYoutube,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final videos = snapshot.data.videos;
                        return GridView.count(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(videos.length, (index) {
                              return YoutubeItem(videos[index].url);
                            }));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}')
                        );
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  TitleText("문제 추천"),
                  FutureBuilder<List<Workbook>>(
                    future: fetchQuestions(http.Client(), keywordMap[widget.checkedList[this._value]]),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return Center(
                          child: WorkbookList(workbooks: snapshot.data)
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
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