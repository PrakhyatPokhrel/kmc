import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/colors.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final LocalStorage storage = new LocalStorage('changu');
  bool? loginlout;
  dynamic userdata;
  int indexvalue = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      dynamic s = storage.getItem('user');
      if (s != null) {
        userdata = jsonDecode(s);
      }
    });
    sharedprefvalue();
  }

  logout() async {
    loginlout = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    pref.setBool("onBoardingCompleted", true);
    pref.remove('login');

    storage.clear();

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => new BottomNavBar()), (route) => false);
  }

  sharedprefvalue() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      dynamic s = pref.getBool('login');

      if (s != null) {
        loginlout = s;
      }
      var b = pref.getInt('langindex');
      if (b != null) {
        indexvalue = pref.getInt('langindex')!;
      }
    });
  }

  Future setsharedpref(language, index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      pref.setString('lang', language);
      pref.setInt('langindex', index);
    });
  }

  final _formKey = GlobalKey<FormState>();
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
                Text('SETTINGS'.tr, style: TextStyle(color: primary, fontSize: 22)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    userdata != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10, right: 10),
                            child: userdata == null
                                ? Container()
                                : CachedNetworkImage(
                                    imageUrl: '${userdata['user_img']}',
                                    errorWidget: (context, url, error) => Text("error"),
                                    imageBuilder: (context, imageProvider) => CircleAvatar(
                                      radius: 35,
                                      backgroundImage: imageProvider,
                                    ),
                                  ))
                        : Container(),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(userdata != null ? userdata['name'] : '',
                          style: TextStyle(fontSize: 18, height: 1)),
                      Text(
                        userdata != null ? userdata['email'] : '',
                        style: TextStyle(height: 1.3),
                      )
                    ])
                  ]),
                  // Divider(),
                  headerText('GENERALSETTINGS'.tr),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.settings, size: 30),
                    ),
                    Text('LANGUAGE'.tr, style: TextStyle(fontSize: 18, height: 1)),
                    SizedBox(width: 30),
                    ToggleSwitch(
                        initialLabelIndex: indexvalue,
                        minWidth: 90.0,
                        changeOnTap: true,
                        cornerRadius: 20,
                        activeBgColor: [primary],
                        inactiveBgColor: Colors.grey.shade300,
                        labels: ['नेपाली', 'English'],
                        icons: [Icons.language_sharp, Icons.language],
                        onToggle: (index) {
                          if (index == 0) {
                            // setlangindex('np');
                            setState(() {
                              var locale = Locale('hi', 'IN'); // translations will be displayed in that local
                              Get.updateLocale(locale);
                            });
                            setsharedpref('hi', index);
                            indexvalue = index!;
                          } else {
                            setState(() {
                              var locale = Locale('en', 'US'); // translations will be displayed in that local
                              Get.updateLocale(locale);
                            });
                            setsharedpref('en', index);
                            indexvalue = index!;
                          }
                        }),
                  ]),
                  Divider(),
                  headerText('OTHERSETTINGS'.tr),
                  // GestureDetector(
                  //     onTap: () {
                  //       // fingerPrint();
                  //     },
                  //     child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(10),
                  //             child: Icon(Icons.fingerprint, size: 30),
                  //           ),
                  //           SizedBox(width: Get.width * 0.05),
                  //           Text('fingerPrint'.tr,
                  //               style: TextStyle(fontSize: 18, height: 1)),
                  //         ])),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.lock, size: 30),
                    ),
                    Text('change_password'.tr, style: TextStyle(fontSize: 18, height: 1)),
                    SizedBox(width: 120),
                    GestureDetector(
                      onTap: () {
                        changePasswordPopup(context, _formKey);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.arrow_forward, size: 20),
                      ),
                    )
                  ]),
                  //logout
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.logout, size: 30),
                        ),
                        SizedBox(width: 22),
                        loginlout == true
                            ? ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(primary),
                                ),
                                child: Text('LOGOUT'.tr, style: TextStyle(color: textPrimaryLightColor)),
                                onPressed: () {
                                  logout();
                                },
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(primary),
                                ),
                                child: Text('LOGIN'.tr, style: TextStyle(color: textPrimaryLightColor)),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                              ),
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  headerText(text) {
    return Text(text, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, height: 2));
  }
}

changePasswordPopup(context, _formKey) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: primary,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      title: Text('change_password'.tr,
                          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    new ListTile(
                      // leading: Icon(Icons.lock, color: primary),
                      title: new TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                          hintText: 'current_password'.tr,
                        ),
                      ),
                    ),
                    new ListTile(
                      title: new TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                          hintText: 'new_password'.tr,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primary),
                        ),
                        child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
