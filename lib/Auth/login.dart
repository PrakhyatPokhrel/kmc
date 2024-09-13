import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/signup.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/components/custom_api_service.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/home/signUpOTP.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/forgetpassword/forgetpassword.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _forgotKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _setPasswordKey = GlobalKey<FormState>();
  final errorkey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _setpasword = GlobalKey<FormBuilderState>();

  var phone = TextEditingController();
  var otp = TextEditingController();
  var passowrd = TextEditingController();
  var cpassword = TextEditingController();
  bool isObscureText = true;
  //for password reset
  String? reset_token;
  var value = 1;
  dynamic userid;

  var size;
  var emailphone = TextEditingController(text: kDebugMode ? "9860846688" : "");
  var password = TextEditingController(text: kDebugMode ? "admin123" : "");
  final LocalStorage storage = new LocalStorage('changu');

  String _message = "Not Authorized";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void deactivate() {
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: primary,
              size: 28,
            ),
          ),
        ],
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Image.asset(
                'assets/images/header_new_kmc.png',
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   // mini: true,
      //   onPressed: () {
      //     Get.back();
      //     // Get.off(BottomNavBar());
      //   },
      //   child: Icon(Icons.clear, color: primary),
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            // Container(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('LOGIN'.tr,
            //           style: TextStyle(color: primary, fontSize: 22)),
            //       InkWell(
            //           onTap: () {
            //             Navigator.pop(context);
            //           },
            //           child:
            //               Icon(Icons.arrow_back, color: primary, size: 28)),
            //     ],
            //   ),

            //   //  Row(
            //   //   mainAxisAlignment: MainAxisAlignment.center,
            //   //   children: [
            //   //     Expanded(
            //   //       child: Container(
            //   //         child: Image(
            //   //           image: AssetImage('assets/images/header.png'),
            //   //           height: 80,
            //   //           fit: BoxFit.contain,
            //   //         ),
            //   //       ),
            //   //     ),
            //   //     Expanded(
            //   //       child: IconButton(
            //   //         icon: Icon(Icons.arrow_back),
            //   //         onPressed: () {},
            //   //       ),
            //   //     )
            //   //   ],
            //   // ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: upperPart(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: Get.width,
                decoration: new BoxDecoration(
                  border: Border.all(color: primary),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('info_safe'.tr,
                      textAlign: TextAlign.center, style: TextStyle(color: primary, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upperPart() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Email
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: emailphone,
              validator: FormBuilderValidators.required(context),
              decoration: InputDecoration(
                // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
                contentPadding: new EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                prefixIcon: Icon(Icons.mail, color: primary),
                hintText: 'email_mob'.tr,
              ),
            ),
          ),

          //Password
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
              controller: password,
              obscureText: isObscureText,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
                contentPadding: new EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                prefixIcon: Icon(Icons.lock, color: primary),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                    color: primary,
                    size: 26.0,
                  ),
                ),

                hintText: 'PASSWORD'.tr,
              ),
            ),
          ),

          //Fingerprint
          // Center(
          //   heightFactor: 1,
          //   child: FlatButton(
          //       onPressed: () {},
          //       child:
          //           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //         Padding(
          //           padding: const EdgeInsets.all(10),
          //           child: Icon(
          //             Icons.fingerprint,
          //             size: 30,
          //             color: Colors.blue[900],
          //           ),
          //         ),
          //         // SizedBox(width: 10),
          //         Text('fingerprint_login'.tr,
          //             style: TextStyle(
          //                 color: Colors.blue[900], fontSize: 14, height: 1)),
          //       ])
          //       // Text(
          //       //   'fingerprint_login'.tr,
          //       //   style: TextStyle(color: Colors.blue[900], fontSize: 14),
          //       // ),
          //       ),
          // ),

          //Forgot Password
          Center(
            heightFactor: 1,
            child: TextButton(
              onPressed: () {
                forgotPasswordPopup();
              },
              child: Text(
                'forgot_password'.tr,
                style: TextStyle(color: Colors.blue[900], fontSize: 14),
              ),
            ),
          ),

          //Login Button
          Center(
            child: new Container(
              child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      backgroundColor: primary,
                      elevation: 1.0,

                      // disabledColor: statusBar,
                      // disabledTextColor: textPrimaryLightColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        hitloginapi();
                      }
                    },
                    child: Wrap(children: [
                      Text(
                        'LOGIN'.tr,
                        style: TextStyle(fontSize: 16, color: textPrimaryLightColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(Icons.arrow_forward_rounded, color: textPrimaryLightColor),
                      )
                    ]),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
          //     child: Text(
          //       'new_register_text'.tr,
          //       textAlign: TextAlign.center,
          //       //  style: TextStyle(color: textPrimaryColor)
          //     )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "नयाँ प्रयोगकर्ताको लागि",
                style: TextStyle(
                  fontSize: 20,
                  color: primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  //!ASK MANOJ DAI
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Align(
                            alignment: Alignment.center,
                            child: Text('HowToUse'.tr),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 20.0,
                            top: 16.0,
                            right: 20.0,
                            bottom: 8.0,
                          ),
                          content: Text(
                              '१. सर्वप्रथम एप्सको  मेन्युमा गइ लग-इन बटन थिच्नुहोस । \n\n२. नयाँ प्रयोग '
                              'कर्ताको हकमा दर्ता फारम भरी, आफ्नो मोबाइलमा आएको OTP कोड प्रविष्ट '
                              'गर्नुपर्ने हुन्छ ।\n\n३. दर्ता गरी सक्नु भएका प्रयोग कर्ताहरुले आफ्नो इमेल वा मोवाइल नं. तथा पासवर्ड राखी लग-इन गर्नुपर्ने हुन्छ । लग-इन गरिसकेपछी एप्सका अधिकांश सेवा प्रयोगका लागी उपलब्ध हुनेछन । \n\nनोट: परिक्षण काल पश्चात एप्समा लग-इन गर्ने संयन्त्र परिवर्तन भइ घरधुरी टोकन लग-इन व्यवस्ता लागु हुनेछ।'),
                          actionsPadding: const EdgeInsets.only(
                            bottom: 12.0,
                            right: 12.0,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  color: primary,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          //Signup Button
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  backgroundColor: primary,
                  elevation: 1.0,

                  // disabledColor: statusBar,
                  // disabledTextColor: textPrimaryLightColor,
                ),
                child: Wrap(children: [
                  Text(
                    'SIGNUP'.tr,
                    style: TextStyle(fontSize: 16, color: textPrimaryLightColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.arrow_forward_rounded, color: textPrimaryLightColor),
                  )
                ]),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Signup()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text dataText(a) {
    return Text(
      a,
      textAlign: TextAlign.left,
      style: TextStyle(color: textPrimaryColor, fontFamily: 'Mukta', fontSize: 14.0),
    );
  }

  bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
    );
    return emailRegex.hasMatch(input);
  }

  hitloginapi() async {
    _formKey.currentState?.save();
    // var passdata;
    // var otp;
    EasyLoading.show(status: 'Please wait...'.tr);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    //  'email': isEmail(emailphone.text) ? emailphone.text : '',
    var data = {
      isEmail(emailphone.text) ? 'email' : 'phone': emailphone.text,
      'password': '${password.text}',
    };

    loginApi(data).then((value) async {
      if (value["status"] == "user_not_verified") {
        // redirect to otp screen
        var data = {
          'user_id': '${value["data"]["id"]}',
        };
        await resendEmailOtp(data);
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpOTP(
              user_id: value["data"]["id"],
              email: '${emailphone.text}',
              password: '${password.text}',
            ),
          ),
        );
      } else if (value['data'] == false || value['data'] == "false") {
        Get.off(ForgetPassword());
      } else if (value["token"] != null) {
        prefs.setString('user', json.encode(value['data']));
        prefs.setString('role', json.encode(value['role']));
        prefs.setString('role_desig', json.encode(value['role_desig']));
        prefs.setBool('login', true);
        prefs.setString('token', value['token']);
        CustomApiService().setAuthToken();
        checkmayorAPi();
        checkvicemayorAPi();
        checksuchanaAPi();
        Future.delayed(Duration(milliseconds: 5000), () {
          tokenregisterApi();
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => new BottomNavBar()), (route) => false);

          EasyLoading.dismiss();
        });
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Server Busy. Please try again later');
      }
    });
  }

  forgotPasswordPopup() {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close)),
                      backgroundColor: primary,
                    ),
                  ),
                ),
