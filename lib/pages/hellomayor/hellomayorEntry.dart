import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/hellomayor/bookappointment.dart';
import 'package:kmc/pages/hellomayor/userHMchat.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HellomayorEntry extends StatefulWidget {
  @override
  // final data;
  // HellomayorEntry({this.data});
  _HellomayorEntryState createState() => _HellomayorEntryState();
}

class _HellomayorEntryState extends State<HellomayorEntry> {
  Channel? channel;
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
  dynamic mayordata;
  dynamic suchanaAdhikari;
  mayorvicemayor() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      mayordata = json.decode(pref.getString('mayor')!);
      vicemayor = json.decode(pref.getString('vicemayor')!);
    });
  }

  connection() async {
    // channel = await Pusher.subscribe('private-message-147');
    // print('channel$channel');

    // channel.bind('newmessage', (onEvent) {
    //   print(onEvent.data);
    // });
  }

  // var data;
  // _HellomayorEntryState({this.data});
  bool light = true;
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
                    Text(
                      'hello_mayor'.tr,
                      style: TextStyle(
                        color: white,
                        fontSize: 22,
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: white,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Switch(
                            value: light,
                            activeColor: Colors.lime,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 80),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundColor: light == true ? Colors.transparent : Colors.grey[550],
                        radius: 58,
                        child: mayordata != null
                            ? CachedNetworkImage(
                                imageUrl: mayordata?['image_url'],
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
                                placeholder: (context, url) => CircularProgressIndicator(
                                  backgroundColor: tertiary,
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                    Text(
                      '${mayordata?['name']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textPrimaryLightColor,
                        fontFamily: 'Mukta',
                        height: 1.8,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'head'.tr,
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
                            'hellomayor'.tr +
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
                        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      pushchatpage();
                                    },
                                    child: ButtonCard('chat', 'chat.svg')),
                                InkWell(
                                  onTap: () {
                                    // pushchatpage();
                                    _callNumber(mayordata['mobile']);
                                  },
                                  child: ButtonCard('phone', 'call.svg'),
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(BookAppointment());
                                    },
                                    child: ButtonCard('अपोइन्टमेन्ट', 'meeting.svg')),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  BookAppointment(),
                                );
                                // pushchatpage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [],
                              ),
                            ),
                          ],
                        );
                      }
                    })
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

    openhellomayorfromuserAPI().then((value) => {
          getMsgFromUserHMApi().then((res) => {
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
                  MaterialPageRoute(builder: (context) => UserHMChat({'data': datadetail})),
                )
              })
        });
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
                      color: primary,
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

  ButtonCardBig(title, icon) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.width * 0.20,
            width: MediaQuery.of(context).size.width * 0.40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'assets/images/icons/newIcons/' + icon,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title'.tr,
                        style: TextStyle(
                          height: 1.3,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _callNumber(contact) async {
    var number = contact; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
