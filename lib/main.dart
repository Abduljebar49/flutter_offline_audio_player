import 'package:flutter/material.dart';
import 'package:gc_offline/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = {
      'title': 'this is title',
      "text": 'this is text',
      'img': 'assets/images/copy2.jpg',
      'audio':
          'https://thenaatsharif.com/downloads/javeria-saleem/maula-ya-salli-wa-sallim.mp3'
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //home: PlayAudio(
      // home: YoutubeVideoLists(title: "Caayaa", videoId: "7hV5WZ6GyY4"),
      //  data: Data,
      //),
    );
  }
}
