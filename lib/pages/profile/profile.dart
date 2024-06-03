import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/profile/profile_confirm_dialog.dart';
import 'package:kmc/pages/profile/receipt.dart';
import 'package:kmc/pages/profile/secondprofile.dart';
import 'package:kmc/utils/image_picker/image_picker_dialog.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Auth/ghardhuri.dart';
import '../../constants/constants.dart';
import '../sewa/sifarish_new/static_data/custom_regex_pattern.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final LocalStorage storage = new LocalStorage('changu');
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  var address = TextEditingController();
  bool checkboxValue = true;
  var email = TextEditingController();
  dynamic imageupload;
  var mobile = TextEditingController();
  var name = TextEditingController();
  var name_np = TextEditingController();
  dynamic userdata;
  int? _currentWard;

  var _currentGender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getsoredata();
    });
  }

  @override
  void dispose() {
    address.dispose();
    email.dispose();
    mobile.dispose();
    name.dispose();
    super.dispose();
  }

  getsoredata() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    dynamic s = jsonDecode(pref.getString('user')!);
    setState(() {
      userdata = s;
      name.text = '${s['name']}';
      name_np.text = s['name_np'] ?? '';
      address.text = '${s['address']}';
      email.text = '${s['email']}';
      mobile.text = '${s['mobile']}';
      if (s['gender'] == "male" || s['gender'] == "Male") {
        _currentGender = "Male";
      } else if (s['gender'] == "female" || s['gender'] == "Female") {
        _currentGender = "Female";
      } else if (s['gender'] == "others" || s['gender'] == "Others") {
        _currentGender = "Others";
      }
      _currentWard = s['woda_id'] ?? s['ward_id'];
    });
    //
  }

  // var _gender = [
  //   {"name": "पुरुष", "value": "पुरुष"},
  //   {"name": "महिला", "value": "महिला"},
  //   {"name": "अन्य", "value": "अन्य"}
  // ];

  var _wards = [
    {"name": "१", "value": "1"},
    {"name": "२", "value": "2"},
    {"name": "३", "value": "3"},
    {"name": "४", "value": "4"},
    {"name": "५", "value": "5"},
    {"name": "६", "value": "6"},
    {"name": "७", "value": "7"},
    {"name": "८", "value": "8"},
    {"name": "९", "value": "9"},

    //
    {"name": "१०", "value": "10"},
    {"name": "११", "value": "11"},
    {"name": "१२", "value": "12"},
    {"name": "१३", "value": "13"},

    {"name": "१४", "value": "14"},
    {"name": "१५", "value": "15"},
    {"name": "१६", "value": "16"},
    {"name": "१७", "value": "17"},
    {"name": "१८", "value": "18"},
    {"name": "१९", "value": "19"},

    {"name": "२०", "value": "20"},
    {"name": "२१", "value": "21"},

    {"name": "२२", "value": "22"},
    {"name": "२३", "value": "23"},
    {"name": "२४", "value": "24"},
    {"name": "२५", "value": "25"},
    {"name": "२६", "value": "26"},
    {"name": "२७", "value": "27"},
    {"name": "२८", "value": "28"},
    {"name": "२९", "value": "29"},

    {"name": "३०", "value": "30"},
    {"name": "३१", "value": "31"},
    {"name": "३२", "value": "32"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},

    // {"name": "९", "value": "9"},
  ];

  formPart() {
    return userdata != null
        ? FormBuilder(
            key: _fbKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: name,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    // initialValue: '${userdata['name']}',
                    decoration: _decoration('NAME (English)'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          CustomRegexPattern.englishInput),
                    ],
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[\u0900-\u097F-/ ]+")),
                    ],
                    controller: name_np,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    // initialValue: '${userdata['name']}',

                    decoration: _decoration('नाम (नेपालीमा)'),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.home, color: primary),
                  title: new TextFormField(
                      controller: address,
                      // initialValue: ' ${userdata['address']}',
                      validator: FormBuilderValidators.required(context,
                          errorText: 'required_field'.tr),
                      decoration: _decoration('addressNAME'.tr)),
                ),
                new ListTile(
                  leading: Icon(
                    Icons.email,
                    color: primary,
                  ),
                  title: new TextFormField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'required_field'.tr),
                      FormBuilderValidators.email(context,
                          errorText: 'email_validate'.tr),
                    ]),
                    controller: email,

                    // initialValue: '${userdata['email']}',
                    decoration: _decoration('EMAIL'.tr),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.phone, color: primary),
                  title: new TextFormField(
                    controller: mobile,
                    // initialValue: ' ${userdata['mobile']}',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'required_field'.tr),
                      FormBuilderValidators.minLength(
                        context,
                        10,
                        errorText: 'minLength'.tr,
                      ),
                      FormBuilderValidators.maxLength(
                        context,
                        10,
                        errorText: 'maxLength'.tr,
                      ),
                    ]),
                    decoration: _decoration('MOBILE-NUM'.tr),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButtonFormField(
                        decoration: _currentGender != null
                            ? _decoration('$_currentGender'.tr)
                            : _decoration('GENDER'.tr),
                        isExpanded: true,
                        items: Constants.gender.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!),
                            );
                          },
                        ).toList(),
                        // value: "${userdata["gender"]}".tr,
                        onChanged: (value) {
                          setState(() {
                            _currentGender = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.attribution_outlined,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                //Checkbox
                // Row(children: [
                //   Padding(
                //     padding: const EdgeInsets.only(top: 0, left: 8),
                //     child: Checkbox(
                //         value: userdata['woda_id'] != null ? true : false,
                //         onChanged: (value) {
                //           setState(() {
                //             checkboxValue = !checkboxValue;
                //             value = checkboxValue;
                //           });
                //         }),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 12),
                //     child: Text('nibaasi'.tr),
                //   ),
                // ]),

                checkboxValue == true
                    ? Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 44.0),
                            margin: EdgeInsets.only(
                                top: 5.0, left: 28.0, right: 16.0),
                            child: DropdownButtonFormField<int>(
                              menuMaxHeight: 400,
                              decoration: _currentWard != null
                                  ? _decoration(NepaliUnicode.convert(
                                      _currentWard.toString()))
                                  : _decoration('Wardno'.tr),
                              // userdata['ward_id'] != null
                              //     ? _decoration('${userdata['ward_id']}'.tr)
                              //     : userdata['woda_id'] != null
                              //         ? _decoration('${userdata['woda_id']}'.tr)
                              isExpanded: true,
                              items: _wards.map(
                                (val) {
                                  //      [
                                  //   DropdownMenuItem(
                                  //     value: 1,
                                  //     child: Text("1"),
                                  //   )

                                  //   //   _wards.map(
                                  //   //   (val) {
                                  //   //     print(val);
                                  //   // return DropdownMenuItem(
                                  //   //   value: val["value"],
                                  //   //   child: Text(val["name"]!),
                                  //   // );
                                  //   //   },
                                  //   // ).toList(),
                                  // ]
                                  // print(val);
                                  return DropdownMenuItem<int>(
                                    value: int.parse(val["value"]!),
                                    child: Text(val["name"]!),
                                  );
                                },
                              ).toList(),
                              // value: userdata['woda_id'] != null &&
                              //         userdata['woda_id'] != 0
                              //     ? userdata['woda_id']
                              //     : null,
                              onChanged: (value) {
                                setState(() {
                                  _currentWard = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: Icon(
                              Icons.location_city,
                              color: primary,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        : Container();
  }

  XFile? imagefile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          elevation: 0,
          actions: [],
          toolbarHeight: 0,
        ),
        body: DoubleBack(
          background: background,
          textStyle: TextStyle(color: Colors.black),
          message: "Press back again to close",
          child: SingleChildScrollView(
            child: Container(
              child: Stack(
                //overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          secondary,
                          primary,
                        ],
                      ),
                    ),
                    height: 240,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('profile'.tr,
                                  style: TextStyle(color: white, fontSize: 22)),
                              // InkWell(
                              //     onTap: () {
                              //       Get.to(Receipt());
                              //     },
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text('receipt'.tr,
                              //             style: TextStyle(
                              //                 color: white, fontSize: 16)),
                              //         SizedBox(width: 10),
                              //         Icon(Icons.file_copy,
                              //             color: white, size: 22),
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Stack(
                                  // fit: StackFit.loose,
                                  children: <Widget>[
                                    imagefile == null
                                        ? new Container(
                                            width: 90.0,
                                            height: 90.0,
                                            child: userdata != null
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        '${userdata['user_img']}',
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: Image.asset(
                                                          'assets/images/dummyuser.png',
                                                          fit: BoxFit.contain),
                                                    ),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage:
                                                          imageProvider,
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            tertiary,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          )
                                        : Container(
                                            width: 90.0,
                                            height: 90.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.file(
                                                File(imagefile!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          ImageHandler(
                                              onFilePickSuccess: (file) async {
                                            bool isSuccess =
                                                await profileupdateimage(file);
                                            if (isSuccess) {
                                              setState(() {
                                                imagefile = file;
                                              });
                                            }
                                          }).getImage(context);
                                        },
                                        child: new CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: primary,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      userdata != null
                                          ? Text(
                                              // 'NAME'.tr +
                                              //     ' : ' +
                                              '${userdata['name']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                height: 1.5,
                                                // fontWeight: FontWeight.bold
                                              ),
                                            )
                                          : Container(),
                                      userdata != null
                                          ? Text(
                                              // 'MOBILE-NUM'.tr +
                                              //     ' : ' +
                                              '${userdata['mobile']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1.5,
                                              ),
                                            )
                                          : Container(),
                                      userdata?['woda_id'] != null
                                          ? Text(
                                              'ward'.tr +
                                                  ' : ' +
                                                  ' ${NepaliUnicode.convert(userdata['woda_id'].toString())}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1.5,
                                              ),
                                            )
                                          : userdata?['ward_id'] != null
                                              ? Text(
                                                  'ward'.tr +
                                                      ' : ' +
                                                      ' ${NepaliUnicode.convert(userdata['ward_id'].toString())}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    height: 1.5,
                                                  ),
                                                )
                                              : Container(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: tertiary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            child: Text('my_application'.tr,
                                                style: TextStyle(
                                                    color:
                                                        textPrimaryLightColor)),
                                            onPressed: () {
                                              Get.to(SecondProfile());
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: tertiary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(20)),
                                            child: Text('receipt'.tr,
                                                style: TextStyle(
                                                    color:
                                                        textPrimaryLightColor)),
                                            onPressed: () {
                                              Get.to(Get.to(Receipt()));
                                            },
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 30.0, vertical: 8.0),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             new Stack(
                        //               // fit: StackFit.loose,
                        //               children: <Widget>[
                        //                 imagefile == null
                        //                     ? new Container(
                        //                         width: 90.0,
                        //                         height: 90.0,
                        //                         child: userdata != null
                        //                             ? CachedNetworkImage(
                        //                                 imageUrl:
                        //                                     '${userdata['user_img']}',
                        //                                 errorWidget:
                        //                                     (context, url, error) =>
                        //                                         ClipRRect(
                        //                                   borderRadius:
                        //                                       BorderRadius.circular(
                        //                                           50.0),
                        //                                   child: Image.asset(
                        //                                       'assets/images/dummyuser.png',
                        //                                       fit: BoxFit.contain),
                        //                                 ),
                        //                                 imageBuilder: (context,
                        //                                         imageProvider) =>
                        //                                     CircleAvatar(
                        //                                   radius: 35,
                        //                                   backgroundImage:
                        //                                       imageProvider,
                        //                                 ),
                        //                                 placeholder:
                        //                                     (context, url) =>
                        //                                         Center(
                        //                                   child:
                        //                                       CircularProgressIndicator(
                        //                                     backgroundColor:
                        //                                         tertiary,
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                             : Container(),
                        //                       )
                        //                     : Container(
                        //                         width: 90.0,
                        //                         height: 90.0,
                        //                         child: ClipRRect(
                        //                           borderRadius:
                        //                               BorderRadius.circular(50.0),
                        //                           child: Image.file(
                        //                             File(imagefile!.path),
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                 Positioned(
                        //                   bottom: 0,
                        //                   right: 0,
                        //                   child: GestureDetector(
                        //                     onTap: () {
                        //                       ImageHandler(
                        //                           onFilePickSuccess: (file) async {
                        //                         bool isSuccess =
                        //                             await profileupdateimage(file);
                        //                         if (isSuccess) {
                        //                           setState(() {
                        //                             imagefile = file;
                        //                           });
                        //                         }
                        //                       }).getImage(context);
                        //                     },
                        //                     child: new CircleAvatar(
                        //                       radius: 15,
                        //                       backgroundColor: Colors.white,
                        //                       child: new Icon(
                        //                         Icons.camera_alt,
                        //                         color: primary,
                        //                         size: 18,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),

                        //           ]),

                        //           Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.center,
                        //             children: <Widget>[
                        //               userdata != null
                        //                   ? Text(
                        //                       // 'NAME'.tr +
                        //                       //     ' : ' +
                        //                       '${userdata['name']}',
                        //                       style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 20,
                        //                         height: 1.5,
                        //                         // fontWeight: FontWeight.bold
                        //                       ),
                        //                     )
                        //                   : Container(),
                        //               userdata != null
                        //                   ? Text(
                        //                       // 'MOBILE-NUM'.tr +
                        //                       //     ' : ' +
                        //                       ' ${userdata['mobile']}',
                        //                       style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 16,
                        //                         height: 1.5,
                        //                       ),
                        //                     )
                        //                   : Container(),
                        //               userdata?['woda_id'] != null
                        //                   ? Text(
                        //                       'ward'.tr +
                        //                           ' : ' +
                        //                           ' ${NepaliUnicode.convert(userdata['woda_id'].toString())}',
                        //                       style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 16,
                        //                         height: 1.5,
                        //                       ),
                        //                     )
                        //                   : userdata?['ward_id'] != null
                        //                       ? Text(
                        //                           'ward'.tr +
                        //                               ' : ' +
                        //                               ' ${NepaliUnicode.convert(userdata['ward_id'].toString())}',
                        //                           style: TextStyle(
                        //                             color: Colors.white,
                        //                             fontSize: 16,
                        //                             height: 1.5,
                        //                           ),
                        //                         )
                        //                       : Container(),
                        //                       SizedBox(height: 12,),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [

                        //                   ElevatedButton(
                        //                     style: ElevatedButton.styleFrom(
                        //                       backgroundColor: tertiary,
                        //                       shape: RoundedRectangleBorder(
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   20)),
                        //                     ),
                        //                     child: Text('my_application'.tr,
                        //                         style: TextStyle(
                        //                             color:
                        //                                 textPrimaryLightColor)),
                        //                     onPressed: () {
                        //                       Get.to(SecondProfile());
                        //                     },
                        //                   ),
                        //                   SizedBox(width: 10),
                        //                   ElevatedButton(
                        //                     style: ElevatedButton.styleFrom(
                        //                       backgroundColor: tertiary,
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius:
                        //                             BorderRadius.circular(20),
                        //                       ),
                        //                     ),
                        //                     child: Text('receipt'.tr,
                        //                         style: TextStyle(
                        //                             color:
                        //                                 textPrimaryLightColor)),
                        //                     onPressed: () {
                        //                       Get.to(Get.to(Receipt()));
                        //                     },
                        //                   ),
                        //                 ],
                        //               ),
                        //             ]),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 210.0),
                      alignment: Alignment.topLeft,
                      //height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: shadowColor,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text('update'.tr,
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          Divider(),
                          Container(
                              decoration: new BoxDecoration(
                                border: Border.all(color: primary),
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('info_safe'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: primary, fontSize: 16)),
                              )),
                          SizedBox(height: 10),
                          formPart(),
                          SizedBox(
                            height: 12,
                          ),
                          new ElevatedButton(
                            child: new Text('update'.tr,
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tertiary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(20)),
                            // disabledTextColor: Colors.white,
                            onPressed: () {
                              updateuserdata();
                            },
                          ),

                          //!DELETE PROFILE
                          if (Platform.isIOS)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Delete Profile'.tr,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return ProfileConfirmDialog(
                                              title: "Confirm".tr,
                                              description:
                                                  'Please type the following numbers'
                                                      .tr,
                                              requireDigitFillUp: true,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              onConfirm: () async {
                                                //
                                                EasyLoading.show(
                                                    status:
                                                        'Please wait...'.tr);
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                String devicetoken = pref
                                                    .getString('devicetoken')!;
                                                var data = {
                                                  'gcm_token': '${devicetoken}'
                                                };
                                                logoutApi(data).then(
                                                  (data) {
                                                    if (data == true) {
                                                      //
                                                      EasyLoading.dismiss();
                                                      storage.clear();
                                                      sharedprefdelete('a');
                                                      setState(() {});

                                                      Navigator.pop(context);
                                                      Get.off(
                                                        BottomNavBar(),
                                                        preventDuplicates:
                                                            false,
                                                      );
                                                    } else {
                                                      //
                                                      EasyLoading.dismiss();
                                                      EasyLoading.showError(
                                                        'server_connection_error'
                                                            .tr,
                                                      );
                                                    }
                                                    EasyLoading.showSuccess(
                                                      'Your account has been deleted',
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
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

  _decoration(data) {
    return InputDecoration(
      // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
      contentPadding:
          new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      fillColor: background, filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      // prefixIcon: Icon(Icons.lock, color: primary),
      hintText: data,
    );
  }

  updateuserdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    _fbKey.currentState?.save();
    if (_fbKey.currentState?.validate() == true) {
      var a = {
        "name": name.text,
        "name_np": name_np.text,
        "email": email.text,
        "mobile": mobile.text,
        "address": address.text,
        "gender": _currentGender,
        "woda_id": _currentWard
      };
      profileupdateApi(a).then((value) => {
            if (value['success'] == true)
              {
                //storage.setItem('user', json.encode(value['data'])),
                pref.setString('user', json.encode(value['data'])),
                EasyLoading.showInfo('तपाईंको जानकारी अद्यावधिक भयो '),
                Get.offAll(BottomNavBar()),
                // Get.off(() => BottomNavBar(), preventDuplicates: false)
              }
          });
    }
  }

  sharedprefdelete(page) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String devicetoken = pref.getString('devicetoken')!;
    pref.clear();
    pref.setBool("onBoardingCompleted", true);
    pref.remove('login');
    pref.setString('devicetoken', devicetoken);
    setState(() {});

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => BottomNavBar()),
    // );
  }
}

class BlogImage {
  const BlogImage({
    @required this.storagePath,
    @required this.originalUrl,
    @required this.bucketName,
    this.id,
  });

  final String? bucketName;
  final String? id;
  final String? originalUrl;
  final String? storagePath;

  static String get collectionPath => "blogImages";

  create() {}

  // static Future<BlogImage>? fromUrl(String url) async {}
}
