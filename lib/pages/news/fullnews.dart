import 'dart:isolate';
import 'dart:ui';

import 'package:kmc/components/InappBrowser.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/profile/pdfview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class FullNews extends StatefulWidget {
  final data;
  const FullNews({this.data});

  @override
  _FullNewsState createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
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
                Text(widget.data['name'],
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
                              LayoutBuilder(builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                if (constraints.maxWidth >= 500.0) {
                                  return widget.data['feature_img'].length != 0
                                      ? CarouselSlider.builder(
                                          itemCount:
                                              widget.data['feature_img'].length,
                                          itemBuilder: (context, index, i) =>
                                              GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => Container(
                                                  height: 500.0,
                                                  width: 700.0,
                                                  color: Colors.grey[100],
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '${widget.data['feature_img'][index].value}',

                                                    fit: BoxFit.fill,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
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
                                              );
                                            },
                                            child: Container(
                                              color: Colors.grey[500],
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${widget.data['feature_img'][index].value}',

                                                fit: BoxFit.contain,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
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
                                          ),
                                          options: CarouselOptions(
                                            height: 200.0,
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 0.6,
                                            aspectRatio: 1 / 1.4142,
                                            initialPage: 1,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 5000),
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        )
                                      : Container(
                                          height: Get.height * 0.4,
                                          width: Get.width,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: Image.asset(
                                              'assets/images/Grey_Placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                } else {
                                  return widget.data['feature_img'].length != 0
                                      ? CarouselSlider.builder(
                                          itemCount:
                                              widget.data['feature_img'].length,
                                          itemBuilder: (context, index, i) =>
                                              GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => Container(
                                                  height: 500.0,
                                                  width: 700.0,
                                                  color: Colors.grey[100],
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '${widget.data['feature_img'][index].value}',

                                                    fit: BoxFit.fill,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
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
                                              );
                                            },
                                            child: Container(
                                              color: Colors.grey[500],
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${widget.data['feature_img'][index].value}',

                                                fit: BoxFit.contain,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
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
                                          ),
                                          options: CarouselOptions(
                                            height: 200.0,
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 0.6,
                                            aspectRatio: 1 / 1.4142,
                                            initialPage: 1,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 5000),
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            'assets/images/Grey_Placeholder.png',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                }
                              }),

                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.data['title'],
                                      style: TextStyle(
                                          fontSize: 18, color: primary)),
                                  Text(widget.data['news_date'])
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              // SizedBox(height: 2),
                              // Text(data['detail'],
                              //     style: TextStyle(fontSize: 16, color: text)),
                              Html(
                                data: widget.data['detail'],
                                // defaultTextStyle:
                                //     TextStyle(fontSize: 16, color: text)
                              ),

                              widget.data['link'] == null
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        browser.openUrlRequest(
                                            urlRequest: URLRequest(
                                                url: Uri.parse(
                                                    widget.data['link'])),
                                            options: options);
                                      },
                                      child: Text(
                                        widget.data['link'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue.shade900,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 16),
                              widget.data['news_file'] != null
                                  ? Container(
                                      height: Get.height *
                                          0.07 *
                                          widget.data['news_file'].length,
                                      child: ListView.builder(
                                          itemCount:
                                              widget.data['news_file'].length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                pdfNme = widget
                                                    .data['news_file'][index]
                                                    .value;

                                                approvedactionsheet(pdfNme);
                                              },
                                              child: Card(
                                                elevation: 0.2,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.picture_as_pdf,
                                                      color:
                                                          textPrimaryDarkColor,
                                                      size: 50,
                                                    ),
                                                    SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Text(
                                                      "${widget.data['news_file'][index].name}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(),
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
