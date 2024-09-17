import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/Drawer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/home/home.dart';
import 'package:kmc/pages/homechat.dart';
import 'package:kmc/pages/news/newslist.dart';
import 'package:kmc/pages/notification.dart';
import 'package:kmc/pages/profile/profile.dart';
import 'package:new_version/new_version.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Properties & Variables needed
  InAppWebViewController? _webViewController;
  int currentTab = 1; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    HomeChat(),
    NewsList(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home(); // Our first view in viewport
  bool navigated = false;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // _register() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   _firebaseMessaging
  //       .getToken()
  //       .then((token) => pref.setString('devicetoken', token));
  // }
  // final FirebaseMessaging? _firebaseMessaging = FirebaseMessaging.instance;
  _register() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // await FirebaseMessaging.instance.getToken().then((token) {
    //   print("devicetoken: $token");
    //   pref.setString('devicetoken', token!);
    // });
  }

  _showVersionChecker() {
    try {
      NewVersion(
        // iOSId: 'co.cellapp.kirana',//dummy IOS bundle ID
        androidId: 'co.cellapp.smartpalika.kathmandumetropolitancity', //dummy android ID
      ).showAlertIfNecessary(context: context);
    } catch (e) {
      debugPrint("error=====>${e.toString()}");
    }
  }

  requestNotificationPermission() async {
    // PermissionStatus status =
    //     await NotificationPermissions.getNotificationPermissionStatus();
    // if (status == PermissionStatus.denied ||
    //     status == PermissionStatus.unknown) {
    //   await NotificationPermissions.requestNotificationPermissions(
    //     iosSettings: NotificationSettingsIos(),
    //     openSettings: true,
    //   );
    // }

    await NotificationPermissions.requestNotificationPermissions(
      iosSettings: NotificationSettingsIos(),
      //AppLaunch Notification Ask Permission Request
      openSettings: true,
    );
  }

  @override
  void initState() {
    super.initState();
    //server maintenance page
    // maintain(context);
    requestNotificationPermission();
    if (!kDebugMode) {
      _showVersionChecker();
    }
    // _register();
    getpratinidhi();
    nagarKarmachari();
    getsharedpreference();
    // barchartdatawithoutmodal();
    // barchartdata();
    navigateToScreenExternalLink();
  }

  navigateToScreenExternalLink() async {
    var initailMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initailMessage != null && !navigated) {
      Get.to(Notifications());
      // navigateToPageFromNotification(initailMessage);
      setState(() {
        navigated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: secondary,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'assets/images/bot.png',
                  fit: BoxFit.contain,
                ),
              ),
              // SvgPicture.asset(
              //   'icons/sp-icon/adsl.svg',
              //   color: Colors.green.shade500,
              //   fit: BoxFit.cover,
              // ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Colors.transparent,
                ),
              ),
            ),
            onPressed: () {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        height: 610,
                        width: MediaQuery.of(context).size.width,
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(url: Uri.parse("https://kmc.palmchatbot.com")),
                          //           initialData: InAppWebViewInitialData(data: r"""<!DOCTYPE html>

                          // <html lang="en">

                          // <head>
                          //     <meta charset="UTF-8">
                          //     <meta name="viewport" content="width=device-width, initial-scale=1.0">
                          //     <meta http-equiv="X-UA-Compatible" content="ie=edge">
                          //     <title>KMC Bot</title>
                          //     <!-- //optional -->
                          //     <link rel="stylesheet" type="text/css" href="https://kmc.palmchatbot.com/embed/embed.css">
                          // </head>

                          // <body style="height: 2000px; background: #ECE9E9;">
                          //         <script type="text/javascript" src="https://kmc.palmchatbot.com/embed/embed.js"></script>
                          //     <script>
                          //         (function myFunction(){
                          //             Botfunction('palmbot','92vh','100%',['geolocation'],'https://kmc.palmchatbot.com');
                          //         })();
                          //     </script>
                          //     <script src="https://kmc.palmchatbot.com/assets/jquery-3.5.1.min.js" crossorigin="anonymous"></script>

                          // </body>
                          // </html>"""),
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                              javaScriptEnabled: true,
                            ),
                          ),
                          onWebViewCreated: (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: primary,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primary,
                primary,
              ],
            ),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Home(); // if user taps on this Home tab will be active
                          currentTab = 1;
                        });
                      },
                      child: tabsColumn('Home_White_Nav.svg', 'Home', 1),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = NewsList(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[tabsColumn('News_White_Nav.svg', 'News', 3)],
                      ),
                    ),
                  ],
                ),
              ),

              // Right Tab bar icons

              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                Notifications(); // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        // child: tabsColumn('Chat_White_Nav.svg', 'Chat', 2)),
                        child: tabsColumn('notification.svg', 'Notification', 2)),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          if (loginstatus == false) {
                            checklogin();
                          } else {
                            currentScreen = Profile(); // if user taps on this dashboard tab will be active
                            currentTab = 4;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[tabsColumn('Profile_White_Nav.svg', 'Profile', 4)],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  checklogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text('LOGIN'.tr, textAlign: TextAlign.center, style: TextStyle(color: primary)),
          content: Text(
            'login_alert'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(tertiary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Text('LOGIN'.tr),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(Login());
                },
              ),
            ),
          ],
        );
      },
    );
  }

  tabsColumn(icon, name, index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Icon(
          //   icon,
          //   color: white,
          //   size: currentTab == index ? 35 : 25,
          // ),
          SvgPicture.asset(
            'assets/images/icons/newIcons/' + icon,
            color: Colors.white,
            fit: BoxFit.cover,
            height: currentTab == index ? 24 : 22,
          ),
          // Text(
          //   'Dashboard',
          //   style: TextStyle(
          //     color: currentTab == index ? secondary : white,
          //   ),
          // ),
        ],
      ),
    );
  }

  bool loginstatus = false;
  dynamic ismayor;
  dynamic isvicemayor;
  dynamic issuchana;
  getsharedpreference() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      String? a = pref.getString('lang');

      if (a != null) {
        setState(() {
          if (a == 'hi') {
            var locale = Locale('hi', 'IN'); // translations will be displayed in that local
            Get.updateLocale(locale);
          } else {
            var locale = Locale('en', 'US'); // translations will be displayed in that local
            Get.updateLocale(locale);
          }
        });
      } else {
        setState(() {
          var locale = Locale('hi', 'IN'); // translations will be displayed in that locale
          Get.updateLocale(locale);
        });
      }

      dynamic s = pref.getBool('login');
      ismayor = pref.getString('ismayor');

      if (s != null) {
        getToken();
        loginstatus = s;
        loginlout = s;
        ismayor = pref.getString('ismayor');
        isvicemayor = pref.getString('isvicemayor');
        issuchana = pref.getString('issuchana');
      } else {
        loginlout = false;
      }
    });
  }

  freealert(body, title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(
            '$title',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primary,
            ),
          ),
          content: Text(
            '$body',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(tertiary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text('बन्द गर्नुहोस्'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(tertiary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10,
                    ),
                    child: Text('ठीक छ'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(Notifications());
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
