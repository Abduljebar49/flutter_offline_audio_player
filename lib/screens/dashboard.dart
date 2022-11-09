import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gc_offline/screens/old/books.dart';
import 'package:gc_offline/screens/old/neshida.dart';
import 'package:gc_offline/screens/old/programs.dart';

class NewDashboard extends StatefulWidget {
  const NewDashboard({Key? key}) : super(key: key);

  @override
  _NewDashboardState createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ProgramsPage(),
    NeshidaScreen(),
    BooksPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.home),
                //       label: 'Home',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.business),
                //       label: 'Business',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.school),
                //       label: 'School',
                //     ),
                //     // BottomNavigationBarItem(
                //     //   icon: Icon(Icons.settings),
                //     //   label: 'Settings',
                //     //   backgroundColor: Colors.pink,
                //     // ),
                //   ],
                //   currentIndex: _selectedIndex,
                //   selectedItemColor: Colors.white,
                //   backgroundColor: Colors.blue[900],
                //   onTap: _onItemTapped,
                // ),

                // bottomNavigationBar: BottomNavigationBar(
                //   items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Qophiilee",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.multitrack_audio),
                  label: "Nashiidaalee",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: "Kitaabban",
                ),
              ],
              currentIndex: _selectedIndex,
              backgroundColor: Colors.blue[900],
              selectedItemColor: Colors.orange[100],
              unselectedItemColor: Colors.white,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  // Future<bool>? _onBackPressed() async {
  //   return await showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           title: new Text('Are you sure?'),
  //           content: new Text('Do you want to exit an App'),
  //           actions: <Widget>[
  //             new GestureDetector(
  //               onTap: () => Navigator.of(context).pop(false),
  //               child: Container(
  //                 padding: EdgeInsets.all(
  //                   10,
  //                 ),
  //                 child: Text("NO"),
  //               ),
  //             ),
  //             SizedBox(height: 16),
  //             new GestureDetector(
  //               onTap: () {
  //                 exit(0);
  //                 // detachedCallBack();
  //               },
  //               child: Container(
  //                   padding: EdgeInsets.all(
  //                     10,
  //                   ),
  //                   child: Text("YES")),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }
}
