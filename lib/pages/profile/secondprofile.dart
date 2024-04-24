import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmc/components/custom_empty_card.dart';
import 'package:kmc/components/custom_error_card.dart';
import 'package:kmc/components/custom_spinner.dart';
// import 'package:share_plus/share_plus.dart';

import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/components/downloading_dialog.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/profile/Reuploaddocuments/usertaxregisterdocupdate.dart';
import 'package:kmc/pages/profile/paymentdetails.dart';
import 'package:kmc/pages/profile/pdfview.dart';
import 'package:kmc/pages/profile/receipt.dart';
import 'package:kmc/pages/sewa/sifarish/reupload_sifarish_document/reupload_sifarish_doc.dart';
import 'package:kmc/pages/tax/propertyEdit/propertyEditHomepage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondProfile extends StatefulWidget {
  @override
  // final data;
  // SecondProfile({this.data});
  _SecondProfileState createState() => _SecondProfileState();
  // data: this.data
}

class _SecondProfileState extends State<SecondProfile> {
  // var data;
  // _SecondProfileState({this.data});
  TabController? _tabController;
  int _currentIndex = 0;

  // Future<List<Yojanalist>> geteventsdataapi() async {
  //   List<Yojanalist> yojana = await yojanaAPis('$subIndex');
  //   return yojana;
  // }
  var sifarishstatus;
  var resubmitdoc;
  @override
  void initState() {
    super.initState();
    getsoredata();
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  dynamic userdata;
  getsoredata() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    dynamic s = jsonDecode(pref.getString('user')!);
    setState(() {
      userdata = s;
    });
  }
  // Future<List<Usernotificationmodal>> personalnotif() async {
  //   List<Usernotificationmodal> notif = await personalnotificationhistoryAPi();
  //   return notif;
  // }

  unApproved() async {
    sifarishstatus = await sifarishstatusApi('unapproved');
    return sifarishstatus;
  }

