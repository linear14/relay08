import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/key.dart';

Future<List<Workbook>> fetchQuestions(http.Client client, String keyword) async {
  final String key = keyWorkbook;

  final uri = "http://apis.data.go.kr/B490007/openQst/getOpenQstList?" +
      "serviceKey=$key&" +
      "dataFormat=json&" +
      "numOfRows=4&" +
      "pageNo=1&" +
      "qualgbCd=T&" +
      "jmNm=$keyword";

  final response = await client.get(Uri.parse(uri));
  final Map<String, dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));

  return (responseJson['body']['items'] as List)
      .map((qb) => Workbook.fromJson(qb))
      .toList();
}

class Workbook {
  final String artlSeq;
  final String title;
  final String jmNm;

  const Workbook({
    this.artlSeq,
    this.title,
    this.jmNm,
  });

  factory Workbook.fromJson(Map<String, dynamic> json) {
    return Workbook(
      artlSeq: json['artlSeq'].toString(),
      title: json['title'] as String,
      jmNm: json['jmNm'] as String,
    );
  }
}