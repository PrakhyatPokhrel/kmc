import 'package:kmc/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

ThemeData theme = ThemeData(
  primaryColor: Colors.black,
  // backgroundColor: Colors.white10,
  fontFamily: 'PTSans',
);

class ImageViewer extends StatelessWidget {
  final url;
  ImageViewer(this.url);

  // This widget is the root of your application.
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
                  Text('', style: TextStyle(color: primary, fontSize: 22)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: primary, size: 28)),
                ],
              ),
            ),
          ),
          body: Container(
              child: PhotoView(
            backgroundDecoration: BoxDecoration(),
            imageProvider: NetworkImage(url),
          ))),
    );
  }
}
