import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // call with dial pad

class ContactUs extends StatelessWidget {
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
        child: SingleChildScrollView(
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
                  '',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Phone NO: 0921xxxxxx',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text('Email: example@gmail.com'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  'Nu Hordofaa',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      launch(
                        "https://www.youtube.com/channel/UCIkg8S736qGlkFWeX5pSaBw",
                      );
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/facebook.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch(
                        "https://www.youtube.com/channel/UCIkg8S736qGlkFWeX5pSaBw",
                      );
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/youtube1.png",
                        width: 100,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   padding: EdgeInsets.all(
              //     10,
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(
              //       15,
              //     ),
              //     border: Border.all(
              //       color: Colors.blue,
              //       width: 2,
              //     ),
              //   ),
              //   child: Text(
              //     'Facebook',
              //     style: TextStyle(
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.all(
              //     10,
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(
              //       15,
              //     ),
              //     border: Border.all(
              //       color: Colors.blue,
              //       width: 2,
              //     ),
              //   ),
              //   child: Text(
              //     'Youtube',
              //     style: TextStyle(
              //       fontSize: 18,
              //     ),
              //   ),
              // ),

              // InkWell(
              //   onTap: () => launch('https://www.dabbalsoftwares.com/Agenagn/'),
              //   child: Container(
              //     child: Text(
              //       'For more information',
              //       style: TextStyle(
              //         color: Colors.blue,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              // InkWell(
              //   onTap: () =>
              //       launch('https://www.dabbalsoftwares.com/privacypolicy'),
              //   child: Container(
              //       child: Text(
              //     'privacy policy',
              //     style: TextStyle(
              //       color: Colors.blue,
              //     ),
              //   )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
