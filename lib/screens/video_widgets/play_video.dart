import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayYoutubeVideo extends StatefulWidget {
  final String title;
  final String videoId;
  const PlayYoutubeVideo({Key? key, required this.title, required this.videoId})
      : super(key: key);

  @override
  _PlayYoutubeVideoState createState() => _PlayYoutubeVideoState();
}

class _PlayYoutubeVideoState extends State<PlayYoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  initState() {
    initYoutubePlayer();
    super.initState();
  }

  initYoutubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                player,
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () => launch(
                      "https://www.youtube.com/watch?v=" + widget.videoId),
                  child: Container(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'View On Youtube',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(
                //       15,
                //     ),
                //   ),
                //   child: Text('View on Youtube'),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }
}
