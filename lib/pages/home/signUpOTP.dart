import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/components/custom_api_service.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpOTP extends StatefulWidget {
  final int? user_id;
  final String? email;
  final String? password;
  dynamic mobile;

  SignUpOTP({this.user_id, this.email, this.password, this.mobile});

  @override
  _SignUpOTPState createState() => _SignUpOTPState();
}

class _SignUpOTPState extends State<SignUpOTP> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 180;
  late AnimationController _controller;
  var otp;

  // Variables
  Size? _screenSize;
  dynamic _currentDigit;
  dynamic _firstDigit;
  dynamic _secondDigit;
  dynamic _thirdDigit;
  dynamic _fourthDigit;
  dynamic _fifthDigit;
  dynamic _sixthDigit;

  Timer? timer;
  int? totalTimeInSeconds;
  bool? _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Returns "Appbar"
  get _getAppbar {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
    );
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return new Text(
      "Verification Code",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "msg_ask_otp".tr,
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
        _otpTextField(_fifthDigit),
        _otpTextField(_sixthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getVerificationCodeLabel,
        _getEmailLabel,
        _getInputField,
        SizedBox(height: 20),
        _hideResendButton! ? _getTimerText : _getResendButton,
        _getOtpKeyboard,
        submitButton
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 24.0, Colors.black)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 32,
        width: 120,
        decoration:
            BoxDecoration(color: primary, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: new Text(
          "Resend OTP",
          style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onTap: () {
        EasyLoading.showInfo("msg_ask_otp".tr, duration: Duration(seconds: 1));
        resendotp();
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: _screenSize!.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_sixthDigit != null) {
                            _sixthDigit = null;
                          }
                          if (_fifthDigit != null) {
                            _fifthDigit = null;
                          }

                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  signUpOTP() {
    var data = {
      'user_id': widget.user_id,
    };
    taxRegisterotpAPi(data);
  }

  validateSignUpOTP() {
    EasyLoading.show(status: 'Please wait...'.tr);
    var data = {
      'phone': widget.mobile,
      'otp_code': otp,
    };
    if (otp.length == 6) {
      verifySignUpapi(data).then((value) => {
            EasyLoading.dismiss(),
            if (value["status"] == true)
              {hitloginapi()}
            else
              {
                EasyLoading.showError('${value['message']}'),
              }
          });
    } else {}
  }

  resendotp() {
    var data = {
      // 'user_id': widget.user_id,
      'phone': widget.mobile,
    };
    resendEmailOtp(data);
  }

  get submitButton {
    return ElevatedButton.icon(
        onPressed: () {
          // print("email: ${widget.email}");
          // print(widget.password);
          validateSignUpOTP();
        },
        // onPressed: onStepContinue,
        icon: Icon(Icons.send),
        label: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor, fontSize: 15)),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ))));
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: time))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _hideResendButton = !_hideResendButton!;
          });
        }
      });
    _controller.reverse(from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
    );
    return emailRegex.hasMatch(input);
  }

  hitloginapi() async {
    // var passdata;
    // var otp;
    EasyLoading.show(status: 'Please wait...'.tr);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = {
      isEmail(widget.mobile) ? 'email' : 'phone': widget.mobile,
      'password': '${widget.password}',
    };
    // var data = {
    //   'email': 'sadmin.waling@cellapp.co',
    //   'password': 'SPmaster&\$80'
    // };
    // var data = {
    //   'email': 'dilippratap@smartpalika.org',
    //   'password': 'w6XEbSYxdaCvVqIz'
    // };
    // var data = {'email': 'kalpana@smartpalika.org', 'password': 'Y9mCgz5frRWvu6He'};

    loginApi(data).then((value) {
      //storage.setItem('user', json.encode(value['data'])),
      if (value["token"] != null) {
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

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize?.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
      child: _getInputPart,
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(dynamic digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String? label, VoidCallback? onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label!,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      } else if (_fifthDigit == null) {
        _fifthDigit = _currentDigit;
      } else if (_sixthDigit == null) {
        _sixthDigit = _currentDigit;
        setState(() {
          otp = _firstDigit.toString() +
              _secondDigit.toString() +
              _thirdDigit.toString() +
              _fourthDigit.toString() +
              _fifthDigit.toString() +
              _sixthDigit.toString();
        });

        // Verify your otp by here. API call
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration!;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, child) {
          return new Text(
            timerString,
            style: new TextStyle(fontSize: fontSize, color: timeColor, fontWeight: FontWeight.w600),
          );
        });
  }
}
