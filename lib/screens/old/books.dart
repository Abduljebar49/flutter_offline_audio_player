import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_offline/screens/about.dart';
import 'package:gc_offline/screens/contactus.dart';
import 'package:gc_offline/widgets/common_app_bar.dart';
import 'package:gc_offline/widgets/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool drawerOpen = false;
  List tab1ContentList = [];
  bool loading = true;
  resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/book-list.json')
        .then((s) {
      print(s);
      print(" : lskfjsdl");
      setState(() {
        tab1ContentList = json.decode(s);
        loading = false;
      });
    });
  }

  drawerController() {
    print("inside books");
    print(drawerOpen);
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
    return Container(
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
            inAsyncCall: loading,
            child: Container(
              child: Column(
                children: [
                  TopBar(
                    title: "Kitaabiilee",
                    clickHandler: () {
                      drawerController();
                    },
                  ),
                  Expanded(
                    child: tab1Content(width: width),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 200),
                  //   child: Center(
                  //     child: Text(
                  //       "yeroodhaaf kitaabni hin jiru.",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 30,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tab1Content({width}) {
    return Container(
      color: Colors.blue[900],
      child: ListView.builder(
          itemCount: tab1ContentList.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                // tabClickHandler(  Widget tab1Content()
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
                    padding: EdgeInsets.all(1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 130,
                            margin: EdgeInsets.only(
                              left: 5,
                              top: 3,
                              bottom: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              image: DecorationImage(
                                image: AssetImage(tab1ContentList[i]['img']),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 5,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.s,
                                  children: [
                                    SizedBox(
                                      width: width * 0.6,
                                      height: 40,
                                      child: Container(
                                          child: AutoSizeText(
                                        tab1ContentList[i]['title'],
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
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
                                  height: 33,
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
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.green,
                                      ),
                                      child: Text(
                                        'Download',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.blue,
                                      ),
                                      child: Text(
                                        'Read online',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
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
}
