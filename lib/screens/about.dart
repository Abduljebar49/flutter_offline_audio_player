import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // call with dial pad

class AboutPage extends StatelessWidget {
  //void getPackageInfo() async{
  //  PackageInfo packageInfo = await getPackageInfo()
  //}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 35,
              ),
              width: 300,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                // child: Image.network(
                child: Image.asset('assets/images/gumaata.jpg'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Gumaata Caayaa',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   child: Text(''),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              child: Text(
                'Version : 1.0',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'DEVELOPED BY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text('Abduljebar Sani'),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => launch('https://www.dabbalsoftwares.com/Agenagn/'),
              child: Container(
                child: Text(
                  'For more information',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () =>
                  launch('https://www.dabbalsoftwares.com/privacypolicy'),
              child: Container(
                  child: Text(
                'privacy policy',
                style: TextStyle(
                  color: Colors.blue,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
