import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_offline/screens/audio_widget/play_audio.dart';
import 'package:gc_offline/screens/audio_widget/play_audio_offline.dart';

class Programs extends StatefulWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  _ProgramsState createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var selectedFieldName = 'Copha Surrii';
  List tab1ContentList = [];
  List tab2ContentList = [];
  List tab3ContentList = [];
  late TabController _tabController;
  late ScrollController _scrollController;
  bool drawerOpen = false;
  bool loading = true;
  bool isConnected = false;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
    readDataTwo();
    readDataThree();
    // getDataFromDatabase();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
      loading = false;
      isConnected = true;
    });
  }

  _NoConnection() {
    print("there is no connection!");
    setState(() {
      isConnected = false;
    });
  }

  void readData() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/copha-surri.json')
        .then((s) {
      print(s);
      print("");
      setState(() {
        tab1ContentList = json.decode(s);
        loading = false;
      });
    });
  }

  void readDataTwo() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/neshida-audio.json')
        .then((s) {
      print(s);
      print("");
      setState(() {
        tab2ContentList = json.decode(s);
        loading = false;
      });
    });
  }

  void readDataThree() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/neshida-audio2.json')
        .then((s) {
      print(s);
      print("");
      setState(() {
        tab3ContentList = json.decode(s);
        loading = false;
      });
    });
  }

  drawerController() {
    if (drawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    } else {
      resetApp();
    }
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: Text(
                selectedFieldName,
              ),
              bottom: TabBar(
                onTap: (index) {
                  print("index selected" + index.toString());
                  setState(() {
                    if (index == 0) {
                      selectedFieldName = "Wal'aansa Ruuhii";
                    } else if (index == 1) {
                      selectedFieldName = "Copha Surrii";
                    } else {
                      selectedFieldName = "Maatiifi Waatii";
                    }
                  });
                },
                tabs: <Widget>[
                  Tab(
                    // icon: ,
                    child: Icon(Icons.cloud_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.beach_access_sharp),
                  ),
                  Tab(
                    icon: Icon(Icons.brightness_5_sharp),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                tab2Content(),
                tab1Content(),
                tab3Content(),

                // Center(
                //   child: Text("It's cloudy here"),
                // ),
                // Center(
                //   child: Text("It's rainy here"),
                // ),
                // Center(
                //   child: Text("It's sunny here"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabButton(text, color) {
    return Container(
      //width: 120,
      height: 50,
      padding: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            offset: Offset(0, 0),
          )
        ],
      ),
    );
  }

  tabClickHandler(data) {
    // print("data " + data.toString());
    if (data['status'].toString().compareTo("offline") == 0) {
      // print("offline");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PlayAudioOffline(data: data),
        ),
      );
    } else {
      // print("online");
      // print(isConnected);
      if (!isConnected) {
        showSnackBar(context, "Interneeta banuu qabda, kana tapachiisuuf!");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PlayAudio(data: data),
          ),
        );
      }
    }
  }

  Widget tab1Content() {
    return Container(
      color: Colors.blue[900],
      child: ListView.builder(
          itemCount: tab1ContentList.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                tabClickHandler(tab1ContentList[i]);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                  top: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(tab1ContentList[i]['img']),
                              ),
                            ),
                          ),
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
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        child: Text(
                                      tab1ContentList[i]['title'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    tab1ContentList[i]['text'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
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
                                //       Text(tab1ContentList[i]['rating']),
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
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget tab2Content() {
    return Container(
      color: Colors.blue[800],
      child: ListView.builder(
          itemCount: tab2ContentList.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                tabClickHandler(tab2ContentList[i]);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                  top: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(tab2ContentList[i]['img']),
                              ),
                            ),
                          ),
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
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        child: Text(
                                      tab2ContentList[i]['title'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    tab2ContentList[i]['text'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
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

  Widget tab3Content() {
    return Container(
      color: Colors.blue[800],
      child: ListView.builder(
        itemCount: tab3ContentList.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              tabClickHandler(tab3ContentList[i]);
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
                top: 5,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(tab3ContentList[i]['img']),
                            ),
                          ),
                        ),
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
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                      child: Text(
                                    tab3ContentList[i]['title'],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  tab3ContentList[i]['text'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
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
