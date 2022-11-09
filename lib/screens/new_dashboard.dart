import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gc_offline/screens/about.dart';
import 'package:gc_offline/screens/contactus.dart';
import 'package:gc_offline/screens/tabs/books.dart';
import 'package:gc_offline/screens/tabs/nesheeds.dart';
import 'package:gc_offline/screens/tabs/programs.dart';
import 'package:gc_offline/widgets/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  child: Text("NO"),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  // detachedCallBack();
                  exit(0);
                },
                child: Container(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    child: Text("YES")),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.blue[800],
            drawer: Container(
              color: Colors.blue[800],
              child: Drawer(
                child: ListView(
                  children: [
                    Container(
                      height: 165.0,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                        ),
                        child: Image.asset(
                          "assets/images/gumaata.jpg",
                          height: 160.0,
                          width: 165.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                      ),
                      child: Text(
                        'Gumaata Caayaa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    DividerWidget(),
                    SizedBox(
                      height: 12.0,
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.person),
                    //   title: Text(
                    //     "Visit Profile",
                    //     style: TextStyle(fontSize: 15.0),
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.history),
                    //   title: Text(
                    //     "History",
                    //     style: TextStyle(fontSize: 15.0),
                    //   ),
                    // ),
                    ListTile(
                      leading: Icon(Icons.info),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AboutPage(),
                          ),
                        );
                      },
                      title: Text(
                        "About Us",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ContactUs(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              title: Text(
                'Gumaata Caayaa',
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Programs()),
                          );
                        },
                        child: Container(
                          height: 180,
                          width: width * 0.95,
                          margin: EdgeInsets.only(
                            top: 7,
                            bottom: 7,
                            // left: wid,
                            // right: 3,
                          ),
                          padding: EdgeInsets.all(
                            15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/new_neshida.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 123,
                            ),
                            child: Text(
                              'Qophiilee',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Nasheeds()),
                      );
                    },
                    child: Container(
                      height: 180,
                      width: width * 0.95,
                      margin: EdgeInsets.only(
                        // top: 7,
                        bottom: 7,
                      ),
                      padding: EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/new_neshida.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 125,
                        ),
                        child: Text(
                          'Nashiidaalee',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Books(),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      width: width * 0.95,
                      margin: EdgeInsets.only(
                        // top: 7,
                        bottom: 7,
                      ),
                      padding: EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/new_neshida.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 123,
                        ),
                        child: Text(
                          'Kitaabiilee',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
