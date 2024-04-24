import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/ward.dart';

import '../../config/replaceable.dart';

class WodaPart extends StatefulWidget {
  @override
  _WodaPartState createState() => _WodaPartState();
}

class _WodaPartState extends State<WodaPart> {
  @override
  void initState() {
    super.initState();
  }

  int indexvalue = 0;

  dynamic value;

  dynamic subIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Get.height * 0.12,
              child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  childAspectRatio: 1.02,
                  crossAxisCount: 1,
                  children: List.generate(Config.woda_count, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: wardCard(index + 1),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }

  wardCard(index) {
    return InkWell(
        onTap: () {
          setState(() {
            this.subIndex = index;
            indexvalue = index - 1;
            Get.to(Ward());
          });
        },
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: subIndex == index ? primary : shadowColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Wardno'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color: subIndex == index ? primary : text)),
                  Text('$index'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: subIndex == index ? primary : text)),
                ],
              ),
            )));
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: primary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.5)),
    );
  }
}