  approved() {
    sifarishstatus = sifarishstatusApi('approved');

    return sifarishstatus;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: background,
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
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
                      Text('my_application'.tr,
                          style: TextStyle(color: primary, fontSize: 22)),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              Icon(Icons.arrow_back, color: primary, size: 28)),
                    ],
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: primary,
                  labelColor: primary,
                  unselectedLabelColor: textPrimaryColor,
                  tabs: [
                    Tab(text: 'in_process'.tr),
                    Tab(text: 'completed'.tr),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  //!LEFT TABBAR
                  Container(
                      child: FutureBuilder(
                          future: unApproved(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CustomSpinner();
                            } else if (snapshot.hasError) {
                              return CustomErrorCard();
                            } else if (snapshot.data != null) {
                              return snapshot.data.length == 0
                                  ? CustomEmptyCard()
                                  : Container(
                                      child: ListView.builder(
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (ctx, index) => InkWell(
                                          onTap: () {
                                            if ('${snapshot.data[index]['status']}' ==
                                                "review") {
                                              setState(() {
                                                resubmitdoc =
                                                    snapshot.data[index];
                                              });
                                              if (snapshot.data[index]
                                                          ['type'] ==
                                                      "etax-house" ||
                                                  snapshot.data[index]
                                                          ['type'] ==
                                                      "etax-land" ||
                                                  snapshot.data[index]
                                                          ['type'] ==
                                                      "etax") {
                                                Get.to(
                                                  DocuemntreuploadTaxPayer(
                                                    resubmitdoc,
                                                  ),
                                                );
                                              } else {
                                                Get.to(
                                                  DocuemntreuploadSifarish(
                                                    resubmitdoc,
                                                  ),
                                                );
                                              }
                                            } else if ('${snapshot.data[index]['status']}' ==
                                                "rejected") {
                                              rejectalertboxcall();
                                            } else if ('${snapshot.data[index]['status']}' ==
                                                "doc-verified") {
                                              actionsheet(
                                                snapshot.data[index],
                                                snapshot.data[index]
                                                    ['form_label'],
                                                snapshot.data[index]["woda_id"],
                                              );
                                            } else if ('${snapshot.data[index]['status']}' ==
                                                "paid") {
                                              processingalertboxcall();
                                            } else if ('${snapshot.data[index]['status']}' ==
                                                "postpone") {
                                              postponeAlertBox();
                                            } else {
                                              alertboxcall();
                                            }
                                          },
                                          child: ListTile(
                                            leading: Icon(Icons.file_copy,
                                                color: primary, size: 30),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                new Text(
                                                  '${snapshot.data[index]['form_label']}',
                                                  style: TextStyle(
                                                    color: text,
                                                  ),
                                                ),
                                                // '${snapshot.data[index]['pay_status']}' ==
                                                //         "Unpaid"
                                                //     ? new Text('भुक्तानी गर्न बाँकी',
                                                //         style: TextStyle(
                                                //             fontSize: 12,
                                                //             color: text))
                                                // :
                                                new Text(
                                                  '${snapshot.data[index]['status']}'
                                                      .tr,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: snapshot.data[index][
                                                                    'status'] ==
                                                                "review" ||
                                                            snapshot.data[index]
                                                                    [
                                                                    'status'] ==
                                                                "doc-verified"
                                                        ? Colors.red
                                                        : text,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            } else {
                              return SizedBox();
                            }
                          })),

                  //!RIGHT TABBAT
                  Container(
                      child: FutureBuilder(
                          future: approved(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CustomSpinner();
                            } else if (snapshot.hasError) {
                              return CustomErrorCard();
                            } else if (snapshot.data != null) {
                              return snapshot.data.length == 0
                                  ? CustomEmptyCard()
                                  : ListView.builder(
                                      // physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) => InkWell(
                                        onTap: () {
                                          if (snapshot.data[index]['type'] ==
                                              "etax") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PropertyEditHomePage(),
                                              ),
                                            );
                                          } else if (snapshot.data[index]
                                                  ['type'] ==
                                              "land") {
                                          } else if (snapshot.data[index]
                                                  ['type'] ==
                                              "house") {
                                          } else if ('${snapshot.data[index]['status']}' ==
                                              "on_progress") {
                                            finalprocessingalertboxcall();
                                          } else {
                                            approvedactionsheet(
                                                snapshot.data[index]);
                                          }
                                        },
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.file_copy,
                                            color: primary,
                                            size: 30,
                                          ),
                                          trailing: GestureDetector(
                                            child: Icon(
                                              Icons.picture_as_pdf,
                                              color: primary,
                                            ),
                                            onTap: () {
                                              Get.to(Receipt());
                                            },
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new Text(
                                                '${snapshot.data[index]['form_label']}'
                                                    .tr,
                                                style: TextStyle(
                                                  color: text,
                                                ),
                                              ),
                                              new Text(
                                                '${snapshot.data[index]['status']}'
                                                    .tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: snapshot.data[index]
                                                                  ['status'] ==
                                                              "review" ||
                                                          snapshot.data[index]
                                                                  ['status'] ==
                                                              "doc-verified"
                                                      ? Colors.red
                                                      : text,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            } else {
                              return SizedBox();
                            }
                          })),
                ],
              ),
            ),
          )),
    );
  }

  Widget? actionsheet(a, label, wardNumber) {
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
                      var navdata;
                      var data = {'sp_pay_code': a['sp_pay_code']};
                      EasyLoading.show(status: 'Please wait...'.tr);

                      paymentfromsecondprofilepage(data).then((res) => {
                            EasyLoading.dismiss(),
                            navdata = {
                              'name': userdata['name'],
                              'mobile': userdata['mobile'],
                              'pagetitle': "सिफारिश सारांश",
                              'formName': label,
                              'formNum': res['payable']['form_id'],
                              'entry_id': res['payable']['entry_id'],
                              'reference_id': res['data']['reference_id'],
                              'amount': res['data']['in_rupees'],
                              'sp_pay_code': a['sp_pay_code'],
                              'item_type': res['data']['module'],
                              'pay_id': res['data']['pay_id'],
                              'secure_pay_code': res['secure_pay_code'],
                            },
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>    Paymentdetails(
                                data: navdata,
                                wardNumber: wardNumber,
                              ), )),
                            // Get.to(
                            //   Paymentdetails(
                            //     data: navdata,
                            //     wardNumber: wardNumber,
                            //   ),
                            // ),
                          });

                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.money, color: tertiary),
                      title: Text("Payment "),
                    ),
                  ),
                  new InkWell(
                    child: new ListTile(
                      leading: new Icon(Icons.code, color: tertiary),
                      title: Text("Payment Code: ${a['sp_pay_code']}"),
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

  Widget? approvedactionsheet(a) {
    // print(a);
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
                topRight: const Radius.circular(10.0),
              ),
            ),
            child: new Wrap(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    var link = '${a['final_document']}';
                    // download(link);
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return DownloadingDialog(
                              fileName:
                                  'sifaris-${DateFormat('dd-MM-yy-mm-ss').format(DateTime.now()).toString()}',
                              extension: "pdf",
                              url: link,
                            );
                          },
                        );
                      },
                    );

                    // getPermission(link).then((value) {
                    //   if (value) {
                    //     EasyLoading.showSuccess(
                    //       "File has been downloaded",
                    //       duration: Duration(
                    //         seconds: 3,
                    //       ),
                    //     );
                    //   } else {
                    //     EasyLoading.showError(
                    //       "Error while downloading file",
                    //       duration: Duration(
                    //         seconds: 3,
                    //       ),
                    //     );
                    //   }
                    // });
                  },
                  child: new ListTile(
                    leading: new Icon(Icons.download, color: tertiary),
                    title: Text("Download "),
                  ),
                ),
                new InkWell(
                  onTap: () async {
                    var link = '${a['final_document']}';

                    Navigator.pop(context);
                    // PDFDocument doc = await PDFDocument.fromURL(link);
                    Get.to(Pdfviewer(data: link));
                  },
                  child: new ListTile(
                    leading: new Icon(Icons.view_agenda, color: tertiary),
                    title: Text("View"),
                  ),
                ),
                new InkWell(
                  onTap: () {
                    var link = '${a['final_document']}';

                    Share.share(link, subject: "Sifarish");
                  },
                  child: new ListTile(
                    leading: new Icon(Icons.share, color: tertiary),
                    title: Text("Share"),
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
      },
    );
    return null;
  }

  Future<bool> getPermission(link) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    return dowloadButton(link);
  }

  alertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text(
              'documentstatustitle'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primary,
              ),
            ),
            content: Text('documentstatus'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  finalprocessingalertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('finalprocessingdocumenttitle'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('finalprocessingdocumentbody'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  postponeAlertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('postponeAlertTitle'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('postponeAlertBody'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  processingalertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('processingdocumenttitle'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('processingdocumentbody'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  rejectalertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('documentstatustitlereject'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('documentstatusreject'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  Widget buildMovieShimmer() => Container(
        height: Get.height,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                CustomWidget.rectangular(height: 25),
                SizedBox(
                  height: 24,
                ),
              ],
            );
          },
        ),
      );
}
