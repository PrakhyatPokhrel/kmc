import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/ghardhuri.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/config/colors.dart';

class LoginIntro extends StatefulWidget {
  @override
  _LoginIntroState createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
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
                Text('LOGIN'.tr,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image(
                        image: AssetImage('assets/images/sp_logo_horiz.png'),
                        width: MediaQuery.of(context).size.width / 2),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Ghardhuri());
                    },
                    child: Container(
                      width: Get.width,
                      child: Image(
                        image: AssetImage('assets/images/household.png'),
                        width: Get.width,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(Login());
                      },
                      child: Container(
                        width: Get.width,
                        child: Image(
                          image: AssetImage('assets/images/phone.png'),
                        ),
                      )),
                  SizedBox(height: 10),
                  Container(
                      width: Get.width,
                      decoration: new BoxDecoration(
                        border: Border.all(color: primary),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('info_safe'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: primary, fontSize: 16)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
