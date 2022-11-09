import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gc_offline/screens/dashboard.dart';
import 'package:gc_offline/screens/new_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> topCircelAnimation;
  late Animation<double> bottomCircelAnimation;
  late Animation<double> logoAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    topCircelAnimation = Tween<double>(begin: 0, end: 200).animate(controller)
      ..addListener(() {
        setState(() {
          print(topCircelAnimation.value);
        });
      });

    bottomCircelAnimation =
        Tween<double>(begin: 0, end: 350).animate(controller)
          ..addListener(() {
            setState(() {
              print(bottomCircelAnimation.value);
            });
          });

    logoAnimation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          print(logoAnimation.value);
        });
      });
    controller.forward();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (BuildContext context) => new Dashboard(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.blue[900],
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/caayaa.jpg"),
        //     fit: BoxFit.fill,
        //   ),
        //   color: Colors.white,
        // ),
        padding: EdgeInsets.only(
          top: width * 0.38,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 65.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/caayaa.jpg"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Gumaata',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Caayaa',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      //body: Stack(

      //  children: [
      //    Positioned(
      //      top: -100,
      //      right: -100,
      //      child: Container(
      //        height: 300,
      //        width: 350,
      //        decoration: BoxDecoration(
      //          color: Colors.blue,
      //          shape: BoxShape.circle,
      //        ),
      //      ),
      //    ),
      //    Positioned(
      //      bottom: -100,
      //      left: -150,
      //      child: Container(
      //        height: 350,
      //        width: 300,
      //        decoration: BoxDecoration(
      //          color: Colors.yellow,
      //          shape: BoxShape.circle,
      //        ),
      //      ),
      //    ),
      //    Center(
      //      child: Opacity(
      //        opacity: 0.8,
      //        child: Column(
      //          mainAxisAlignment: MainAxisAlignment.center,
      //          children: [
      //            Icon(
      //              CupertinoIcons.person_2_square_stack_fill,
      //              size: 150,
      //            ),
      //            SizedBox(
      //              height: 50,
      //            ),
      //            Text(
      //              'Agenagn',
      //              style: TextStyle(
      //                fontWeight: FontWeight.w700,
      //                fontSize: 40,
      //              ),
      //            ),
      //            Text(
      //              'App',
      //              style: TextStyle(
      //                fontSize: 25,
      //                letterSpacing: 2,
      //              ),
      //            ),
      //          ],
      //        ),
      //      ),
      //    )
      //  ],
      //),
    );
  }
}
