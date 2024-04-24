import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kmc/Auth/getghardhuri.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';

class Ghardhuri extends StatefulWidget {
  @override
  _GhardhuriState createState() => _GhardhuriState();
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

final LocalStorage storage = new LocalStorage('changu');
// final LocalStorage storage = new LocalStorage('bagchaur');

class _GhardhuriState extends State<Ghardhuri> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _passwordset =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _enterpassword =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _enterotp = GlobalKey<FormBuilderState>();

  Timer? _timer;
  int _start = 180;
  bool? resend;

  resendStatus() {
    if (_start == 0) {
      resend = true;
    } else {
      resend = false;
    }
  }

  onResendPressed() {
    _start = 180;
    resend = false;
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            resend = true;
          });
        } else if (_start != 0) {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  resendOTP() {
    otp = {
      "user_id": '${indivisualapiresponse['id']}',
    };
    askOtp(otp);
  }

  @override
  void dispose() {
    // Never called
    _timer?.cancel();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  dynamic indexvalue = 0;
  var householdnumber = TextEditingController();
  bool? familymemberdata = false;
  bool? setpasswordcondition = false;
  bool? enterpassword = false;
  dynamic familyheaddata;
  dynamic sp_token_num;
  dynamic familymember = [];
  int? val = -1;
  bool readonly = false;
  var value = 2;
  dynamic userid;
  var phone = TextEditingController();
  var enterotp = TextEditingController();
  var mobilenumber = TextEditingController();

  var set_password = TextEditingController();
  var mobile = TextEditingController();
  var re_password = TextEditingController();
  var otpcode = TextEditingController();

  var indivisualapiresponse;

  BestTutorSite _site = BestTutorSite.javatpoint;
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  firstPart(),
                  SizedBox(height: 16),
                  nameListPart(),
                  SizedBox(height: 16),
                  setpasswordPart(),
                  SizedBox(height: 16),
                  typepasswordPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  firstPart() {
    return SizedBox(
      width: double.infinity,
      height: Get.height * 0.5,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
          margin: EdgeInsets.all(0),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _fbKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: Text('ghardhuri_token'.tr,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, height: 1.5, color: text)),
                  ),
                  new ListTile(
                    leading: Icon(Icons.home, color: primary, size: 30),
                    title: new TextFormField(
                      controller: householdnumber,
                      readOnly: readonly,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.required(context,
                          errorText: 'required_field'.tr),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(Get.width, 50)),
                          backgroundColor: MaterialStateProperty.all(tertiary),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 35)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      child: Text('SEND'.tr,
                          style: TextStyle(
                              color: textPrimaryLightColor, fontSize: 20)),
                      onPressed: () {
                        householdcheckapi(); // Get.back();
                      },
                    ),
                  ),
                  Center(
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Text(
                        'forgot_ghardhuri'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: text, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(Get.width, 50)),
                          backgroundColor: MaterialStateProperty.all(tertiary),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 35)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      child: Text('get_token'.tr,
                          style: TextStyle(
                              color: textPrimaryLightColor, fontSize: 20)),
                      onPressed: () {
                        // not_available_Alert(context);
                        Get.to(GetGhardhuri());
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  nameListPart() {
    return familymemberdata == true
        ? SizedBox(
            width: double.infinity,
            height: familymember.length == 0
                ? 80 + Get.height * 0.20
                : 80 + Get.height * 0.215 * familymember.length,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('which_member'.tr,
                            style: TextStyle(fontSize: 16, height: 1.5)),
                        ListTile(
                          title: familyheaddata['sp_hhh_middle_name'] == null
                              ? Text(nameBlur(
                                      '${familyheaddata['sp_hhh_first_name']} ' +
                                          '${familyheaddata['sp_hhh_last_name']} ')

                                  // '${familyheaddata['respondent_name']}'
                                  //   .replaceRange(
                                  //       1,
                                  //       familyheaddata['respondent_name']
                                  //               .indexOf(' ') -
                                  //           1,
                                  //       familyheaddata['respondent_name']
                                  //               .indexOf(' ') *
                                  //           "*"))
                                  // '' +
                                  // '${familyheaddata['sp_hhh_middle_name']} ' +
                                  // '' +
                                  // '${familyheaddata['sp_hhh_last_name']}'
                                  )
                              : Text(nameBlur(
                                  '${familyheaddata['sp_hhh_first_name']} ' +
                                      '${familyheaddata['sp_hhh_middle_name']} ' +
                                      '${familyheaddata['sp_hhh_last_name']} ')),
                          // '' +
                          // '${familyheaddata['sp_hhh_last_name']}'),
                          leading: Radio(
                            value: 10,
                            toggleable: true,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value as int?;
                              });
                            },
                          ),
                        ),
                        familymember != null
                            ? Container(
                                height: Get.height * familymember.length * 0.08,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: familymember.length,
                                  itemBuilder: (ctx, index) =>
                                      RadioListTile<dynamic>(
                                    title: familymember[index]
                                                ['sp_fm_middle_name'] !=
                                            null
                                        ? Text(nameBlur(
                                            '${familymember[index]['sp_fm_first_name']} ' +
                                                '${familymember[index]['sp_fm_last_name']} '))
                                        : Text(nameBlur(
                                            '${familymember[index]['sp_fm_first_name']} ' +
                                                '${familymember[index]['sp_fm_last_name']}')),
                                    value: index,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    Size(Get.width, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(tertiary),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            child: Text('SEND'.tr,
                                style: TextStyle(
                                    color: textPrimaryLightColor,
                                    fontSize: 20)),
                            onPressed: () {
                              checkindividualloginstatus();
                            },
                          ),
                        )
                      ],
                    ))))
        : Container();
  }

  setpasswordPart() {
    return setpasswordcondition == true
        ? SizedBox(
            width: double.infinity,
            height: Get.height * 0.6,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FormBuilder(
                      key: _passwordset,
                      child: Column(
                        children: [
                          // new ListTile(
                          //   leading: Icon(Icons.phone, color: primary),
                          //   title: new TextFormField(
                          //     controller: mobile,
                          //     validator:
                          //         FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          //     decoration: new InputDecoration(
                          //       hintText: 'MOBILE-NUM'.tr,
                          //     ),
                          //     keyboardType: TextInputType.phone,
                          //   ),
                          // ),

                          //  Text('set_password'.tr,
                          // style: TextStyle(fontSize: 16, height: 1.5)),

                          new ListTile(
                            leading: Icon(Icons.lock, color: primary, size: 30),
                            title: new TextFormField(
                              controller: set_password,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: FormBuilderValidators.required(context,
                                  errorText: 'required_field'.tr),
                              decoration: new InputDecoration(
                                hintText: 'type_password'.tr,
                              ),
                            ),
                          ),
                          new ListTile(
                            leading: Icon(Icons.lock, color: primary, size: 30),
                            title: new TextFormField(
                              controller: re_password,
                              validator: (val) {
                                if (val!.isEmpty) return 'Empty';
                                if (val != set_password.text)
                                  return 'Not Match';
                                return null;
                              },
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: new InputDecoration(
                                hintText: 're_password'.tr,
                              ),
                            ),
                          ),

                          new ListTile(
                            leading: Icon(Icons.lock, color: primary, size: 30),
                            title: new TextFormField(
                              controller: otpcode,
                              validator: FormBuilderValidators.required(context,
                                  errorText: 'required_field'.tr),
                              // obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: 'OTP Code'.tr,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          resend == true
                              ? GestureDetector(
                                  onTap: () {
                                    onResendPressed();
                                    resendOTP();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Resend OTP".tr,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "remainingtime".tr +
                                      " :" +
                                      " $_start " +
                                      "sec".tr,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: primary,
                                  ),
                                ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(Get.width, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all(tertiary),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(16)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ))),
                              child: Text('SEND'.tr,
                                  style: TextStyle(
                                      color: textPrimaryLightColor,
                                      fontSize: 20)),
                              onPressed: () {
                                // Get.back();
                                setpasswordapicall();
                              },
                            ),
                          )
                        ],
                      ),
                    ))))
        : Container();
  }

  typepasswordPart() {
    return enterpassword == true
        ? SizedBox(
            width: double.infinity,
            height: Get.height * 0.35,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FormBuilder(
                      key: _enterpassword,
                      child: Column(
                        children: [
                          Text('type_password'.tr,
                              style: TextStyle(fontSize: 16, height: 1.5)),
                          new ListTile(
                            leading: Icon(Icons.lock, color: primary, size: 30),
                            title: new TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: set_password,
                              validator: FormBuilderValidators.required(context,
                                  errorText: 'required_field'.tr),
                              decoration: new InputDecoration(
                                hintText: 'PASSWORD'.tr,
                              ),
                            ),
                          ),
                          //Fingerprint
                          // Center(
                          //   heightFactor: 0.8,
                          //   child: FlatButton(
                          //       onPressed: () {},
                          //       child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(10),
                          //               child: Icon(
                          //                 Icons.fingerprint,
                          //                 size: 30,
                          //                 color: primary,
                          //               ),
                          //             ),
                          //             Text('fingerprint_login'.tr,
                          //                 style: TextStyle(
                          //                     color: primary,
                          //                     fontSize: 14,
                          //                     height: 1)),
                          //           ])),
                          // ),
                          Center(
                            heightFactor: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                mobilenumsentforotp();
                              },
                              child: Text(
                                'forgot_password'.tr,
                                style: TextStyle(color: primary, fontSize: 14),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(Get.width, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all(tertiary),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(16)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ))),
                              child: Text('SEND'.tr,
                                  style: TextStyle(
                                      color: textPrimaryLightColor,
                                      fontSize: 20)),
                              onPressed: () {
                                // Get.back();
                                loginapifromhousehold();
                              },
                            ),
                          )
                        ],
                      ),
                    ))))
        : Container();
  }

  householdcheckapi() {
    _fbKey.currentState?.save();
    final data = {"household_no": householdnumber.text};
    final mobile = {"mobile_number": householdnumber.text};
    EasyLoading.show(status: 'Please wait...'.tr);
    if (_fbKey.currentState?.validate() == true) {
      // if (householdnumber.text.length == 10) {
      //   householdmobileapicheck(mobile).then((res) => {
      //         setState(() {
      //           familyheaddata = res['data']['household_data'];

      //           familymember = res['data']['family_data'];
      //           sp_token_num = res['data']['household_data']['sp_token_num'];
      //           print("sp token: $sp_token_num");

      //           familymemberdata = true;
      //           readonly = true;
      //         }),
      //         EasyLoading.dismiss()
      //       });
      // } else {
      householdapicheck(data).then((res) => {
            setState(() {
              familyheaddata = res['data'];
              familymember = res['family_data'] ?? [];
              familymemberdata = true;
              readonly = true;
            }),
            EasyLoading.dismiss()
          });
      // }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Enter_household_number'.tr);
    }
  }

  var respondent_id;
  var otp;
  var passdata;
  checkindividualloginstatus() {
    EasyLoading.show(status: 'Please wait...'.tr);

    _fbKey.currentState?.save();
    if (val == 10) {
      var data = {
        "household_token": householdnumber.text,
        'household_head': 1,
        'respondent_id': familyheaddata['household_id']
      };

      householdindividuallogincheck(data).then((res) => {
            setState(() {
              respondent_id = familyheaddata['id'];
              indivisualapiresponse = res['data'];
            }),
            if (res['status'] == "user_created")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                askOtp(otp),
                startTimer(),
                setState(() {
                  familymemberdata = false;
                  setpasswordcondition = true;
                }),
              }
            else if (res['status'] == "not_activated")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                askOtp(otp),
                startTimer(),
                setState(() {
                  familymemberdata = false;
                  setpasswordcondition = true;
                }),
              }
            else if (res['status'] == "not_updated")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                askOtp(otp),
                startTimer(),
                setState(() {
                  familymemberdata = false;
                  setpasswordcondition = true;
                }),
              }
            else if (res['status'] == "activated")
              {
                setState(() {
                  familymemberdata = false;
                  enterpassword = true;
                }),
              },
            EasyLoading.dismiss()
          });
    } else {
      var data = {
        "household_token": householdnumber.text,
        'household_head': 0,
        'respondent_id': familymember[val]['id']
      };

      householdindividuallogincheck(data).then((res) => {
            setState(() {
              respondent_id = familymember[val]['id'];

              indivisualapiresponse = res['data'];
            }),
            if (res['data']['status'] == "user_created")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                askOtp(otp).then((value) => {
                      // this.usercreated = false;
                      // this.passwordenter = false;

                      setState(() {
                        familymemberdata = false;
                        setpasswordcondition = true;
                      }),
                      // Get.to(OTPScreenhousehold(data: passdata))
                    }),
                startTimer(),
              }
            else if (res['data']['status'] == "not_activated")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                startTimer(),
                askOtp(otp).then((value) => {
                      // this.usercreated = false;
                      // this.passwordenter = false;

                      setState(() {
                        familymemberdata = false;
                        setpasswordcondition = true;
                      }),
                      // Get.to(OTPScreenhousehold(data: passdata))
                    })
              }
            else if (res['data']['status'] == "activated")
              {
                setState(() {
                  familymemberdata = false;
                  enterpassword = true;
                }),
              }
            else if (res['data']['status'] == "not_updated")
              {
                otp = {
                  "user_id": '${indivisualapiresponse['id']}',
                },
                askOtp(otp).then((value) => {
                      // this.usercreated = false;
                      // this.passwordenter = false;

                      setState(() {
                        familymemberdata = false;
                        setpasswordcondition = true;
                      }),
                      // Get.to(OTPScreenhousehold(data: passdata))
                    }),
                setState(() {
                  familymemberdata = false;
                  setpasswordcondition = true;
                }),
              }
            else if (res['data']['status'] == "no_mobile")
              {
                EasyLoading.showError(res['data']['message'],
                    duration: Duration(seconds: 5)),
              },
            EasyLoading.dismiss()
          });
    }
  }

  setpasswordapicall() {
    _passwordset.currentState?.save();
    var data = {
      "user_id": indivisualapiresponse['id'],
      "password": set_password.text,
      "mobile": indivisualapiresponse['mobile'],
      "otp_code": otpcode.text,
    };
    EasyLoading.show(status: 'Please wait...'.tr);

    if (_passwordset.currentState?.validate() == true) {
      setpasswordapi(data).then((res) => {
            signuplogin()
            // otp = {
            //   "user_id": indivisualapiresponse['id'],
            // },

            // EasyLoading.dismiss(),
            // _passwordset.currentState.save(),
            // askOtp(otp).then((value) => {
            //       // this.usercreated = false;
            //       // this.passwordenter = false;

            //       passdata = {
            //         'phone': mobile.text,
            //         'user_id': '${indivisualapiresponse['id']}',
            //         "page": "ghardhuri",
            //         'household_head': indivisualapiresponse['household_head'],
            //         'respondent_id': respondent_id,
            //         'household_token': indivisualapiresponse['household_token'],
            //         'password': set_password.text
            //       },
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   OTPScreenhousehold(data: passdata)))
            //     })
          });
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Enter_household_number'.tr);
    }
  }

  loginapifromhousehold() async {
    _enterpassword.currentState?.save();

    EasyLoading.show(status: 'Please wait...'.tr);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var data = {'email': '${emailphone.text}', 'password': '${password.text}'};
    var data = {
      'household_head': indivisualapiresponse['household_head'],
      'respondent_id': indivisualapiresponse['respondent_id'],
      'household_token': indivisualapiresponse['household_token'],
      'password': set_password.text
    };

    // var data = {'email': 'mishrasomp@gmail.com', 'password': 'Sm@rtchangu#123'};
    // var data = {'email': 'binab12@smartpalika.org ', 'password': 'binab#so122'};
    loginApihousehold(data).then((value) => {
          // //storage.setItem('user', json.encode(value['data'])),
          prefs.setString('user', json.encode(value['data'])),
          prefs.setString('role', json.encode(value['role'])),
          prefs.setString('role_desig', json.encode(value['role_desig'])),
          prefs.setBool('login', true),
          prefs.setString('token', value['token']),
          checkmayorAPi(),
          checkvicemayorAPi(),
          checksuchanaAPi(),
          Future.delayed(Duration(milliseconds: 5000), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => new BottomNavBar()),
                (route) => false);
            tokenregisterApi();

            EasyLoading.dismiss();
          })
        });
  }

  forgotPasswordPopup() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: primary,
                    ),
                  ),
                ),
