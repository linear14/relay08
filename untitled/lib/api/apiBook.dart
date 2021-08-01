import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_api/api/key.dart' as Key;

// 예시 : /v1/search/book.xml?query=%EC%A3%BC%EC%8B%9D&display=10&start=1
// Future<NaverBookData>
void requestNaverBookUrl(String keyword) async {
  String apiUrl = "https://openapi.naver.com/v1/search/book?";
  int start = 1; //검색 시작 위치
  int display = 10; //가져올 이미지 갯수
  Map<String, String> headers = {
    'X-Naver-Client-Id': Key.naverClientID,
    'X-Naver-Client-Secret': Key.naverClientSecret
  };
  String url = apiUrl + "query=" + keyword + "&start=" + start.toString() + "&display=" + display.toString();
  print(url);
  http.Response response = await http.get(Uri.parse(url),
      headers: {
        'X-Naver-Client-Id': Key.naverClientID,
        'X-Naver-Client-Secret': Key.naverClientSecret
      }
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response);
    //final data =NaverBookData.fromJson(jsonDecode(response.body));
    //return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception("naverBook 데이터 불러오기에 실패하였습니다.");
  }
}

// class NaverBookData {
//   List<Video> books;
//   NaverBookData({required this.books});
//   factory NaverBookData.fromJson(Map<String, dynamic> json) {
//     Iterable list = json['items'];
//     print(list.runtimeType);
//     List<Video> videoList = list.map((item)=> Video.fromJson(item)).toList();
//     return NaverBookData(videos:videoList);
//   }
// }
// class Video {
//   String url;
//   Video({required this.url,});
//   factory Video.fromJson(Map<String, dynamic> json) {
//     final String YOUTUBEURL = "https://www.youtube.com/watch?v=";
//     return Video(url: YOUTUBEURL + json['id']["videoId"]);
//   }
// }