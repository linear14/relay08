import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      body: SafeArea(
        child: Column(children: [
          DropdownButton(
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
          BookItem(widget.bookList[0]),
          YoutubeItem(widget.urlList[0]),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Before',
        child: Icon(Icons.arrow_back_ios_sharp),
      ),
    );
  }
}

class Book {
  final String title;
  final int price;
  final String author;
  final String publisher;
  final String image;

  // final int discount;
  // final String description;

  Book(this.title, this.price, this.author, this.publisher, this.image);
}

class BookItem extends StatelessWidget {
  final Book book;

  BookItem(this.book);

  String makeComma(int number) {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(number).toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 24,
        top: 8,
        bottom: 8,
        right: 24,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(book.image,
                  fit: BoxFit.cover, width: 90, height: 120)
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(book.author, style: TextStyle(color: Colors.black54)),
                  Text(book.publisher, style: TextStyle(color: Colors.black54)),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Row(children: <Widget>[
                    Text('${makeComma(book.price)}',
                        style: TextStyle(
                            color: Colors.lightGreen[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Text('원',
                        style: TextStyle(
                            color: Colors.lightGreen[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YoutubeItem extends StatelessWidget {
  final String url;
  YoutubeItem(this.url);

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
          initialVideoId: url,
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
          )),
    );
  }
}
