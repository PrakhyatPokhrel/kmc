import 'dart:isolate';
import 'dart:ui';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/profile/pdfview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class Rajpatra extends StatefulWidget {
  @override
  _RajpatraState createState() => _RajpatraState();
}

class _RajpatraState extends State<Rajpatra> {
  @override
  void initState() {
    // TODO: implement initState
    FlutterDownloader.registerCallback(downloadingCallback);
    rajpatraApi().then((value) {
      // print("rajpatra: " + "$value");
    });
  }

  String pdfNme = " ";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('rajpatra'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                      future: rajpatraApi(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerWidget().buildMovieShimmer();
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          return SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Get.height,
                                  child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: primary,
                                          child: ExpansionTile(
                                            title: Text(
                                              "स्थानीय राजपत्र-" +
                                                  snapshot.data[index].year,
                                              style: TextStyle(
                                                color: textPrimaryLightColor,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                height: 300,
                                                // Get.height *
                                                //     0.09 *
                                                //     snapshot
                                                //         .data[index].datas.length,
                                                child: Scrollbar(
                                                  thumbVisibility: true,
                                                  child: ListView.builder(
                                                      itemCount: snapshot
                                                          .data[index].datas.length,
                                                      itemBuilder: (context, i) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pdfNme = snapshot
                                                                .data[index]
                                                                .datas[i]
                                                                .pdf_name;
                                                            approvedactionsheet(
                                                                snapshot
                                                                    .data[index]
                                                                    .datas[i]
                                                                    .pdf_name);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8.0),
                                                                child:
                                                                    Row(children: [
                                                                  Icon(
                                                                    Icons
                                                                        .picture_as_pdf,
                                                                    color:
                                                                        textPrimaryDarkColor,
                                                                    size: 50,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20.0,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .datas[i]
                                                                          .title,
                                                                    ),
                                                                  )
                                                                ]),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? approvedactionsheet(a) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return new Container(
            color: Colors.transparent,
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      var link = a;

                      // download(link);
                      getPermission(link);

                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.download, color: tertiary),
                      title: Text("download".tr),
                    ),
                  ),
                  new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(Pdfviewer(data: a));
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.view_agenda, color: tertiary),
                      title: Text("view".tr),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      share(context, pdfNme);
                    },
                    child: ListTile(
                      leading: new Icon(Icons.share, color: tertiary),
                      title: Text("Share".tr),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.cancel_outlined, color: tertiary),
                      title: Text("cancel".tr),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void getPermission(link) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    dowloadButton(link);
  }

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  void share(BuildContext context, String text) {
    Share.share(text);
  }
}
