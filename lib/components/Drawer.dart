import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/components/custom_api_service.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/aboutThisApp/about_this_app.dart';
import 'package:kmc/pages/howToUse/how_to_use_screen.dart';
import 'package:kmc/pages/notification.dart';
import 'package:kmc/pages/settings.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NavDrawer extends StatefulWidget {
  Function callback;
  int indexvalue;
  NavDrawer(this.callback, this.indexvalue);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

final GlobalKey _drawerKey = new GlobalKey();

class DrawerData {
  DrawerData(this.title, this.page, this.icon);
  final String title;
  final page;
  final IconData icon;
}

bool? loginlout;
String? tanslationcode;

class _NavDrawerState extends State<NavDrawer> {
  final LocalStorage storage = new LocalStorage('changu');

  List<DrawerData> drawerData = [
    DrawerData('DASHBOARD', BottomNavBar(), Icons.home),
    DrawerData('NOTIFICATION', Notifications(isBackRequired: true),
        Icons.notifications),
    // DrawerData('suggestions', Suggestion(), Icons.pages),
    DrawerData('SETTINGS', Settings(), Icons.settings),
    DrawerData('AboutThisApp', AboutThisAppScreen(), Icons.info),
    DrawerData('HowToUse', HowToUseScreen(), Icons.help),
    loginlout == false
        // ? DrawerData('LOGIN', LoginIntro(), Icons.login)
        ? DrawerData('LOGIN', Login(), Icons.login)
        : DrawerData('LOGOUT', BottomNavBar(), Icons.logout),
  ];
  dynamic userdata;

  @override
  void initState() {
    super.initState();
    getsoredata();
    sharedprefvalue();
  }

  sharedprefvalue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      bool s = pref.getBool('login') ?? false;

      if (s == false) {
        loginlout = false;
      } else {
        loginlout = true;
      }
    });
    setState(() {});
  }

  getsoredata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      dynamic s = jsonDecode(pref.getString('user')!);
      setState(() {
        userdata = s;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      width: screenWidth * 0.65,
      key: _drawerKey,
      child: new ListView(
        children: <Widget>[
          userdata != null
              ? InkWell(
                  onTap: () => {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Profile()))
                  },
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(
                      userdata != null ? "${userdata['name']}" : '',
                      style: TextStyle(height: 0),
                    ),
                    accountEmail: new Text(
                      userdata != null ? "${userdata['email']}" : '',
                    ),
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary, secondary],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    currentAccountPicture: userdata != null
                        ? CachedNetworkImage(
                            imageUrl: userdata['user_img'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset('assets/images/dummyuser.png',
                                  height: 80, width: 80, fit: BoxFit.contain),
                            ),

                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(userdata['user_img']),
                            ),
                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(
                            //   backgroundColor: primary,
                            // ),
                          )
                        : Container(),
                  ),
                )
              : Container(
                  alignment: Alignment.bottomCenter,
                  height: 160,
                  // No gradient applied to the outer container
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [primary, secondary],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/sarkari_logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // Text(
                      //   AppLocalizations.of(context).translate('palika-name') + ' ' +
                      //   AppLocalizations.of(context).translate('palika-name-sub'),
                      //   style: TextStyle(
                      //     height: 1,
                      //     color: textPrimaryLightColor,
                      //     fontFamily: 'Mukta',
                      //     fontSize: 20.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
          new SizedBox(
            // height: MediaQuery.of(context).size.height,
            height: 400,
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(1.0),
                itemCount: drawerData.length,
                itemBuilder: (context, i) {
                  return item(drawerData[i]);
                }),
          ),
          Center(
            widthFactor: 20,
            child: ToggleSwitch(
                initialLabelIndex: widget.indexvalue,
                minWidth: 90.0,
                changeOnTap: true,
                cornerRadius: 20,
                activeBgColor: [secondary],
                inactiveBgColor: Colors.grey.shade300,
                labels: ['नेपाली', 'English'],
                icons: [Icons.language_sharp, Icons.language],
                onToggle: (index) {
                  if (index == 0) {
                    setState(() {});

                    this.widget.callback('hi', index);
                  } else {
                    setState(() {});

                    this.widget.callback('en', index);
                  }
                  // widget.indexvalue = index;
                }),
          )
        ],
      ),
    );
  }

  setlangindex(lang) {
    setState(() {
      // AppLocalizations.of(context).load(Locale(lang));
    });
  }

  item(i) {
    // return Text(i.title);
    return ListTile(
        leading: i.title == "HowToUse"
            ? Icon(
                i.icon,
                color: primary,
              )
            : Icon(
                i.icon,
              ),
        title: new Text(
          '${i.title}'.tr,
          style:
              i.title == "HowToUse" ? TextStyle(color: primary) : TextStyle(),
        ),
        onTap: () async {
          if (i.title == "LOGOUT") {
            EasyLoading.show(status: 'Please wait...'.tr);
            SharedPreferences pref = await SharedPreferences.getInstance();
            String devicetoken = pref.getString('devicetoken')!;
            var data = {'gcm_token': '${devicetoken}'};

            logoutApi(data).then((data) async {
              if (data == true) {
                //
                EasyLoading.dismiss();
                await storage.clear();
                await sharedprefdelete(i.page);
                setState(() {});
                await pref.setBool("onBoardingCompleted", true);
                await pref.remove("login");
                setState(() {});
                Navigator.pop(context);
                await CustomApiService().setAuthToken();
                // alertSucessBox();
                Get.off(
                  () => BottomNavBar(),
                  preventDuplicates: false,
                );
                setState(() {});
              } else {
                //
                EasyLoading.dismiss();
                EasyLoading.showError('server_connection_error'.tr);
              }
            });
          } else {
            Navigator.pop(context);

            Get.to(i.page);
          }
          // Navigator.pop(context);
        });
  }

  alertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('दर्ता सफल',
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text(
                'यो सेवा नि:शुल्क रहेको छ। तपाईले भर्नुभएको ई-सिफारिस काठमाडौँ महानगरपालिका वडा कार्यालयमा दर्ता भएको छ। आवेदन तथा दस्तावेज मान्य भएको खण्डमा सिफारिश प्रतिलिपि यसै एप्स वा ईमेलमार्फत पाउनुहुनेछ। दस्तावेज मान्य नभएमा त्यसको जानकारी पाउनुहुनेछ।',
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
                    Get.off(BottomNavBar());
                  },
                ),
              ),
            ],
          );
        });
  }

  alertSucessBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Logout Successful!'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10,
                    ),
                    child: Text(
                      'ok'.tr,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                    Get.off(
                      BottomNavBar(),
                      preventDuplicates: true,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> sharedprefdelete(page) async {
    setState(() {
      loginlout = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String devicetoken = pref.getString('devicetoken')!;
    await pref.clear();
    await pref.setBool("onBoardingCompleted", true);
    await pref.remove('login');
    await pref.setString('devicetoken', devicetoken);
    setState(() {});

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => BottomNavBar()),
    // );
  }
}

// Bichma thulo vako wala code...don't remove

//  bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 7.0,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.message, color: Colors.black45),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.view_list, color: Colors.black45),
//               onPressed: () {},
//             ),
//             SizedBox(width: 25),
//             IconButton(
//               icon: Icon(Icons.call, color: Colors.black45),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.person_outline, color: Colors.black45),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
