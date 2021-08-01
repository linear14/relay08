import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/key.dart';

Future<YoutubeData> apiYoutubeUrl(String keyword) async {
  final String key = keyYoutube;

  final String apiUrl = "https://www.googleapis.com/youtube/v3/search?";
  final String part = "snippet";
  final String q = keyword;
  final String maxResults = "4";
  final String type = "video";
  final String order = "viewCount";

  final String url = apiUrl + "key=" + key + "&part=" + part + "&q=" + q +"&maxResults="+maxResults+ "&type=" +type + "&order=" +order;

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return YoutubeData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception("youtube 데이터 불러오기에 실패하였습니다.");
  }
}

class YoutubeData {
  List<Video> videos;

  YoutubeData({this.videos});

  factory YoutubeData.fromJson(Map<String, dynamic> json) {
    Iterable list = json['items'];
    List<Video> videoList = list.map((item)=> Video.fromJson(item)).toList();
    return YoutubeData(videos:videoList);
  }
}


class Video {
  String url;

  Video({this.url,});

  factory Video.fromJson(Map<String, dynamic> json) {
    final String youtubeUrl = "https://www.youtube.com/watch?v=";
    return Video(url: youtubeUrl + json['id']["videoId"]);
  }
}