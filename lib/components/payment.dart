import 'dart:math';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';
import 'package:kmc/components/InappBrowser.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';

import '../constants/esewa_ward.dart';
import '../modal/ward_esewa_modal.dart';

class Payment extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();

  final data;
  final int ward;
  Payment({
    this.data,
    required this.ward,
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _khaltiformKey = GlobalKey<FormState>();
  TextEditingController _pinController = TextEditingController();

  TextEditingController _mobileController = TextEditingController();
  late final String clinetId;
  late final String secretKey;

  @override
  void initState() {
    List<WardEsewaModel> esewaWard =
        esewaCred.map((e) => WardEsewaModel.fromJson(e)).toList();
    clinetId = esewaWard[widget.ward - 1].clientId;
    secretKey = esewaWard[widget.ward - 1].clientSecret;
    super.initState();
    // print(widget.data['sp_pay_code']);
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'का.म.न.पा सेवा कोड: ' + '${widget.data?['sp_pay_code']}',
                style: TextStyle(color: primary, fontSize: 18))),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(0.0),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(8),
            },
            border: TableBorder.all(color: Colors.grey),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // TableRow(children: [
              //   tableText('भुक्तान कोड:'),
              //   tableText('${widget.data['sp_pay_code']}'),
              // ]),
              TableRow(children: [
                tableText('फारम नाम:'),
                tableText('${widget.data?['formName']}'),
              ]),
              TableRow(children: [
                tableText('प्रेषकको नाम:'),
                tableText('${widget.data?['name']}'),
              ]),
              // TableRow(children: [
              //   tableText('घर नं.:'),
              //   tableText('Cell 5'),
              // ]),
              TableRow(children: [
                tableText('मोबाइल नं.'),
                tableText('${widget.data?['mobile']}'),
              ]),
              // TableRow(children: [
              //   tableText('मिति'),
              //   tableText('Cell 5'),
              // ]),
              TableRow(children: [
                tableText('कुल रकम', last: {'last'}),
                tableText('${widget.data?['amount']}', last: {'last}'}),
              ]),
            ],
          ),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Text(
              'अनलाइन भुक्तानीका लागि तपाईंंको खाता भएको भुक्तानीको माध्यम चयन गर्नुहोस।',
              textAlign: TextAlign.center,
              style: TextStyle(color: text, fontSize: 18)),
        )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //esewa
              GestureDetector(
                onTap: () {
                  // notavailableAlert(context);
                  //TODO: UNCOMMENT BELOW FOR ESEWA
                  _payEsewa();
                  // not_available_Alert(context);
                  // _payViaKhalti();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/images/esewa.png',
                        height: 100, fit: BoxFit.contain),
                  ),
                ),
              ),
              //khalti
              GestureDetector(
                onTap: () {
                  // notavailableAlert(context);

                  _payViaKhalti();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/images/Khalti.png',
                        height: 100, fit: BoxFit.contain),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  notavailableAlert(context);
                  // widget.browser.openUrlRequest(
                  //     urlRequest: URLRequest(
                  //         url: Uri.parse(
                  //             "https://kathmandumetro.smartpalika.io/paymentmodule/ips-payment/?sp_payment_code=${widget.data?['sp_pay_code']}&&secure_pay_code=${widget.data?['secure_pay_code']}")),
                  //     options: options);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/images/ConnectIPS.png',
                        height: 100, fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 0.5, color: text)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.data['sp_pay_code']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: text, fontSize: 18)),
                  InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: '${widget.data['sp_pay_code']}'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('code_copied'.tr)));
                        // Toast.show('code_copied'.tr, context,
                        //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      child: Icon(Icons.copy, color: primary))
                ],
              ),
            )),
        Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Text('',
              // 'यस सेवाको भुक्तानी माथि दिईएको स्मार्टपालिका सेवा कोड अन्य पे-मेन्ट प्रोवाइडर (जस्तै:- Khalti) मा राखेर पनि गर्नसक्नुहुन्छ। ',
              textAlign: TextAlign.center,
              style: TextStyle(color: text, fontSize: 18)),
        )),
      ],
    );
  }

  tableText(textt, {last}) {
    return Container(
      height: 40,
      color: last != null ? primary : white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: new BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3),
          child: Text(textt,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: last != null ? white : text, fontSize: 16)),
        ),
      ),
    );
  }

  _payEsewa() {
    var price = widget.data['amount'];
    // var priceCheck = price.split(".");

    // price
    // price = int.parse(priceCheck[0]);
    EsewaFlutterSdk.initPayment(
      esewaConfig: EsewaConfig(
        environment: Environment.live,
        clientId: clinetId,
        secretId: secretKey,
      ),
      esewaPayment: EsewaPayment(
        productId: "${widget.data["formNum"]}",
        productName: "${widget.data["pagetitle"]}-${getRandomString(10)}",
        productPrice: "$price",
        callbackUrl:
            "https://kathmandumetro.smartpalika.io/paymentmodule/mobile-app/verify/esewa/payment",
      ),
      onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
        debugPrint(":::SUCCESS::: => $data");
        var a = data.toJson();

        final spPayCode = <String, dynamic>{
          "sp_pay_code": '${widget.data['sp_pay_code']}'
        };
        a.addEntries(spPayCode.entries);
        EasyLoading.show(status: 'Please wait...'.tr);

        await esewaVerifyApi(a).then(
          (res) => {
            if (res['status'] == true)
              {
                EasyLoading.dismiss(),
                Navigator.pop(context),
                Get.off(BottomNavBar()),
                EasyLoading.showSuccess("भुक्तानी सफल भएको छ"),
              }
            else
              {
                EasyLoading.dismiss(),
                Navigator.pop(context),
                Get.off(BottomNavBar()),
                EasyLoading.showError(res['message']),
              }
          },
        );
      },
      onPaymentFailure: (data) {
        EasyLoading.showSuccess("भुक्तानी असफल भएको छ, फेरि प्रायस गर्नु होला");
        Navigator.pop(context);
        // debugPrint(":::FAILURE::: => $data");
      },
      onPaymentCancellation: (data) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('भुक्तानी रद्द भएको छ '),
          backgroundColor: Colors.red,
        ));
        // debugPrint(":::CANCELLATION::: => $data");
      },
    );
  }

  _payViaKhalti() async {
    String convertDouble = double.parse(widget.data['amount']).toString();
    String split = convertDouble.split(".").first;
    int price = int.parse(split);
    print(price);

    // if(double.parse(price)){}
    // var priceCheck = price.toString().split(".");

    // price
    // price = int.parse(priceCheck[0]);
    // int khaltiAmount = (int.parse(price.split(".")[0]));

    showDialog(
        context: context,
        builder: (context) => Scaffold(
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
                      Text('भुक्तानी गर्नुहोस्',
                          style: TextStyle(color: primary, fontSize: 22)),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              Icon(Icons.arrow_back, color: primary, size: 28)),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Form(
                    key: _khaltiformKey,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Container(
                          height: 200,
                          child: Image.asset('assets/images/Khalti.png'),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                  selectionColor: Color(0xff5C2D91))),
                          child: TextFormField(
                            cursorColor: Color(0xff5C2D91),
                            validator: (v) =>
                                (v?.isEmpty ?? true) ? 'Required ' : null,
                            style: Theme.of(context).textTheme.headlineSmall,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text(
                                'Mobile Number',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Color(0xff5C2D91),
                                    ),
                              ),
                              focusColor: Color(0xff5C2D91),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5C2D91),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5C2D91),
                                ),
                              ),
                            ),
                            controller: _mobileController,
                          ),
                        ),
                        TextFormField(
                          cursorColor: Color(0xff5C2D91),
                          validator: (v) =>
                              (v?.isEmpty ?? true) ? 'Required ' : null,
                          decoration: InputDecoration(
                            label: Text(
                              'Khalti MPIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Color(0xff5C2D91),
                                  ),
                            ),
                            focusColor: Color(0xff5C2D91),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff5C2D91),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff5C2D91),
                              ),
                            ),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.headlineSmall,
                          controller: _pinController,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Color(0xff5C2D91)
                              ),
                          onPressed: () async {
                            if (_khaltiformKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black12,
                                  builder: (context) => Material(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 1),
                                                      blurRadius: 1)
                                                ],
                                                border: Border.all(
                                                    color: Colors.green),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Color(
                                                                  0xff5C2D91)),
                                                    ),
                                                    Text(
                                                      "Initiating Payment",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        letterSpacing: 1,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                              try {
                                final initiationModel =
                                    await Khalti.service.initiatePayment(
                                  request: PaymentInitiationRequestModel(
                                    amount: price * 100,
                                    mobile: _mobileController.text,
                                    productIdentity: 'Kathmandumetropolitian',
                                    productName: 'Kathmandumetropolitian',
                                    transactionPin: _pinController.text,
                                    // productUrl:
                                    // 'https://khalti.com/bazaar/mac-mini-16-512-m1',
                                    // additionalData: {
                                    //   'vendor': 'Oliz Store',
                                    //   'manufacturer': 'Apple Inc.',
                                    // },
                                  ),
                                );
                                Navigator.pop(context);

                                final otpCode = await showDialog<String>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    String? _otp;
                                    return AlertDialog(
                                      title: const Text(
                                          'पठाइएको ओ.टी.पी हाल्नुहोस् '),
                                      content: TextField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                        decoration: const InputDecoration(
                                          label: Text('OTP Code'),
                                        ),
                                        onChanged: (v) => _otp = v,
                                      ),
                                      actions: [
                                        SimpleDialogOption(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context, _otp),
                                        )
                                      ],
                                    );
                                  },
                                );

                                if (otpCode != null) {
                                  try {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        barrierColor: Colors.black12,
                                        builder: (context) => Material(
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 1),
                                                            blurRadius: 1)
                                                      ],
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff5C2D91)),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Color(
                                                                        0xff5C2D91)),
                                                          ),
                                                          Text(
                                                            "Verifying Payment",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                    PaymentSuccessModel model =
                                        await Khalti.service.confirmPayment(
                                      request: PaymentConfirmationRequestModel(
                                        confirmationCode: otpCode,
                                        token: initiationModel.token,
                                        transactionPin: _pinController.text,
                                      ),
                                    );
                                    var a = {
                                      'sp_pay_code':
                                          '${widget.data['sp_pay_code']}',
                                      'token': model.token,
                                      'amount': model.amount,
                                      'ward':widget.ward
                                    };

                                    khaltiverfyApi(a).then((res) => {
                                          if (res['status'] == true)
                                            {
                                              EasyLoading.showSuccess(
                                                  res['message']),
                                              Navigator.pop(context),
                                              Get.off(BottomNavBar())
                                            }
                                          else
                                            {
                                              EasyLoading.showError(
                                                  res['message']),
                                              Navigator.pop(context),
                                            }
                                        });
                                    Map<String, dynamic> pdata = {};

                                    // jsonEncode(selectedmag);

                                  } catch (e) {
                                    SnackBar(content: Text("$e"));

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     _buildSnackBar(
                                    //         Colors.red, e.data['detail']));
                                  }
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                EasyLoading.showError('$e');
                              }
                            }
                          },
                          child: Text(
                              'PAY ${widget.data['amount'].split(".").first}'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
    // FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
    //   publicKey: "live_public_key_391d10a0cd414f4cb56ada271d411de4",
    //   urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
    //   paymentPreferences: [
    //     KhaltiPaymentPreference.KHALTI,
    //   ],
    // );
    // double a = double.parse(widget.data['amount'].toString());
    // KhaltiProduct product = KhaltiProduct(
    //   id: widget.data['sp_pay_code'],
    //   amount: a * 100,
    //   name: widget.data['formName'],
    // );
    // _flutterKhalti.startPayment(
    //   product: product,
    //   onSuccess: (data) {
    //
    // var a = {
    //   'sp_pay_code': '${widget.data['sp_pay_code']}',
    //   'token': data['token'],
    //   'amount': data['amount']
    // };
    // EasyLoading.show(status: 'Please wait...'.tr);

    // khaltiverfyApi(a).then((res) => {
    //       print(res),
    //       if (res['status'] == true)
    //         {
    //           EasyLoading.dismiss(),
    //           EasyLoading.showSuccess(res['message']),
    //           Get.to(BottomNavBar())
    //         }
    //       else
    //         {EasyLoading.dismiss(), EasyLoading.showError(res['message'])}
    //     });
    //   },
    //   onFaliure: (error) {
    //     print("sorry");
    //   },
    // );
  }

  notavailableAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('प्रक्रियामा छ !',
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('यो सेवा प्रक्रियामा छ !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(tertiary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('cancel'.tr),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }

  // convertDecimal() {

  // }
}
