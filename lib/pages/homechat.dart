import 'dart:convert';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/Drawer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/hellomayor/hellomayorEntry.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasoEntry.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasolist.dart';
import 'package:kmc/pages/hellomayor/mayorList.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayikEntry.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayiklist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeChat extends StatefulWidget {
  @override
  _HomeChatState createState() => _HomeChatState();
}

var link = 'assets/images/icons/newIcons/';

class SewaData {
  final String icon;
  final String title;
  final String details;
  final link;
  final bool permit;
  SewaData(this.title, this.icon, this.details, this.link, this.permit);
}

final List<SewaData> sewaData = [
  SewaData('hello_mayor', link + 'HelloMayor.svg', 'hm_desc', HellomayorEntry(), true),
  SewaData('janagunaso', link + 'JanaGunaso.svg', 'jg_desc', JanaGunasoEntry(), true),
  SewaData('Judicial_committee', link + 'JanaGunaso.svg', 'jg_desc', NyayikEntry(), true),
];

class _HomeChatState extends State<HomeChat> {
  @override
  void initState() {
    super.initState();
    getsharedpreference();
  }

  bool loginstatus = false;
  dynamic ismayor;
  dynamic isvicemayor;
  dynamic issuchana;
  dynamic role;
  dynamic role_desig;
  dynamic getsharedpreference() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      dynamic s = pref.getBool('login');
      ismayor = pref.getString('ismayor');

      if (s != null) {
        getToken();
        loginstatus = s;
        loginlout = s;
        ismayor = pref.getString('ismayor');
        isvicemayor = pref.getString('isvicemayor');
        issuchana = pref.getString('issuchana');
        if (pref.getString('role') != null) {
          role = jsonDecode(pref.getString('role')!);
        }
        if (pref.getString('role_desig') != null) {
          role_desig = jsonDecode(pref.getString('role_desig')!);
        }
      } else {
        loginlout = false;
      }
    });
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
                Text('chat'.tr, style: TextStyle(color: primary, fontSize: 22)),
                // InkWell(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: DoubleBack(
          background: background,
          textStyle: TextStyle(color: Colors.black),
          message: "Press back again to close",
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: Get.height,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: sewaData.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (loginstatus == false && sewaData[i].permit == true) {
                                    checklogin();
                                  } else {
                                    Get.to(sewaData[i].link);
                                  }
                                },
                                child: InkWell(
                                  onTap: () {
                                    navigation(context, i, sewaData[i]);
                                  },
                                  child: SewaCard(sewaData[i]),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SewaCard(data) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.width * 0.33,
            // width: MediaQuery.of(context).size.width * 0.6,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  data.icon,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.title}'.tr,
                        style: TextStyle(
                            height: 1.3, color: textPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('${data.details}'.tr,
                        style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 13)),
                  ],
                ),
              ),
            ])));
  }

  navigation(context, index, data) {
    if (loginstatus == true) {
      if (role['role_name'] == "resident" || role_desig['role_name'] == "internal_role") {
        if (data.title == 'hello_mayor') {
          if (ismayor == "TRUE") {
            Get.to(MayorList());
          } else {
            Get.to(data.link);
          }
        } else if (data.title == 'Judicial_committee') {
          if (isvicemayor == "TRUE") {
            Get.to(NyayikList());
          } else {
            Get.to(data.link);
          }
        } else if (data.title == 'janagunaso') {
          if (issuchana == "TRUE") {
            Get.to(GunasoList());
          } else {
            Get.to(data.link);
          }
        } else {
          Get.to(data.link);
        }
      } else {
        rolealert();
      }
    }
    if (loginstatus == false) {
      checklogin();
    }
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
            content: Text('login_alert'.tr,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text('LOGIN'.tr),
                  ),
                  onPressed: () {
                    Get.to(Login());
                  },
                ),
              ),
            ],
          );
        });
  }

  rolealert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('not_available'.tr, textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('role_check'.tr,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text('cancel'.tr),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          );
        });
  }
}
