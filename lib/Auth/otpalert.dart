import 'package:kmc/Auth/login.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final data;
  OTPScreen({this.data});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";

  @override
  void initState() { 
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    // String? signature = await SmsRetrieved.getAppSignature();
    // print("signature $signature");
  }

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
      'otp_code': '${_otpCode}',
    };

    verify(data).then((value) => {
          if (value['success'] == true)
            {
              // Toast.show("OTP verified !!", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()))
            }
          else
            {
              // Toast.show("OTP नम्बर मिलेन। OTP does not match.", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM)
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
                //     // defaultDecoration: _pinPutDecoration.copyWith(
                //     //     border: Border.all(
                //     //         color: Theme.of(context)
                //     //             .primaryColor
                //     //             .withOpacity(0.6))),
                //     // selectedDecoration: _pinPutDecoration,
                //     onChange: (code) {
                //       _onOtpCallBack(code, false);
                //     }),

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
                SizedBox(
                  height: 32,
                ),
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
        "Verify",
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
}
