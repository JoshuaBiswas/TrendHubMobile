import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CreativeLearn extends StatefulWidget {
  const CreativeLearn({super.key});

  @override
  State<CreativeLearn> createState() => _CreativeLearnState();
}

class _CreativeLearnState extends State<CreativeLearn> {
  final videoURL = "https://www.youtube.com/watch?v=YMx8Bbev6T4";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint("Ready to play the youtube video!"),
          ),
        )
      ],
    ));
  }
}
