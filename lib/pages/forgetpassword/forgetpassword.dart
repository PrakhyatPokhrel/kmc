import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';

import '../../config/Apiconnectservices.dart';
import '../../config/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var value = 1;
  dynamic userid;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _setpasword = GlobalKey<FormBuilderState>();
  var phone = TextEditingController();
  var otp = TextEditingController();
  var passowrd = TextEditingController();
  var cpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('थप सुरक्षाको लागि कृपया आफ्नो पासवर्ड परिवर्तन गर्नुहोस्',
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              SizedBox(
                height: 20,
              ),
              new ListTile(
                title: Text('enter_mobile'.tr,
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold)),
              ),
              new ListTile(
                title: new TextFormField(
                  controller: phone,
                  validator: FormBuilderValidators.required(context,
                      errorText: 'required_field'.tr),
                  decoration: new InputDecoration(
                    hintText: 'mobilenumber'.tr,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(primary),
                  ),
                  child: Text('SEND'.tr,
                      style: TextStyle(color: textPrimaryLightColor)),
                  onPressed: () {
                    // if (_forgotKey.currentState.validate()) {
                    //   _forgotKey.currentState.save();
                    // }

                    EasyLoading.show(status: 'Please wait...'.tr);
                    mobilenumsentforotp();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
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
                value == 1
                    ? FormBuilder(
                        key: _fbKey,
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
                                controller: phone,
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: 'required_field'.tr),
                                decoration: new InputDecoration(
                                  hintText: 'mobilenumber'.tr,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primary),
                                ),
                                child: Text('SEND'.tr,
                                    style: TextStyle(
                                        color: textPrimaryLightColor)),
                                onPressed: () {
                                  // if (_forgotKey.currentState.validate()) {
                                  //   _forgotKey.currentState.save();
                                  // }
                                  Get.back();
                                  EasyLoading.show(status: 'Please wait...'.tr);
                                  mobilenumsentforotp();
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : value == 2
                        ? FormBuilder(
                            key: _fbKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  title: Text('msg_ask_otp'.tr,
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold)),
                                ),
                                new ListTile(
                                  title: new TextFormField(
                                    controller: otp,
                                    validator: FormBuilderValidators.required(
                                        context,
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
                                      backgroundColor:
                                          WidgetStateProperty.all(primary),
                                    ),
                                    child: Text('SEND'.tr,
                                        style: TextStyle(
                                            color: textPrimaryLightColor)),
                                    onPressed: () {
                                      Get.back();
                                      EasyLoading.show(
                                          status: 'Please wait...'.tr);

                                      verifyotp();
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        : value == 3
                            ? FormBuilder(
                                key: _setpasword,
                                autovalidateMode: AutovalidateMode.always,
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
                                        controller: passowrd,
                                        obscureText: true,
                                        validator:
                                            FormBuilderValidators.required(
                                                context,
                                                errorText: 'required_field'.tr),
                                        decoration: new InputDecoration(
                                            hintText: 'set_password'.tr),
                                      ),
                                    ),
                                    new ListTile(
                                      title: new TextFormField(
                                        controller: cpassword,
                                        obscureText: true,
                                        validator: (val) {
                                          if (val!.isEmpty)
                                            return "password_required".tr;
                                          if (val != passowrd.text)
                                            return "password_match".tr;
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
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  primary),
                                        ),
                                        child: Text('SEND'.tr,
                                            style: TextStyle(
                                                color: textPrimaryLightColor)),
                                        onPressed: () {
                                          Get.back();
                                          EasyLoading.show(
                                              status: 'Please wait...'.tr);

                                          setpassword();
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

  setpassword() {
    _setpasword.currentState?.save();
    var data = {
      "phone": phone.text,
      "password": this.passowrd.text,
      "password_confirmation": this.cpassword.text
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
                },
                Get.off(Login())
              }
            else
              {
                EasyLoading.dismiss(),
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('server_error'.tr))),
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
                EasyLoading.dismiss(),
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP_does_not_match'.tr))),
                forgotPasswordPopup()
              }
          });
    }
  }

  mobilenumsentforotp() {
    _fbKey.currentState?.save();
    var a = {
      'mobile': phone.text,
    };

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
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('mobile_num_not_found'.tr))),
              forgotPasswordPopup()
            }
        });
  }
}
