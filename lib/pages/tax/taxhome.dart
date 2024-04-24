import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:kmc/pages/tax/pay/taxpayhome.dart';
import 'package:kmc/pages/tax/propertyregister/propertychooseoption.dart';
import 'package:kmc/pages/tax/taxregister/taxpayeeregister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/tax/taxpayment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'propertyEdit/propertyEditHomepage.dart';

class Tax extends StatefulWidget {
  @override
  _TaxState createState() => _TaxState();
}

class _TaxState extends State<Tax> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _otpkey = GlobalKey<FormBuilderState>();

  var taxnumber = TextEditingController();
  var otp = TextEditingController();
  String? taxPayerId;

  void deactivate() {
    EasyLoading.dismiss();
  }

  Future<TaxPayerDetailModel> getTaxPayer() async {
    TaxPayerDetailModel detail = await getTaxPayerDetail();
    return detail;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTaxPayer().then((value) => print(value));

    getTaxID();
  }

  getTaxID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      taxPayerId = prefs.getString("sptaxID");
    });
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

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
                Row(
                  children: [
                    Text('smart-tax'.tr,
                        style: TextStyle(color: primary, fontSize: 22)),
                    taxPayerId == null
                        ? Text('')
                        : Text(
                            " " + "${taxPayerId != null ? taxPayerId! : "   "}",
                            style: TextStyle(color: primary, fontSize: 22)),
                  ],
                ),
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
                child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 10,
              ),
              buttondesign('pay_tax'.tr, TaxPayHome()),
              SizedBox(height: 30),
              taxPayerId == null
                  ? buttondesign('register_taxpayer'.tr, TaxPayeeRegister())
                  : Container(),
              taxPayerId == null ? SizedBox(height: 30) : Container(),
              buttondesign('property_list'.tr, PropertyChooseHomePage()),
              SizedBox(height: 30),
              buttondesign('property_uptodate'.tr, PropertyEditHomePage()),
            ],
          ),
        ))
            //  FormBuilder(
            //   key: _fbKey,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text('tax_number'.tr,
            //             style: TextStyle(fontSize: 20, color: primary)),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: TextFormField(
            //           controller: taxnumber,
            //           keyboardType: TextInputType.number,
            //           validator: FormBuilderValidators.required(context,
            //               errorText: 'required_field'.tr),
            //           decoration: InputDecoration(
            //             // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
            //             contentPadding: new EdgeInsets.symmetric(
            //                 vertical: 15.0, horizontal: 15.0),
            //             fillColor: Colors.white, filled: true,
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                   color: Colors.transparent, width: 2.0),
            //               borderRadius:
            //                   BorderRadius.all(Radius.circular(50.0)),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                   color: Colors.transparent, width: 2.0),
            //               borderRadius:
            //                   BorderRadius.all(Radius.circular(50.0)),
            //             ),
            //             errorBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(color: Colors.redAccent),
            //             ),
            //             // prefixIcon: Icon(Icons.lock, color: primary),
            //             hintText: 'यहाँ लेख्नुहोस्...',
            //           ),
            //         ),
            //       ),
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: ElevatedButton(
            //             style: ButtonStyle(
            //                 backgroundColor:
            //                     MaterialStateProperty.all(tertiary),
            //                 padding: MaterialStateProperty.all(
            //                     EdgeInsets.symmetric(
            //                         vertical: 16, horizontal: 35)),
            //                 shape: MaterialStateProperty.all<
            //                         RoundedRectangleBorder>(
            //                     RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20.0),
            //                 ))),
            //             child: Text('SEND'.tr,
            //                 style: TextStyle(
            //                     color: textPrimaryLightColor, fontSize: 20)),
            //             onPressed: () {
            //               taxidapisend();
            //             },
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }

  dynamic taxdetail;
  taxidapisend() {
    _fbKey.currentState?.save();
    EasyLoading.show(status: 'Please wait...'.tr);

    var data = {"taxpayerCode": taxnumber.text};
    taxdetailapi(data).then((value) => {
          EasyLoading.dismiss(),
          setState(() {
            taxdetail = value['data'];
          }),
          enterotp()
        });
  }

  enterotp() {
    return showDialog(
        context: context,
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
                      Get.back();
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
// OTP for forgot password
//
                FormBuilder(
                  key: _otpkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        title: Text('msg_ask_otp'.tr,
                            style: TextStyle(
                                color: primary, fontWeight: FontWeight.bold)),
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
                          child: Text('SEND'.tr,
                              style: TextStyle(color: textPrimaryLightColor)),
                          onPressed: () {
                            Get.back();
                            verifyotp();
                          },
                        ),
                      )
                    ],
                  ),
                )

//
// Set new password
//
                // errorAlert('message')
              ],
            ),
          );
        });
  }

  verifyotp() {
    EasyLoading.show(status: 'Please wait...'.tr);

    _otpkey.currentState?.save();
    var d = {'etaxid': taxdetail['etaxId'], 'otp_code': otp.text};
    if (this._otpkey.currentState?.validate() == true) {
      taxotp(d).then((res) => {
            print(res),
            EasyLoading.dismiss(),
            if (res["status"] == true)
              {Get.to(TaxPayment(data: res['data']))}
            else
              {EasyLoading.showError(res['message']), enterotp()}
          });
    }
  }

  buttondesign(text, page) {
    return ButtonTheme(
        height: 40.0,
        child: new ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(Get.width - 64, 60)),
              backgroundColor: MaterialStateProperty.all(tertiary),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Wrap(children: [
              Text(
                '$text',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: textPrimaryLightColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.arrow_forward_rounded,
                    color: textPrimaryLightColor),
              )
            ]),
          ),
          onPressed: () {
            Get.to(page);
          },
        ));
  }
}
