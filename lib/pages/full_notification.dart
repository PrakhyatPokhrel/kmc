import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kmc/components/InappBrowser.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/emergency/emergency.dart';
import 'package:kmc/pages/hellomayor/appointmentList.dart';
import 'package:kmc/pages/hellomayor/hellomayorEntry.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasoEntry.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayiklist.dart';
import 'package:kmc/pages/news/newslist.dart';
import 'package:kmc/pages/parichaya.dart';
import 'package:kmc/pages/paryatak_sthal.dart';
import 'package:kmc/pages/pratinidhiwordpress/screen/pratinidhiwordpress.dart';
import 'package:kmc/pages/profile/pdfview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/profile/profile.dart';
import 'package:kmc/pages/profile/secondprofile.dart';
import 'package:kmc/pages/rajpatra.dart';
import 'package:kmc/pages/settings.dart';
import 'package:kmc/pages/wodajankari.dart';
import 'package:kmc/pages/wodapatra/citizencharter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;

// import 'package:image_downloader/image_downloader.dart';

class FullNotificaion extends StatefulWidget {
  final data;
  const FullNotificaion({this.data});

  @override
  _FullNotificaionState createState() => _FullNotificaionState();
}

class _FullNotificaionState extends State<FullNotificaion> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallback);

    // print("feature image: " + "${widget.data['feature_img'][0].value}");
  }

  String pdfNme = " ";

  // _launchURL() async {
  // const url = 'https://flutter.io';
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
  final MyInAppBrowser browser = new MyInAppBrowser();

  @override
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

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
                Text('NOTIFICATION'.tr,
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
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.data['title'],
                                      style: TextStyle(
                                          fontSize: 18, color: primary)),
                                  Text(widget.data['message'])
                                ],
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              // // SizedBox(height: 2),
                              // // Text(data['detail'],
                              // //     style: TextStyle(fontSize: 16, color: text)),
                              // widget.data['link'] == null
                              //     ? Container()
                              //     : GestureDetector(
                              //         onTap: () {
                              //           browser.openUrlRequest(
                              //               urlRequest: URLRequest(
                              //                   url: Uri.parse(
                              //                       widget.data['link'])),
                              //               options: options);
                              //         },
                              //         child: Text(
                              //           widget.data['link'],
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             color: Colors.blue.shade900,
                              //             decoration: TextDecoration.underline,
                              //           ),
                              //         ),
                              //       ),
                              SizedBox(height: 10),
                              Stack(
                                children: [
                                  Visibility(
                                    visible: widget.data['image'] != null,
                                    child: CachedNetworkImage(
                                      imageUrl: '${widget.data['image']}',
                                      fit: BoxFit.contain,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/Grey_Placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // imageBuilder:
                                      //     (context, imageProvider) =>
                                      //         CircleAvatar(
                                      //   backgroundImage: imageProvider,
                                      // ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        var random = Random();
                                        EasyLoading.show(
                                            status: 'Please wait...'.tr);

                                        try {
                                          // Download image
                                          final http.Response response =
                                              await http.get(Uri.parse(
                                                  "${widget.data['image']}"));

                                          // Get temporary directory
                                          final dir =
                                              await getTemporaryDirectory();

                                          // Create an image name
                                          var filename =
                                              '${dir.path}/SaveImage${random.nextInt(100)}.png';

                                          // Save to filesystem
                                          final file = File(filename);
                                          await file
                                              .writeAsBytes(response.bodyBytes);

                                          // Ask the user to save it
                                          final params = SaveFileDialogParams(
                                              sourceFilePath: file.path);
                                          final finalPath =
                                              await FlutterFileDialog.saveFile(
                                                  params: params);

                                          if (finalPath != null) {
                                            EasyLoading.dismiss();
                                            EasyLoading.showSuccess(
                                                "file_download_successful".tr);
                                          }
                                        } catch (e) {
                                          EasyLoading.dismiss();
                                          EasyLoading.showError(
                                              "file_download_failed".tr);
                                        }
                                      },
                                      child: Icon(
                                        Icons.download,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Visibility(
                                visible: widget.data['link_category'] != null,
                                child: Center(
                                  child: new ElevatedButton(
                                    child: new Text('more_info'.tr,
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tertiary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(20)),
                                    // disabledTextColor: Colors.white,
                                    onPressed: () async {
                                      widget.data;
                                      EasyLoading.show();
                                      try {
                                        await handleMessageFromData(
                                            widget.data);
                                        EasyLoading.dismiss();
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getPermission(link) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    dowloadButton(link);
  }

  void share(BuildContext context, String text) {
    Share.share(text);
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
                      getPermission(a);

                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.download, color: primary),
                      title: Text("download".tr),
                    ),
                  ),
                  new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(Pdfviewer(data: a));
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.view_agenda, color: primary),
                      title: Text("view".tr),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      share(context, pdfNme);
                    },
                    child: ListTile(
                      leading: new Icon(Icons.share, color: primary),
                      title: Text("Share".tr),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.cancel_outlined, color: primary),
                      title: Text("cancel".tr),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }
}

handleMessageFromData(dynamic data) async {
  String? linkCategory = data['link_category'];
  String? deepLinkCategory = data['deep_link_category'];
  if (linkCategory == 'deep') {
    var pref = await SharedPreferences.getInstance();
    bool? s = pref.getBool('login');
    if (s == true) {
      switch (deepLinkCategory) {
        case 'notice_news':
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const NewsList(),
          //   ),
          // );
          Get.to(NewsList());
          break;
        case 'my_profile':
          Get.to(Profile());
          break;
        case 'my_profile':
          Get.to(Settings());
          break;
        case 'emergency':
          Get.to(Emergency());
          break;
        case 'ward':
          Get.to(Wodajankari());
          break;
        case 'staff':
          Get.to(PratinidhiWordpress());
          break;
        case 'representative':
          Get.to(PratinidhiWordpress());
          break;
        case 'social_development':
          Get.to(BottomNavBar());
          break;
        case 'tourist_center':
          Get.to(Paryatak_Sthal());
          break;
        case 'ejalassh':
          Get.to(NyayikList());
          break;
        case 'digital_profile':
          Get.to(NewsList());
          break;
        case 'finance':
          Get.to(NewsList());
          break;
        case 'home':
          Get.to(NewsList());
          break;
        case 'hello_mayor':
          Get.to(HellomayorEntry());
          break;
        case 'appointment':
          Get.to(AppointmentListScreen());
          break;
        case 'nagarik_wodapatra':
          Get.to(CitizenCharter());
          break;
        case 'janagunaso':
          Get.to(JanaGunasoEntry());
          break;
        case 'esifarish':
          Get.to(SecondProfile());
          break;
        case 'parichaya':
          Get.to(Parichaya());
          break;
        case 'rajpatra':
          Get.to(Rajpatra());
          break;
        case 'environment_agriculture':
          Get.to(NewsList());
          break;
        case 'education':
          Get.to(BottomNavBar());
          break;
        case 'administrative':
          Get.to(BottomNavBar());
          break;
        case 'health':
          Get.to(BottomNavBar());
          break;
        case 'revenue':
          Get.to(BottomNavBar());
          break;
        case 'informationtechnology':
          Get.to(BottomNavBar());
          break;
        case 'law':
          Get.to(BottomNavBar());
          break;
        case 'public_works':
        default:
          break;
      }
    } else {
      switch (deepLinkCategory) {
        case 'notice_news':
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const NewsList(),
          //   ),
          // );
          Get.to(NewsList());
          break;
        case 'emergency':
          Get.to(Emergency());
          break;
        case 'ward':
          Get.to(Wodajankari());
          break;
        case 'staff':
          Get.to(PratinidhiWordpress());
          break;
        case 'representative':
          Get.to(PratinidhiWordpress());
          break;
        case 'social_development':
          Get.to(BottomNavBar());
          break;
        case 'tourist_center':
          Get.to(Paryatak_Sthal());
          break;
        case 'ejalassh':
          Get.to(NyayikList());
          break;
        case 'digital_profile':
          Get.to(NewsList());
          break;
        case 'finance':
          Get.to(NewsList());
          break;
        case 'home':
          Get.to(NewsList());
          break;
        case 'public_works':
        default:
          Get.to(BottomNavBar());
          break;
      }
    }
  } else if (linkCategory == 'external') {
    try {
      launchUrl(Uri.parse(data['link']));
    } catch (e) {
      print(e);
    }
  }
}
