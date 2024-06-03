import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:get/get.dart';
import 'package:kmc/modal/receiptmodule.dart';
import 'package:kmc/pages/profile/pdfview.dart';

class Receipt extends StatefulWidget {
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiptApi().then((value) => print(value));
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  Future<List<Receiptmodal>> receiptdataapi() async {
    List<Receiptmodal>? receiptdata = await receiptApi();

    return receiptdata!;
  }

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
                Text('receipt'.tr,
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
                      future: receiptdataapi(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerWidget().buildMovieShimmer();
                        } else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.data == null) {
                          return Container(
                            child: Center(
                                heightFactor: 5,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.no_sim_outlined,
                                      color: primary,
                                      size: 80,
                                    ),
                                    Text("no_data_found".tr,
                                        style: TextStyle(
                                            height: 1.3,
                                            color: textPrimaryColor,
                                            fontSize: 16))
                                  ],
                                )),
                          );
                        } else {
                          return Container(
                            height: Get.height,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, index) => InkWell(
                                onTap: () {
                                  approvedactionsheet(
                                      snapshot.data[index].receipt);
                                },
                                child: ListTile(
                                  tileColor: white,
                                  leading: Icon(Icons.file_copy,
                                      color: primary, size: 30),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Text(
                                          '${snapshot.data[index].sp_pay_code}',
                                          style: TextStyle(color: text)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                      title: Text("Download "),
                    ),
                  ),
                  new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(Pdfviewer(data: a));
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.view_agenda, color: tertiary),
                      title: Text("View"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.cancel_outlined, color: tertiary),
                      title: Text("Cancel"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    return null;
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
}
