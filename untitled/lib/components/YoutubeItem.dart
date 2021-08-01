import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeItem extends StatelessWidget {
  final String url;
  YoutubeItem(this.url);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: YoutubePlayer(
          controller: YoutubePlayerController(
              initialVideoId: url,
              flags: YoutubePlayerFlags(
                mute: false,
                autoPlay: false,
              )),
        ));
  }
}