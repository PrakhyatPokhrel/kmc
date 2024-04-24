import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/hellomayor/chatInsideApp.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/userNSchat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NyayikEntry extends StatefulWidget {
  @override
  _NyayikEntryState createState() => _NyayikEntryState();
}

class _NyayikEntryState extends State<NyayikEntry> {
  @override
  void initState() {
    super.initState();
    mayorvicemayor();
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  dynamic vicemayor;
  mayorvicemayor() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      mayordata = json.decode(pref.getString('mayor')!);
      vicemayor = json.decode(pref.getString('vicemayor')!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        elevation: 0,
        actions: [],
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: secondary,
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text( 'Judicial_committee'),
      //           style: TextStyle(color: white, fontSize: 22)),
      //       InkWell(
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           child: Icon(Icons.arrow_back, color: white, size: 28)),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              secondary,
              primary,
            ],
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Judicial_committee'.tr,
                        style: TextStyle(color: white, fontSize: 22)),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: white, size: 28)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 80),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: vicemayor?['image_url'],
                        // imageUrl:
                        //     'https://kathmandumetro.smartpalika.io/images/user/20191108024004.png',
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(350),
                          child: Image.asset('assets/images/dummyuser.png',
                              height: 200, width: 200, fit: BoxFit.cover),
                        ),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 55,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          backgroundColor: tertiary,
                        ),
                      ),
                    ),
                    Text(
                      vicemayor?['name'],
                      // 'nyayik',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textPrimaryLightColor,
                        fontFamily: 'Mukta',
                        height: 1.8,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      'upamayor'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textPrimaryLightColor,
                        fontFamily: 'Mukta',
                        height: 1,
                        fontSize: 15.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'नमस्कार ! यहाँहरू र हामीबीचको दूरी घटाउन' +
                            ' ' +
                            'Judicial_committee'.tr +
                            ' ' +
                            'सेवा सुरु गरेका छौं। केहि सल्लाह-सुझाव वा गुनासो भएमा हामीलाई पठाउनुहोला।',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textPrimaryLightColor,
                          fontFamily: 'Mukta',
                          height: 1.5,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth >= 500) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    pushchatpage();
                                  },
                                  child: ButtonCardTablet('chat', 'chat.svg')),
                              InkWell(
                                  onTap: () {
                                    // pushchatpage();
                                    _callNumber(mayordata['mobile']);
                                  },
                                  child: ButtonCardTablet('phone', 'call.svg')),
                            ]);
                      } else {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InsideAppBrowser()));
                                    // pushchatpage();
                                  },
                                  child: ButtonCard('Ijalas'.tr, 'chat.svg')),
                              InkWell(
                                  onTap: () {
                                    // pushchatpage();
                                    _callNumber(mayordata['mobile']);
                                  },
                                  child: ButtonCard('phone', 'call.svg')),
                            ]);
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pushchatpage() {
    var datadetail;
    EasyLoading.show(status: 'Please wait...'.tr);

    opennyayikfromuserAPI().then((value) => {
          getMsgFromUserNSApi().then((res) => {
                datadetail = {
                  'id': value!.user?.id,
                  'name': value.user?.name,
                  'image': value.user?.user_img,
                  'conv_id': value.conversation,
                  'chat': res?.conversationlist
                },
                EasyLoading.dismiss(),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserNSChat({'data': datadetail})),
                )
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserNSChat({'data': datadetail})),
              })
        });
  }

  ButtonCard(title, icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              color: Colors.white,
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.16,
                  width: MediaQuery.of(context).size.width * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/images/icons/newIcons/' + icon,
                      fit: BoxFit.contain,
                    ),
                  ))),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$title'.tr,
                    style: TextStyle(
                      height: 1.3,
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ButtonCardTablet(title, icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              color: Colors.white,
              child: Container(
                  padding: EdgeInsets.all(10),
                  // height: MediaQuery.of(context).size.width * 0.16,
                  // width: MediaQuery.of(context).size.width * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/images/icons/newIcons/' + icon,
                      fit: BoxFit.contain,
                    ),
                  ))),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$title'.tr,
                    style: TextStyle(
                      height: 1.3,
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _callNumber(contact) async {
    var number = contact; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
