import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:untitled/api/apiBook.dart';
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

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _value;
  Widget _widgetYoutube;
  Future _futureYoutube;
  Future _futureNaver;

  Widget getWidgetYoutube(Future future){
    return FutureBuilder<YoutubeData>(
      future: future,
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
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._value = 0;
    final String checkedCertificate = widget.checkedList[this._value];
    final Future futureYoutube =  apiYoutubeUrl(checkedCertificate);
    this._widgetYoutube = getWidgetYoutube(futureYoutube);
    this._futureNaver = requestNaverBookUrl(checkedCertificate);
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
                  Future futureYoutube =  apiYoutubeUrl(checkedCertificate);
                  setState(() {
                    this._value = value;
                    this._futureNaver = requestNaverBookUrl(checkedCertificate);
                    this._widgetYoutube =  TitleText("Loading...");
                    Future.delayed(Duration(seconds: 1),()=>setState(() {
                      this._widgetYoutube =  getWidgetYoutube(futureYoutube);
                    }));
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
                  FutureBuilder<NaverBook>(
                    future: this._futureNaver,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final _books = snapshot.data.items;
                        List<BookData> books = _books.map((e) => BookData.fromJson(e)).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 4, // widget.bookList.length
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return BookItem(Book(
                              parse(book.title).documentElement.text,
                              book.price,
                              book.author,
                              book.publisher,
                              book.image,
                            ));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  TitleText("추천 영상"),
                  this._widgetYoutube,
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