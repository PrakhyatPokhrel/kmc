import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kmc/pages/profile/secondprofile.dart';

import '../../config/url.dart';

class ConnectPayment extends StatefulWidget {
  dynamic sppay;
  dynamic securepay;
  ConnectPayment({Key? key, required this.sppay, required this.securepay})
      : super(key: key);

  @override
  State<ConnectPayment> createState() => _ConnectPaymentState();
}

class _ConnectPaymentState extends State<ConnectPayment> {
  InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SecondProfile()));
            return false;
          },
          child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(connectips_payment +
                    "/?sp_payment_code=${widget.sppay}&&secure_pay_code=${widget.securepay}")),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
          ),
        ),
      ),
    );
  }
}
