import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_empty_card.dart';
import 'package:kmc/components/custom_error_card.dart';
import 'package:kmc/components/custom_spinner.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/full_notification.dart';
import 'package:kmc/pages/profile/secondprofile.dart';

class Notifications extends StatefulWidget {
  final bool isBackRequired;
  @override
  final data;
  Notifications({
    this.data,
    this.isBackRequired = false,
  });
  _NotificationsState createState() => _NotificationsState(data: this.data);
}

class _NotificationsState extends State<Notifications>
    with TickerProviderStateMixin {
  var data;
  _NotificationsState({this.data});
  TabController? _tabController;
  int _currentIndex = 0;

  // Future<List<Usernotificationmodal>> personalnotif() async {
  //   List<Usernotificationmodal> notif = await personalnotificationhistoryAPi();
  //   return notif;
  // }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  dynamic personalnotification;
  dynamic generalNotification;

  personalnotif() {
    personalnotification = personalnotificationhistoryAPi();
    return personalnotification;
  }

  generalnotification() async {
    generalNotification = await notificationhistoryAPi();
    return generalNotification;
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
          child: widget.isBackRequired
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NOTIFICATION'.tr,
                      style: TextStyle(
                        color: primary,
                        fontSize: 22,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primary,
                        size: 28,
                      ),
                    ),
                  ],
                )
              : Text(
                  'NOTIFICATION'.tr,
                  style: TextStyle(
                    color: primary,
                    fontSize: 22,
                  ),
                ),
        ),
        bottom: TabBar(
            controller: _tabController,
            labelColor: primary,
            unselectedLabelColor: text,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('NORMAL'.tr, style: TextStyle(fontSize: 18)),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Pesonal'.tr, style: TextStyle(fontSize: 18)),
                ),
              ),
            ]),

        // TabBar(
        //   controller: _tabController,
        //   indicatorColor: primary,
        //   labelColor: primary,
        //   unselectedLabelColor: textPrimaryColor,
        //   tabs: [
        //     Tab(text: 'NORMAL'.tr),
        //     Tab(text: 'Pesonal'.tr),
        //   ],
        // ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabBarView(
            controller: _tabController,
            children: [
              //!General Notification
              FutureBuilder(
                future: generalnotification(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomSpinner();
                  } else if (snapshot.hasError) {
                    return CustomErrorCard();
                  } else if (snapshot.hasData) {
                    return snapshot.data.length == 0
                        ? CustomEmptyCard(
                            message: "EMPTY_NOTIF".tr,
                          )
                        : Container(
                            color: Colors.white,
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/icon.png',
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data[index]['title'].toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data[index]['message']}",
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          snapshot.data[index]
                                                  ['notification_time']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      if (snapshot.data[index]['category'] ==
                                          "sifarish") {
                                        Get.to(SecondProfile());
                                      } else {
                                        Get.to(FullNotificaion(
                                          data: snapshot.data[index],
                                        ));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              //!Personal Notification
              FutureBuilder(
                future: personalnotif(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomSpinner();
                  } else if (snapshot.hasError) {
                    return CustomErrorCard(
                      message: "login_request".tr,
                    );
                  } else if (snapshot.hasData) {
                    return snapshot.data.length == 0
                        ? CustomEmptyCard(
                            message: "EMPTY_NOTIF".tr,
                          )
                        : Container(
                            color: Colors.white,
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/icon.png',
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data[index]['title'].toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data[index]['message']}",
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          // textAlign: TextAlign.justify,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          snapshot.data[index]
                                                  ['notification_time']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      if (snapshot.data[index]['category'] ==
                                          "sifarish") {
                                        Get.to(SecondProfile());
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    )

        // SingleChildScrollView(
        //   child: Container(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //       child: Column(
        //         children: <Widget>[
        //           FutureBuilder(
        //             future: getnotifApi(),
        //             builder: (BuildContext context, AsyncSnapshot snapshot) {
        //               if (snapshot.connectionState == ConnectionState.waiting ||
        //                   snapshot.hasData == null) {
        //                 return Container();
        //               } else if (snapshot.hasError) {
        //                 return Container();
        //               } else {
        //                 return Container(
        //                   height: 800,
        //                   child: ListView.builder(
        //                     itemCount: snapshot.data.length,
        //                     itemBuilder: (BuildContext context, int index) {
        //                       return Card(
        //                         elevation:0,
        //                         color: Colors.grey.shade50,
        //                         child: ListTile(
        //                           leading: CircleAvatar(
        //                             radius: 20,
        //                             backgroundImage: AssetImage(
        //                                 'assets/images/sarkari_logo.png'),
        //                           ),
        //                           title: Text(snapshot.data[index].message,
        //                               maxLines: 2,
        //                               overflow: TextOverflow.ellipsis),
        //                           subtitle: Text(
        //                               "Sent at: ${snapshot.data[index].date}"),
        //                           trailing: Icon(
        //                             Icons.arrow_forward_ios,
        //                             color: Colors.green.shade400,
        //                           ),
        //                           onTap: () {},
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                 );
        //               }
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  popUp(context, data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: content(context, data));
        });
  }

  content(context, data) {
    return Stack(children: [
      Container(
          width: Get.width,
          height: Get.height * 0.3,
          margin: EdgeInsets.symmetric(vertical: 130),
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 5), blurRadius: 10),
                ]),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/sarkari_logo.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${data['title']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primary,
                            fontFamily: 'Mukta',
                            fontSize: 16.0,
                            height: 1),
                      ),
                    ],
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: new BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.2),
                        child: Text(
                          data['headline'],
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16.0,
                            color: text,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          )),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(top: 110),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/images/icons/newIcons/cross.png')),
        ),
      )
    ]);
  }

  popUps(context, data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contents(context, data));
        });
  }

  contents(context, data) {
    return Stack(children: [
      Container(
          width: Get.width,
          height: Get.height * 0.5,
          margin: EdgeInsets.symmetric(vertical: 130),
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 5), blurRadius: 10),
                ]),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/sarkari_logo.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${data.title}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primary,
                            fontFamily: 'Mukta',
                            fontSize: 16.0,
                            height: 1),
                      ),
                    ],
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: new BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.2),
                        child: Text(
                          data.message,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16.0,
                            color: text,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          )),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(top: 110),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/images/icons/newIcons/cross.png')),
        ),
      )
    ]);
  }
}


// void navigateToPageFromNotification(dynamic message) {
//   // Navigate to your desired page here
//   handleMessage(
//     message,
//   ); // Example navigation to BottomNavBar
// }
