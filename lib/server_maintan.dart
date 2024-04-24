import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kmc/config/colors.dart';

class ServerMaintenance extends StatelessWidget {
  const ServerMaintenance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [primary,secondary])),
        child: Column(
          children: [
             Icon(Icons.error,size: 60,color: primary,),
          Text("Server Maintenance",style: TextStyle(color: Colors.black),)
          ],
        ),
      )
    );
  }
}