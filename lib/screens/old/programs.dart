import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_offline/screens/about.dart';
import 'package:gc_offline/screens/audio_widget/play_audio.dart';
import 'package:gc_offline/screens/audio_widget/play_audio_offline.dart';
import 'package:gc_offline/screens/contactus.dart';
import 'package:gc_offline/widgets/common_app_bar.dart';
import 'package:gc_offline/widgets/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:connectivity/connectivity.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  _ProgramsPageState createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var selectedFieldName = 'Qophiilee';
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
      color: Colors.grey[100],
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
          body: ModalProgressHUD(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopBar(
                  title: selectedFieldName,
                  clickHandler: () {
                    // print("inside program");
                    drawerController();
                  },
                ),
                Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (BuildContext context, bool isScroll) {
                      return [
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.blue[900],
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(20),
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: TabBar(
                                indicatorPadding: EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelPadding: EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                ),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                                tabs: [
                                  tabButton("Copha Surrii", Colors.green[400]),
                                  tabButton(
                                      "Wal'aansa Ruuhii", Colors.green[400]),
                                  tabButton(
                                      "Maatiifi Waatii", Colors.green[400]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        tab1Content(),
                        tab2Content(),
                        tab3Content(),
                        // Material(
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: Colors.green,
                        //     ),
                        //     title: Text('Content'),
                        //   ),
                        // ),
                        // Material(
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: Colors.grey,
                        //     ),
                        //     title: Text('Content'),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            inAsyncCall: loading,
            color: Colors.white,
            opacity: 0.6,
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
    print("data " + data.toString());
    if (data['status'].toString().compareTo("offline") == 0) {
      print("offline");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PlayAudioOffline(data: data),
        ),
      );
    } else {
      print("online");
      print(isConnected);
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
