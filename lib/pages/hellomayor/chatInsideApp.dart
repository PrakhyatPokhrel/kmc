import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InsideAppBrowser extends StatefulWidget {
  const InsideAppBrowser({Key? key}) : super(key: key);

  @override
  State<InsideAppBrowser> createState() => _InsideAppBrowserState();
}

class _InsideAppBrowserState extends State<InsideAppBrowser> {
  InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child: InAppWebView(
          initialUrlRequest:URLRequest(url:Uri.parse('https://ijalas.kathmandu.gov.np/feedback')) ,
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
    );
  }
}