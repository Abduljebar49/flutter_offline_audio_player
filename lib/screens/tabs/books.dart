import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_offline/screens/api/pdf_api.dart';
import 'package:gc_offline/screens/pdf-screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool drawerOpen = false;
  List tab1ContentList = [];
  bool loading = true;
  Uint8List? _documentBytes;
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
      print("");
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

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text(
              'Kitaabiilee',
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: loading,
            child: Container(
              color: Colors.blue[900],
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: tab1Content(
                      width: width,
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

  Future<File> createFileOfPdfUrl(remoteUrl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = remoteUrl.toString();
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      print(e.toString());
    }

    return completer.future;
  }

  printUrl(bookUrl) async {
    setState(() {
      loading = true;
    });
    String abc = bookUrl.toString();
    abc = abc.substring(31);
    final file = await PDFApi.loadFirebase(abc);

    if (file == null) {
      print("file is null");
      setState(() {
        loading = false;
      });
    }

    if (file == null) return;
    openPDF(context, file);

    setState(() {
      loading = false;
    });
  }

  downloadBookUrl(bookUrl, bookName) async {
    setState(() {
      loading = true;
    });
    String abc = bookUrl.toString();
    abc = abc.substring(31);

    Reference ref = FirebaseStorage.instance.ref(abc);

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$bookName');

    await ref.writeToFile(file);
    setState(() {
      loading = false;
    });
    showSnackBar(context, "downloaded $bookName.pdf");
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );

//   Future<String> uploadImage(var imageFile ) async {
//     StorageReference ref = storage.ref().child("/photo.jpg");
//     StorageUploadTask uploadTask = ref.putFile(imageFile);

//     var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
//     url = dowurl.toString();

//     return url;
// }

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
                  top: 10,
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
                                    GestureDetector(
                                      onTap: () {
                                        downloadBookUrl(
                                          tab1ContentList[i]['url'],
                                          tab1ContentList[i]['title'],
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          'Download',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        // var remotePDFpath;
                                        // await createFileOfPdfUrl(
                                        //   tab1ContentList[i]['url'],
                                        // ).then((f) {
                                        //   setState(() {
                                        //     remotePDFpath = f.path;
                                        //   });
                                        // print(
                                        //     "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
                                        //   print(remotePDFpath);
                                        // });

                                        printUrl(tab1ContentList[i]['url']);
                                        // print("url");
                                        // print(url);
                                        // if (remotePDFpath.isNotEmpty) {
                                        // }
                                        // PDFView(
                                        //   filePath: tab1ContentList[i]['url'],
                                        // );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Colors.blue,
                                        ),
                                        child: Text(
                                          'Read online',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
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
}
