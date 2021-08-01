import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Book {
  final String title;
  final String price;
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
                  fit: BoxFit.cover, width: 90, height: 120)),
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
                    Text('${makeComma(int.parse(book.price))}',
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