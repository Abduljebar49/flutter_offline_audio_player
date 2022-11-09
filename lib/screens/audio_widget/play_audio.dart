import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_offline/screens/audio_widget/audio_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PlayAudio extends StatefulWidget {
  final data;
  const PlayAudio({Key? key, this.data}) : super(key: key);

  @override
  _PlayAudioState createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  AssetsAudioPlayer advancedPlayer = AssetsAudioPlayer();
  // late AudioPlayer audioPlayer;
  AudioCache audioCache = AudioCache();
  List programsList = [];
  final storage = FirebaseStorage.instance;
  bool downloadUrlLoaded = true;
  String downloadUrl = "";
  @override
  void initState() {
    super.initState();
    // audioPlayer = AudioPlayer();
    getDownloadableAddress();
  }

  getDownloadableAddress() async {
    storage.ref(widget.data['audio']).getDownloadURL().then((url) {
      // print("url is " + url.toString());
      setState(() {
        downloadUrlLoaded = false;
        downloadUrl = url;
      });
      // Do something with the URL ...
    });
    loadContents();
    // if (kIsWeb) {
    //   return;
    // }
    // if (Platform.isIOS) {
    //   audioCache.fixedPlayer?.notificationService.startHeadlessService();
    // }
  }

  loadContents() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/audio-list.json')
        .then((s) {
      setState(() {
        programsList = json.decode(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: ModalProgressHUD(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: screenHeight * 0.055,
                    bottom: 0,
                    //height: screenHeight * 0.88,
                    child: Container(
                      //margin: EdgeInsets.only(
                      //  bottom: 30,
                      //),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: BorderRadius.only(
                        //  topLeft: Radius.circular(40),
                        //  topRight: Radius.circular(40),
                        //),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: ,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 25,
                            ),
                            child: AutoSizeText(
                              widget.data['title'],
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 4,
                          // ),
                          // Text(
                          //   widget.data['artist'],
                          //   style: TextStyle(
                          //     color: Colors.grey[400],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 4,
                          // ),

                          Text(
                            widget.data['text'],
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          //padding: EdgeInsets.only(top: screenHeight * 0.33),
                          // SizedBox(
                          //   height: 7,
                          // ),
                          SizedBox(
                            height: 250,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              padding: EdgeInsets.only(
                                left: 30,
                                right: 30,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    this.widget.data['img'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            widget.data['artist'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 30,
                              ),
                              child: !downloadUrlLoaded
                                  ? AudioFile(
                                      title: widget.data['title'],
                                      // advancedPlayer: audioPlayer,
                                      advancedPlayer: advancedPlayer,
                                      url: downloadUrl,
                                      data: widget.data,
                                    )
                                  // Container(
                                  //     child: Text('donwload urlloaded'),
                                  //   )
                                  : Container()
                              //                             : AudioFileOffline(
                              // //                                advancedPlayer: audioPlayer,
                              //                                 url: widget.data['audio'],
                              //                               )
                              ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        // border: Border.all(
                        //   color: Colors.blue,
                        //   width: 3,
                        // ),
                        // color: Colors.blue
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                        onPressed: () {
                          advancedPlayer.dispose();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),

                  //Positioned(
                  //  top: screenHeight * 0.12,
                  //  left: (screenWidth - 150) / 2,
                  //  right: (screenWidth - 150) / 2,
                  //  height: screenHeight * 0.16,
                  //  child: Container(
                  //    decoration: BoxDecoration(
                  //      color: Colors.orange[200],
                  //      borderRadius: BorderRadius.circular(
                  //        20,
                  //      ),
                  //      border: Border.all(
                  //        color: Colors.white,
                  //        width: 2,
                  //      ),
                  //    ),
                  //    child: Padding(
                  //      padding: EdgeInsets.all(
                  //        20,
                  //      ),
                  //      child: Container(
                  //        decoration: BoxDecoration(
                  //          //borderRadius: BorderRadius.circular(
                  //          //  20,
                  //          //),
                  //          shape: BoxShape.circle,
                  //          border: Border.all(
                  //            color: Colors.white,
                  //            width: 5,
                  //          ),
                  //          image: DecorationImage(
                  //            image: AssetImage(
                  //              this.widget.data['img'],
                  //            ),
                  //            fit: BoxFit.fill,
                  //          ),
                  //        ),
                  //      ),
                  //    ),
                  //  ),
                  //),
                  //Container(
                  //  child: Row(
                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //    children: [
                  //      Icon(
                  //        Icons.8,
                  //        size: 30,
                  //        color: Colors.black,
                  //      ),
                  //      Icon(
                  //        Icons.search,
                  //        size: 30,
                  //        color: Colors.black,
                  //      ),
                  //    ],
                  //  ),
                  //),
                ],
              ),
            ),
            inAsyncCall: downloadUrlLoaded,
          ),
        ),
      ),
    );

    //return Scaffold(
    //  appBar: AppBar(title: Text('Gumaata Caayaa')),
    //  body: SafeArea(
    //    child: Container(
    //      padding: EdgeInsets.all(10),
    //      decoration: BoxDecoration(
    //        color: Colors.white,
    //      ),
    //      child: Column(
    //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //        children: [
    //          Image(
    //            image: AssetImage(
    //              'assets/images/headset.jpg',
    //            ),
    //          ),
    //          slider(),
    //          InkWell(
    //            onTap: () {
    //              getAudio();
    //            },
    //            child: Icon(
    //              playing == false
    //                  ? Icons.play_circle_outline
    //                  : Icons.pause_circle_outline,
    //              size: 100,
    //              color: Colors.blue,
    //            ),
    //          ),
    //        ],
    //      ),
    //    ),
    //  ),
    //);
  }

  //getAudio() async {
  //  var url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  //  if (playing) {
  //    var res = await audioPlayer.pause();

  //    if (res == 1) {
  //      setState(() {
  //        playing = true;
  //      });
  //    }
  //  } else {
  //    var res = await audioPlayer.play(url, isLocal: true);
  //    if (res == 1) {
  //      setState(() {
  //        playing = true;
  //      });
  //    }
  //  }
  //  audioPlayer.onDurationChanged.listen((Duration durationTrack) {
  //    setState(() {
  //      duration = durationTrack;
  //    });
  //  });
  //  audioPlayer.onAudioPositionChanged.listen((Duration durationTrack) {
  //    setState(() {
  //      position = durationTrack;
  //    });
  //  });
  //}

  //Widget slider() {
  //  return Slider.adaptive(
  //    min: 0.0,
  //    value: position.inSeconds.toDouble(),
  //    max: duration.inSeconds.toDouble(),
  //    onChanged: (value) {
  //      setState(() {
  //        audioPlayer.seek(new Duration(seconds: value.toInt()));
  //      });
  //    },
  //  );
  //}
}
