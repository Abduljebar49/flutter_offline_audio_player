import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioFileOffline extends StatefulWidget {
  // final AudioPlayer widget.advancedPlayer;
  final String url;
  final data;
  final AssetsAudioPlayer advancedPlayer;
  const AudioFileOffline({
    Key? key,
    required this.url,
    required this.advancedPlayer,
    required this.data,
  }) : super(key: key);

  @override
  _AudioFileOfflineState createState() => _AudioFileOfflineState();
}

class _AudioFileOfflineState extends State<AudioFileOffline> {
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
    widget.advancedPlayer.open(
      Audio(
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
        prevEnabled: false,
        nextEnabled: false,
      ),
    );
    // widget.advancedPlayer.setUrl(widget.url);
    initializeListeners();
    print("inside aduio file offline");
  }

  initializeListeners() {
    // widget.advancedPlayer.onDurationChanged.listen((Duration d) {
    //   print("inside duration changed $d");
    //   setState(() {
    //     _duration = d;
    //   });
    // });
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
    // widget.advancedPlayer.onAudioPositionChanged.listen((Duration p) {
    //   print("inside position changed $p");
    //   setState(() {
    //     _position = p;
    //   });
    // });
    // widget.advancedPlayer.onPlayerCompletion.listen((event) {
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
        widget.advancedPlayer.setPlaySpeed(playbackRate);
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
      onPressed: () {
        print("inside playing audio");
        if (!isPlaying) {
          widget.advancedPlayer.play();
          //initializeListeners();
          setState(() {
            isPlaying = true;
          });
          //widget.advancedPlayer.onDurationChanged.listen((event) {
          //  print("duration is changing : $event");
          //});
        } else {
          widget.advancedPlayer.pause();
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

        widget.advancedPlayer.setPlaySpeed(
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
        if (!isLoop) {
          widget.advancedPlayer.setLoopMode(LoopMode.single);

          setState(() {
            isLoop = true;
            loopColor = Colors.blue;
          });
        } else {
          widget.advancedPlayer.setLoopMode(LoopMode.none);

          setState(() {
            isLoop = false;
            loopColor = Colors.black;
          });
        }
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
          widget.advancedPlayer.setLoopMode(LoopMode.playlist);

          setState(() {
            isLoop = true;
            loopColor = Colors.blue;
          });
        } else {
          widget.advancedPlayer.setLoopMode(LoopMode.none);

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
    widget.advancedPlayer.seek(newDuration);
  }
}
