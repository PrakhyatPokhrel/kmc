import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreenhousehold extends StatefulWidget {
  final data;
  OTPScreenhousehold({this.data});
  @override
  _OTPScreenhouseholdState createState() => _OTPScreenhouseholdState();
}

class _OTPScreenhouseholdState extends State<OTPScreenhousehold> {
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  /// get signature code
  _getSignatureCode() async {}

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    var data = {
      'user_id': '${widget.data['user_id']}',
      'otp_code': '$_otpCode',
    };
    verifyhouseholdapi(data).then((value) => {
          if (value['status'] == true)
            {
              if ('${widget.data['page']}' == "login")
                {hitemailloginapi()}
              else
                {loginapifromhousehold()}
              // Toast.show("OTP verified !!", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
            }
          else
            {
              EasyLoading.showError('OTP_does_not_match'.tr),
            }
        });
  }
  // FocusScope.of(context).requestFocus(new FocusNode());
  // Timer(Duration(milliseconds: 4000), () {
  //   setState(() {
  //     _isLoadingButton = false;
  //     _enableButton = false;
  //   });

  //   _scaffoldKey.currentState.showSnackBar(
  //       SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
  // });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OTP'),
          backgroundColor: primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TextFieldPin(
                //     // textController: textEditingController,
                //     autoFocus: true,
                //     codeLength: _otpCodeLength,
                //     alignment: MainAxisAlignment.center,
                //     defaultBoxSize: 46.0,
                //     margin: 10,
                //     selectedBoxSize: 46.0,
                //     textStyle: TextStyle(fontSize: 16),
                // defaultDecoration: _pinPutDecoration.copyWith(
                //     border: Border.all(
                //         color: Theme.of(context)
                //             .primaryColor
                //             .withOpacity(0.6))),
                // selectedDecoration: _pinPutDecoration,
                // onChange: (code) {
                //   _onOtpCallBack(code, false);
                // }),
                // TextFieldPin(
                //   filled: true,
                //   filledColor: Colors.grey,
                //   codeLength: 6,
                //   boxSize: 46,
                //   filledAfterTextChange: false,
                //   textStyle: TextStyle(fontSize: 16),
                //   borderStyle: OutlineInputBorder(
                //       borderSide: BorderSide.none,
                //       borderRadius: BorderRadius.circular(34)),
                //   onOtpCallback: (code, isAutofill) =>
                //       _onOtpCallBack(code, isAutofill),
                // ),
                // SizedBox(
                //   height: 32,
                // ),
                GestureDetector(
                    onTap: () {
                      resendotp();
                    },
                    child: Text('Resend OTP',
                        style: TextStyle(
                            color: primary,
                            fontSize: 15,
                            decoration: TextDecoration.underline))),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.maxFinite,
                  child: MaterialButton(
                    onPressed: _enableButton ? _onSubmitOtp : null,
                    child: _setUpButtonChild(),
                    color: primary,
                    disabledColor: secondary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify".tr,
        style: TextStyle(color: Colors.white),
      );
    }
  }

  resendotp() {
    var data = {
      'user_id': '${widget.data['user_id']}',
    };
    resendEmailOtp(data);
  }

  hitemailloginapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      'email': '${widget.data['email']}',
      'password': '${widget.data['password']}'
    };

    loginApi(data).then((value) => {
          //storage.setItem('user', json.encode(value['data'])),
          prefs.setString('user', json.encode(value['data'])),
          prefs.setString('role', json.encode(value['role'])),
          prefs.setString('role_desig', json.encode(value['role_desig'])),
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

  loginapifromhousehold() async {
    EasyLoading.show(status: 'Please wait...'.tr);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var data = {'email': '${emailphone.text}', 'password': '${password.text}'};
    var data = {
      'household_head': '${widget.data['household_head']}',
      'respondent_id': '${widget.data['respondent_id']}',
      'household_token': '${widget.data['household_token']}',
      'password': '${widget.data['password']}'
    };

    // var data = {'email': 'mishrasomp@gmail.com', 'password': 'Sm@rtchangu#123'};
    // var data = {'email': 'binab12@smartpalika.org ', 'password': 'binab#so122'};
    loginApihousehold(data).then((value) => {
          //storage.setItem('user', json.encode(value['data'])),
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
            // tokenregisterApi();

            EasyLoading.dismiss();
          })
        });
  }
}
