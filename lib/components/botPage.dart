import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BotPage extends StatefulWidget {
  const BotPage({Key? key}) : super(key: key);

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
   InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: InAppWebView(
        // initialUrlRequest: URLRequest(url: Uri.parse("https://kmc.palmchatbot.com")),
          initialData: InAppWebViewInitialData(data: r"""<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>KMC Bot</title>
    <!-- //optional -->
    <link rel="stylesheet" type="text/css" href="https://kmc.palmchatbot.com/embed/embed.css">
</head>

<body style="height: 2000px; background: #ECE9E9;">
        <script type="text/javascript" src="https://kmc.palmchatbot.com/embed/embed.js"></script>
    <script>
        (function myFunction(){
            Botfunction('palmbot','92vh','100%',['geolocation'],'https://kmc.palmchatbot.com');
        })();
    </script>
    <script src="https://kmc.palmchatbot.com/assets/jquery-3.5.1.min.js" crossorigin="anonymous"></script>

</body>
</html>"""),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
        ),
    );
  }
}