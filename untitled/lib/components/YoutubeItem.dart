import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeItem extends StatefulWidget {
  final String url;
  YoutubeItem(this.url);

  @override
  _YoutubeItemState createState() => _YoutubeItemState();
}

class _YoutubeItemState extends State<YoutubeItem> {

  @override
  void initState() {
    print(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: YoutubePlayer(
          controller: YoutubePlayerController(
              initialVideoId: widget.url,
              flags: YoutubePlayerFlags(
                mute: false,
                autoPlay: false,
              )),
        ));
  }
}