//
// Mobile Number for forgot password
//
//
                value == 2
                    ?
//
// OTP for forgot password
//
                    FormBuilder(
                        key: _enterotp,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              title: Text('enter_mobile'.tr,
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold)),
                            ),
                            new ListTile(
                              title: new TextFormField(
                                controller: mobilenumber,
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: 'required_field'.tr),
                                decoration: new InputDecoration(
                                  hintText: 'MOBILE-NUM'.tr,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primary),
                                ),
                                child: Text('SEND'.tr,
                                    style: TextStyle(
                                        color: textPrimaryLightColor)),
                                onPressed: () {
                                  Get.back();

                                  getoptApicall();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : value == 3
                        ?

//
// Set new password
//
                        FormBuilder(
                            key: _passwordset,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  title: Text('change_password'.tr,
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold)),
                                ),
                                new ListTile(
                                  title: new TextFormField(
                                    controller: set_password,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    validator: FormBuilderValidators.required(
                                        context,
                                        errorText: 'password_required'.tr),
                                    decoration: new InputDecoration(
                                        hintText: 'set_password'.tr),
                                  ),
                                ),
                                new ListTile(
                                  title: new TextFormField(
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: re_password,
                                    validator: (val) {
                                      if (val!.isEmpty)
                                        return 'password_required'.tr;
                                      if (val != re_password.text)
                                        return 'Not Match';
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: 'CONFIRMPASSWORD'.tr,
                                    ),
                                  ),
                                ),
                                new ListTile(
                                  title: new TextFormField(
                                    controller: otpcode,
                                    validator: FormBuilderValidators.required(
                                        context,
                                        errorText: 'required_field'.tr),
                                    // obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      hintText: 'OTP Code'.tr,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(primary),
                                    ),
                                    child: Text('SEND'.tr,
                                        style: TextStyle(
                                            color: textPrimaryLightColor)),
                                    onPressed: () {
                                      passwordset();
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                // errorAlert('message')
              ],
            ),
          );
        });
  }

  final errorkey = GlobalKey<FormState>();

  errorAlert(message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(key: errorkey, content: Text(message), actions: [
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: primary,
                ),
              ),
            ),
          ]);
        });
  }

  mobilenumsentforotp() {
    setState(() {
      value = 2;
      forgotPasswordPopup();
    });
    // if (this._fbKey.currentState.validate() == true) {
    //   askOtp(otp).then((res) => {
    //         if (res["status"] == true)
    //           {
    //             {
    //               setState(() {
    //                 value = 2;
    //                 forgotPasswordPopup();
    //               })
    //             }
    //           }
    //         else
    //           {
    //             ScaffoldMessenger.of(context)
    //                 .showSnackBar(SnackBar(content: Text('${res['message']}'))),
    //             mobilenumsentforotp()
    //           }
    //       });
    // }
  }

  getoptApicall() {
    _enterotp.currentState?.save();
    var a = {
      "mobile": mobilenumber.text,
      "user_id": '${indivisualapiresponse['id']}',
    };
    if (this._fbKey.currentState?.validate() == true) {
      forgotPasswordotpAPi(a).then((res) => {
            if (res["status"] == true)
              {
                {
                  setState(() {
                    value = 3;
                    forgotPasswordPopup();
                  })
                }
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP_does_not_match'.tr))),
                forgotPasswordPopup()
              }
          });
    }
  }

  passwordset() {
    _passwordset.currentState?.save();
    var data = {
      "user_id": '${indivisualapiresponse['id']}',
      "password": set_password.text,
      "otp_code": otpcode.text,
    };

    if (this._passwordset.currentState?.validate() == true) {
      EasyLoading.show(status: 'Please wait...'.tr);

      householdpasswordset(data).then((res) => {
            EasyLoading.dismiss(),
            if (res["status"] == true)
              {
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('पासवर्ड सफलतापूर्वक परिवर्तन भयो..... '))),
                  setState(() {
                    value = 2;
                    Get.back();
                  })
                }
              }
            else
              {
                EasyLoading.showError(res['message']),
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Internal Server Error '))),
              }
          });
    }
  }

  nameBlur(name) {
    int firstSpace = name.indexOf(" "); // detect the first space character
    String firstName = name.substring(
        0, firstSpace); // get everything upto the first space character
    String lastName = name
        .substring(firstSpace)
        .trim(); //get everything after the first space character

    if (firstName.length <= 2) {
      String firstSub = firstName.substring(1, firstName.length - 0);
      firstName = firstName.replaceRange(
          1, firstName.length - 0, "*" * firstSub.length);

      return (firstName + ' ' + lastName);
    } else {
      String firstSub = firstName.substring(1, firstName.length - 2);
      firstName = firstName.replaceRange(
          1, firstName.length - 2, "*" * firstSub.length);
      // lastName =
      //     lastName.replaceRange(1, lastName.length - 2, "*" * lastSub.length);

      return (firstName + ' ' + lastName);
    }
  }

  signuplogin() async {
    // _enterpassword.currentState.save();

    EasyLoading.show(status: 'Please wait...'.tr);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var data = {'email': '${emailphone.text}', 'password': '${password.text}'};
    var data = {
      'household_head': indivisualapiresponse['household_head'],
      'respondent_id': indivisualapiresponse['respondent_id'],
      'household_token': indivisualapiresponse['household_token'],
      'password': set_password.text
    };

    // var data = {'email': 'mishrasomp@gmail.com', 'password': 'Sm@rtchangu#123'};
    // var data = {'email': 'binab12@smartpalika.org ', 'password': 'binab#so122'};
    loginApihousehold(data).then((value) => {
          //ask here
          //storage.setItem('user', json.encode(value['data'])),
          prefs.setString('user', json.encode(value['data'])),
          prefs.setString('role', json.encode(value['role'])),
          prefs.setString('role_desig', json.encode(value['role_desig'])),
          _passwordset.currentState?.save(),
          prefs.setBool('login', true),
          prefs.setString('token', value['token']),
          checkmayorAPi(),
          checkvicemayorAPi(),
          checksuchanaAPi(),
          Future.delayed(Duration(milliseconds: 5000), () {
            tokenregisterApi();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => new BottomNavBar()),
                (route) => false);

            EasyLoading.dismiss();
          })
        });
  }
}
