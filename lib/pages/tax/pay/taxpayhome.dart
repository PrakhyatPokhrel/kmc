import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/tax/taxpayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TaxPayHome extends StatefulWidget {
  @override
  _TaxPayHomeState createState() => _TaxPayHomeState();
}

class _TaxPayHomeState extends State<TaxPayHome> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _otpkey = GlobalKey<FormBuilderState>();

  var taxnumber = TextEditingController();
  var otp = TextEditingController();
  String? taxPayerId;

  void deactivate() {
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                Text('smart-tax'.tr,
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('tax_number'.tr,
                          style: TextStyle(fontSize: 20, color: primary)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: taxnumber,
                        validator: FormBuilderValidators.required(context,
                            errorText: 'required_field'.tr),
                        decoration: InputDecoration(
                          // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          fillColor: Colors.white, filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          // prefixIcon: Icon(Icons.lock, color: primary),
                          hintText: 'यहाँ लेख्नुहोस्...',
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(tertiary),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 35)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                          child: Text('SEND'.tr,
                              style: TextStyle(
                                  color: textPrimaryLightColor, fontSize: 20)),
                          onPressed: () {
                            taxidapisend();

                            // verifyotp();
                            // taxidapisend();
                            // Get.to(TaxPayment(data: ,));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic taxdetail;
  taxidapisend() {
    _fbKey.currentState!.save();
    EasyLoading.show(status: 'Please wait...'.tr);

    // var data = {"taxpayerCode": }
    var data = {"taxPayerId": taxnumber.text};
    taxpayerOTPSend(data).then((value) => {
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

  verifyotp() async {
    EasyLoading.show(status: 'Please wait...'.tr);

    _otpkey.currentState?.save();
    var d = {'taxPayerId': taxnumber.text, 'otp': otp.text};
    // var d = {'etaxid': taxdetail['etaxId'], 'otp_code': otp.text};
    // if (this._otpkey.currentState!.validate() == true) {
    await verifyTaxPayment(d).then((value) => {
          if (value?.status == true)
            {
              EasyLoading.dismiss(),
              print(value?.data?.spPaymentCode),
              Get.to(TaxPayment(data: value)),
              taxnumber.clear(),
              otp.clear(),
              EasyLoading.dismiss()
            }
          else
            {enterotp(), EasyLoading.showError("${value?.message}")}
        });

    // return detail;
    // verifyTaxPayment(d).then((res) => {
    //       print(res),
    //       EasyLoading.dismiss(),
    //       if (res["status"] == true)
    //         {Get.to(TaxPayment(data: res['data']))}
    //       else
    //         {EasyLoading.showError(res['message']), enterotp()}
    //     });
    // }
  }

  // verifyotp() async {
  //   // EasyLoading.show(status: 'Please wait...'.tr);

  //   _otpkey.currentState?.save();
  //   var d = {'taxPayerId': taxnumber.text, 'otp': otp.text};
  //   // var d = {'etaxid': taxdetail['etaxId'], 'otp_code': otp.text};
  //   // if (this._otpkey.currentState!.validate() == true) {

  //   verifyTaxPayment(d).then((res) => {
  //         EasyLoading.dismiss(),
  //         if (res["status"] == true)
  //           {
  //             Get.to(TaxPayment(data: res['data'])),
  //             taxnumber.clear(),
  //             otp.clear(),
  //           }
  //         else
  //           {
  //             enterotp(),
  //             EasyLoading.showError(res['message']),
  //           }
  //       });
  // }
}
