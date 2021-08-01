// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YoutubeItem extends StatelessWidget {
//   final String url;
//   YoutubeItem(this.url);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: YoutubePlayer(
//           controller: YoutubePlayerController(
//               initialVideoId: url,
//               flags: YoutubePlayerFlags(
//                 mute: false,
//                 autoPlay: false,
//               )),
//         ));
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class YoutubeItem extends StatelessWidget {
  final String url;
  YoutubeItem(this.url);
  @override
  Widget build(BuildContext context) {
    String html = '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>webview-simple</title>
</head>
<body>
<iframe style="width:100%;height:100%;top:0;left:0;position:absolute;"
 src="https://www.youtube.com/embed/${url}?autoplay=1&enablejsapi=1"
 frameborder="0" allow="autoplay">
</iframe>
</body>
</html>
''';
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(html));
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: WebView(
          initialUrl: 'data:text/html;base64,$contentBase64',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}