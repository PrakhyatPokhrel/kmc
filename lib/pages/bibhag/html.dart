import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kmc/config/colors.dart';

class HTML extends StatefulWidget {
  final data;
  HTML({this.data});
  @override
  _HTMLState createState() => _HTMLState(this.data);
}

class _HTMLState extends State<HTML> {
  final data;
  _HTMLState(this.data);

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
                Text(data['title'],
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Html(
                      data: data['html'] != null
                          ? data['html']
                          : data['content']['html'])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
