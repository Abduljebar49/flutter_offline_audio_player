import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AssetsAudioPlayer advancedPlayer;
  final String url;
  final String title;
  final data;
  const AudioFile({
    Key? key,
    required this.advancedPlayer,
    required this.url,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  double playbackRate = 1.0;
  //late AudioPlayer audioPlayer;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  Color loopColor = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  //final String url =
  //    'https://thenaatsharif.com/downloads/javeria-saleem/maula-ya-salli-wa-sallim.mp3';

  @override
  void initState() {
    super.initState();
    // this.widget.advancedPlayer.setUrl(widget.url);
    initializeListeners();
  }

  initializeListeners() async {
    try {
      await widget.advancedPlayer.open(
        Audio.network(
          widget.url,
          metas: Metas(
            title: widget.data['title'],
            artist: "Artist Caayaa",
            album: widget.data['text'],
            image: MetasImage.asset(
                "assets/images/headset.jpg"), //can be MetasImage.network
          ),
        ),
        autoStart: false,
        showNotification: true,
        notificationSettings: NotificationSettings(
          prevEnabled: false, //disable the previous button
          nextEnabled: false,
          //and have a custom next action (will disable the default action)
          // customNextAction: (player) {
          //   print("next");
          // }
        ),
      );
    } catch (t) {
      //mp3 unreachable
    }

    widget.advancedPlayer.current.listen((playingAudio) {
      // final asset = playingAudio.assetAudio;
      setState(() {
        _duration = playingAudio!.audio.duration;
      });

      // final songDuration = playingAudio!.audio.duration;
    });

    widget.advancedPlayer.currentPosition.listen((event) {
      setState(() {
        _position = event;
      });
    });
    widget.advancedPlayer.playlistAudioFinished.listen((Playing playing) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isLoop) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isLoop = false;
        }
      });
    });

    // this.widget.advancedPlayer.onDurationChanged.listen((Duration d) {
    //   print("inside duration changed $d");
    //   setState(() {
    //     _duration = d;
    //   });
    // });
    // this.widget.advancedPlayer.onAudioPositionChanged.listen((Duration p) {
    //   print("inside position changed $p");
    //   setState(() {
    //     _position = p;
    //   });
    // });
    // this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
    //   setState(() {
    //     _position = Duration(seconds: 0);
    //     if (isLoop) {
    //       isPlaying = true;
    //     } else {
    //       isPlaying = false;
    //       isLoop = false;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                ),
                Text(
                  _duration.toString().split(".")[0],
                ),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }

  Widget slowBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (playbackRate > 0.0) {
            playbackRate = playbackRate - 0.1;
          }
        });
        this.widget.advancedPlayer.setPlaySpeed(playbackRate);
      },
      icon: Icon(
        CupertinoIcons.backward_fill,
        size: 30,
        color: Colors.black,
      ),
    );
  }

  Widget startBtn() {
    return IconButton(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      onPressed: () async {
        print("inside playing audio");
        if (!isPlaying) {
          // await this
          //     .widget
          //     .advancedPlayer
          //     .notificationService
          //     .startHeadlessService();
          // await this.widget.advancedPlayer.notificationService.setNotification(
          //       title: widget.title,
          //       // albumTitle: 'My Album',
          //       // artist: 'My Artist',
          //       // imageUrl: 'Image URL or blank',
          //       forwardSkipInterval: const Duration(seconds: 30),
          //       backwardSkipInterval: const Duration(seconds: 30),
          //       duration: _duration,
          //       elapsedTime: const Duration(seconds: 15),
          //       // enableNextTrackButton: true,
          //       // enablePreviousTrackButton: true,
          //     );
          // this.widget.advancedPlayer.play(widget.url, isLocal: false);
          this.widget.advancedPlayer.play();
          //initializeListeners();
          setState(() {
            isPlaying = true;
          });
          //this.widget.advancedPlayer.onDurationChanged.listen((event) {
          //  print("duration is changing : $event");
          //});
        } else {
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      icon: Icon(
        isPlaying ? _icons[1] : _icons[0],
        color: Colors.blue,
        size: 50,
      ),
    );
  }

  Widget fastBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (playbackRate < 2.0) {
            playbackRate = playbackRate + 0.1;
          }
        });

        this.widget.advancedPlayer.setPlaySpeed(
              playbackRate,
            );
      },
      icon: Icon(
        CupertinoIcons.forward_fill,
        size: 30,
        color: Colors.black,
      ),
    );
  }

  Widget repeatBtn() {
    return IconButton(
      onPressed: () {
        // this.widget.advancedPlayer.setPlaybackRate(
        //       playbackRate: 1.5,
        //     );
      },
      icon: Icon(
        Icons.repeat,
        size: 18,
        color: Colors.black,
      ),
    );
  }

  Widget loopBtn() {
    return IconButton(
      onPressed: () {
        if (!isLoop) {
          this.widget.advancedPlayer.setLoopMode(LoopMode.single);

          setState(() {
            isLoop = true;
            loopColor = Colors.blue;
          });
        } else {
          this.widget.advancedPlayer.setLoopMode(LoopMode.none);

          setState(() {
            isLoop = false;
            loopColor = Colors.black;
          });
        }
      },
      icon: Icon(
        Icons.loop,
        size: 18,
        color: loopColor,
      ),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          loopBtn(),
          slowBtn(),
          startBtn(),
          fastBtn(),
          repeatBtn(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: _position.inSeconds.toDouble(),
      max: _duration.inSeconds.toDouble(),
      activeColor: Colors.red,
      inactiveColor: Colors.green,
      onChanged: (value) {
        setState(() {
          changeToSecond(value.toInt());
        });
      },
    );
  }

  void changeToSecond(int sec) {
    Duration newDuration = new Duration(seconds: sec);
    this.widget.advancedPlayer.seek(newDuration);
  }
}