//
// Mobile Number for forgot password
//
//
                value == 1
                    ? FormBuilder(
                        key: _fbKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(Icons.close),
                            //   ),
                            // ),
                            new ListTile(
                              title: Text('enter_mobile'.tr,
                                  style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                            ),

                            TextFormField(
                              controller: phone,
                              validator:
                                  FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
                                contentPadding: new EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent),
                                ),
                                prefixIcon: Icon(Icons.phone, color: primary),

                                hintText: 'mobilenumber'.tr,
                              ),
                            ),
                            // new ListTile(
                            //   title: new TextFormField(
                            //     controller: phone,
                            //     validator:
                            //         FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                            //     decoration: new InputDecoration(
                            //       hintText: 'mobilenumber'.tr,
                            //     ),
                            //     keyboardType: TextInputType.phone,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: ElevatedButton(
                            //     style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(primary),
                            //     ),
                            //     child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor)),
                            //     onPressed: () {
                            //       // if (_forgotKey.currentState.validate()) {
                            //       //   _forgotKey.currentState.save();
                            //       // }
                            //
                            //       if (phone.text.isNotEmpty) {
                            //         Get.back();
                            //         EasyLoading.show(status: 'Please wait...'.tr);
                            //         mobilenumsentforotp();
                            //       }
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                  ),
                                  child: Text('cancel'.tr, style: TextStyle(color: textPrimaryLightColor)),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                SizedBox(width: 12),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(primary),
                                  ),
                                  child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor)),
                                  onPressed: () {
                                    // if (_forgotKey.currentState.validate()) {
                                    //   _forgotKey.currentState.save();
                                    // }

                                    if (phone.text.isNotEmpty) {
                                      Get.back();
                                      EasyLoading.show(status: 'Please wait...'.tr);
                                      mobilenumsentforotp();
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : value == 2
                        ?
//
// OTP for forgot password
//
                        FormBuilder(
                            key: _fbKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  title: Text('msg_ask_otp'.tr,
                                      style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                                ),
                                new ListTile(
                                  title: new TextFormField(
                                    controller: otp,
                                    validator: FormBuilderValidators.required(context,
                                        errorText: 'required_field'.tr),
                                    decoration: new InputDecoration(
                                      hintText: 'पिन नं / PIN No',
                                    ),
                                    keyboardType: TextInputType.phone,
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
                                      if (otp.text.isNotEmpty) {
                                        Get.back();
                                        EasyLoading.show(status: 'Please wait...'.tr);
                                        verifyotp();
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        : value == 3
                            ?

//
// Set new password
//
                            FormBuilder(
                                key: _setpasword,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new ListTile(
                                      title: Text('change_password'.tr,
                                          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                                    ),
                                    new ListTile(
                                      title: new TextFormField(
                                        controller: passowrd,
                                        obscureText: true,
                                        validator: FormBuilderValidators.required(context,
                                            errorText: 'required_field'.tr),
                                        decoration: new InputDecoration(hintText: 'set_password'.tr),
                                      ),
                                    ),
                                    new ListTile(
                                      title: new TextFormField(
                                        controller: cpassword,
                                        obscureText: true,
                                        validator: (val) {
                                          if (val!.isEmpty) return "password_required".tr;
                                          if (val != passowrd.text) return "password_match".tr;
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          hintText: 'CONFIRMPASSWORD'.tr,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(primary),
                                        ),
                                        child:
                                            Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor)),
                                        onPressed: () {
                                          if (passowrd.text.isNotEmpty) {
                                            Get.back();
                                            EasyLoading.show(status: 'Please wait...'.tr);
                                            setpassword();
                                          }
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
    _fbKey.currentState?.save();
    var a = {
      'mobile': phone.text,
    };
    if (this._fbKey.currentState?.validate() == true) {
      forgotPasswordotpAPi(a).then((res) => {
            if (res["status"] == true)
              {
                EasyLoading.dismiss(),
                setState(() {
                  // userid = res['data']['id'];
                  value = 2;
                  forgotPasswordPopup();
                })
              }
            else
              {
                EasyLoading.dismiss(),
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('mobile_num_not_found'.tr))),
                forgotPasswordPopup()
              }
          });
    }
  }

  verifyotp() {
    _fbKey.currentState?.save();

    var a = {"phone": phone.text, "otp_code": otp.text};
    if (this._fbKey.currentState?.validate() == true) {
      verifyotpFogotAPi(a).then((res) => {
            if (res["status"] == true)
              {
                print(res['data']['reset_token']),
                reset_token = res['data']["reset_token"],
                EasyLoading.dismiss(),
                {
                  setState(() {
                    value = 3;
                    forgotPasswordPopup();
                  })
                }
              }
            else
              {
                print(res['message']),
                EasyLoading.dismiss(),
                EasyLoading.showError(res['message']),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']))),
                forgotPasswordPopup()
              }
          });
    }
  }

  passwordset() {
    _fbKey.currentState?.save();
    var data = {
      "phone": phone.text,
      "password": this.passowrd.text,
      "password_confirmation": this.cpassword.text,
      'reset_token': reset_token
    };

    if (this._fbKey.currentState!.validate() == true) {
      passUpdateApi(data).then((res) => {
            if (res["success"] == true)
              {
                {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("change_password_successfully".tr))),
                  setState(() {
                    value = 1;
                  })
                }
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('server_error'.tr))),
              }
          });
    }
  }

  setpassword() {
    _setpasword.currentState?.save();
    var data = {
      "mobile": phone.text,
      "password": this.passowrd.text,
      "password_confirmation": this.cpassword.text,
      'token': reset_token
    };

    if (this._setpasword.currentState!.validate() == true) {
      setpass(data).then((res) => {
            if (res["status"] == true)
              {
                {
                  EasyLoading.dismiss(),
                  EasyLoading.showSuccess('change_password_successfully'.tr),
                  setState(() {
                    value = 1;
                  })
                }
              }
            else
              {
                EasyLoading.dismiss(),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('server_error'.tr))),
              }
          });
    }
  }

  bool _isLoading = false;

//   Future<void> _authenticateMe() async {
// // 8. this method opens a dialog for fingerprint authentication.
// //    we do not need to create a dialog nut it popsup from device natively.
//     bool authenticated = false;
//     try {
//       authenticated = await _localAuthentication.authenticateWithBiometrics(
//         localizedReason: "Authenticate for Testing", // message for dialog
//         useErrorDialogs: true, // show error in dialog
//         stickyAuth: true, // native process
//       );
//       setState(() {
//         _message = authenticated ? "Authorized" : "Not Authorized";
//       });
//     } catch (e) {
//
//     }
//     if (!mounted) return;
//   }
}
