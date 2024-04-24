import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class TaxAppView extends StatefulWidget {
  const TaxAppView({Key? key}) : super(key: key);

  @override
  State<TaxAppView> createState() => _TaxAppViewState();
}

class _TaxAppViewState extends State<TaxAppView> {
  InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child: InAppWebView(
          initialUrlRequest:URLRequest(url:Uri.parse('https://eservice.kathmandu.gov.np/')) ,
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