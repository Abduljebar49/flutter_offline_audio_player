import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_offline/screens/about.dart';
import 'package:gc_offline/screens/contactus.dart';
import 'package:gc_offline/screens/video_widgets/play_video.dart';
import 'package:gc_offline/widgets/common_app_bar.dart';
import 'package:gc_offline/widgets/widget.dart';

class NeshidaScreen extends StatefulWidget {
  const NeshidaScreen({Key? key}) : super(key: key);

  @override
  _NeshidaScreenState createState() => _NeshidaScreenState();
}

class _NeshidaScreenState extends State<NeshidaScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var selectedFieldName = 'Neshiidaalee';
  List neshidaList = [];
  bool drawerOpen = false;
  bool isConnected = false;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    readData();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("connection state Changed NoConnection " + result.toString());
    switch (result) {
      case ConnectivityResult.wifi:
        _thereIsConnection();
        break;
      case ConnectivityResult.mobile:
        _thereIsConnection();
        break;
      case ConnectivityResult.none:
        _NoConnection();
        break;
      default:
        break;
    }
  }

  _thereIsConnection() {
    print("there is connection");
    setState(() {
      isConnected = true;
    });
  }

  _NoConnection() {
    print("there is no connection!");
    setState(() {
      isConnected = false;
    });
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }

  void readData() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/youtube-neshida.json')
        .then((s) {
      print("Neshida --- ");
      print(s);
      setState(() {
        neshidaList = json.decode(s);
      });
    });
  }

  drawerController() {
    print("click handler worked");
    // if(scaffoldKey.)
    if (drawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    } else {
      resetApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: Container(
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
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(
                title: selectedFieldName,
                clickHandler: () {
                  drawerController();
                },
              ),
              // SizedBox(
              //   height: 2,
              // ),
              Expanded(
                child: neshidaLists(width: width),
              ),
              // Container(
              //   height: 180,
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         left: -20,
              //         top: 0,
              //         right: 0,
              //         child: Container(
              //           height: 180,
              //           child: PageView.builder(
              //             controller: PageController(viewportFraction: 0.8),
              //             itemCount: neshidaList.length,
              //             itemBuilder: (_, i) {
              //               return Container(
              //                 height: 180,
              //                 margin: EdgeInsets.only(right: 13),
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(30),
              //                   image: DecorationImage(
              //                     image: AssetImage(neshidaList[i]['img']),
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget neshidaLists({width}) {
    return Container(
      color: Colors.blue[900],
      child: ListView.builder(
          itemCount: neshidaList.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                print(neshidaList[i].toString());
                print("some place clicked");

                if (!isConnected) {
                  showSnackBar(
                    context,
                    "Tapachiisuuf, Interneeta bani!",
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PlayYoutubeVideo(
                            title: neshidaList[i]['title'],
                            videoId: neshidaList[i]['videoId'])),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 13,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: SizedBox(
                                        width: width * 0.35,
                                        height: 80,
                                        child: AutoSizeText(
                                          neshidaList[i]['title'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            "Channel : " +
                                                neshidaList[i]['channel'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Container(
                                //   child: Row(
                                //     children: [
                                //       Icon(
                                //         Icons.star,
                                //         size: 25,
                                //         color: Colors.orange[400],
                                //       ),
                                //       SizedBox(
                                //         width: 5,
                                //       ),
                                //       Text(neshidaList[i]['rating']),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 3,
                                // ),
                                // Container(
                                //   padding: EdgeInsets.all(7),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(9),
                                //     color: Colors.blue,
                                //   ),
                                //   child: Text(
                                //     'Audio',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[400],
                              image: DecorationImage(
                                image: AssetImage(neshidaList[i]['imageUrl']),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ));
}
