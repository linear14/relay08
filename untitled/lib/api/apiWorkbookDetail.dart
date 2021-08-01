import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/key.dart';

Future<List<WorkbookDetail>> fetchDetails(http.Client client, String id) async {
  final String key = keyWorkbook;

  final uri = "http://apis.data.go.kr/B490007/openQst/getOpenQst?" +
      "serviceKey=$key&" +
      "dataFormat=json&" +
      "qualgbCd=T&" +
      "artlSeq=$id";

  final response = await client.get(Uri.parse(uri));
  final Map<String, dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));

  return (responseJson['body']['fileList'] as List)
      .map((qb) => WorkbookDetail.fromJson(qb))
      .toList();
}


class WorkbookDetail {
  final String fileNm;
  final String fileUrl;

  const WorkbookDetail({
    this.fileNm,
    this.fileUrl
  });

  factory WorkbookDetail.fromJson(Map<String, dynamic> json) {
    return WorkbookDetail(
        fileNm: json['fileNm'] as String,
        fileUrl: json['fileUrl'] as String
    );
  }
}