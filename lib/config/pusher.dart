// import 'dart:convert';
// import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:kmc/config/url.dart';

// Future initPusher() async {
//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   var token = localStorage.getString('token');
//   if (token != null) {
//     try {
//       await Pusher.init(
//           "${Config.pusher_key}",
//           PusherOptions(
//             auth: PusherAuth(pusher_authorize, headers: {
//               'Content-Type': 'application/json',
//               'Authorization': 'Bearer ' + token
//             }),
//             cluster: "ap2",
//             encrypted: true,
//           ),
//           enableLogging: true);
//     } on PlatformException catch (e) {
//       print(e.message);
//     }

//     Pusher.connect(onConnectionStateChange: (x) async {
//       print(x.currentState);
//     }, onError: (x) {
//       debugPrint("Error: ${x.exception}");
//     });
//   }
// }

// dynamic token;
// dynamic url;

// _getToken() async {
//   var dollor = "\$\$\$\$";

//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   token = localStorage.getString('token');
// }
