import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_offline/screens/audio_widget/audio_file_offline.dart';

class PlayAudioOffline extends StatefulWidget {
  final data;
  const PlayAudioOffline({Key? key, this.data}) : super(key: key);

  @override
  _PlayAudioOfflineState createState() => _PlayAudioOfflineState();
}

class _PlayAudioOfflineState extends State<PlayAudioOffline> {
  AssetsAudioPlayer advancedPlayer = AssetsAudioPlayer();
  List programsList = [];

  @override
  void initState() {
    super.initState();
    loadContents();
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

  bool isPlayOffline() {
    if (widget.data['status'] == "offline") return true;

    print(widget.data['status']);
    print("tttttttttttttttttttt");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            // color: Colors.grey[300],
            //margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          child: AudioFileOffline(
                            advancedPlayer: advancedPlayer,
                            url: widget.data['audio'],
                            data: widget.data,
                          ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
