// data.go.kr의 공공데이터를 사용하려 하였으나 key 인증 실패로 assets/data directory의
// data directory의 licenseList.json 파일로 대체하였습니다.
import 'dart:convert';
import 'package:flutter/services.dart';

// Fetch content from the json file
Future apiLicenseList() async {
  final String response = await rootBundle.loadString('assets/data/licenseList.json');
  return await json.decode(response);
}