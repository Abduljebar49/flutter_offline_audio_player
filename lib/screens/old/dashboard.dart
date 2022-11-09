import 'package:flutter/material.dart';
import 'package:gc_offline/screens/old/tab1.dart';
import 'package:gc_offline/screens/old/tab2.dart';
import 'package:gc_offline/screens/old/tab3.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var titleText = "Qophiilee";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              print("This is index : " + index.toString());
              if (index == 0) {
                titleText = "Qophiilee";
              } else if (index == 1) {
                titleText = "Neshidaalee";
              } else {
                titleText = "Kitaabiilee";
              }
              setState(() {
                titleText = titleText;
              });
            },
            tabs: [
              Tab(icon: Icon(Icons.all_inbox)),
              Tab(icon: Icon(Icons.music_note)),
              Tab(icon: Icon(Icons.book)),
            ],
          ),
          title: Text(titleText.toString()),
        ),
        body: TabBarView(
          children: [
            Tab1(),
            Tab2(),
            Tab3(),
          ],
        ),
      ),
    );
  }
}
