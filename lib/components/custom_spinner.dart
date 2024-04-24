import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
            ),
            Image.asset(
              'assets/botu.gif',
              height: 90,
              width: 90,
              fit: BoxFit.contain,
            ),
            Text(
              "Please wait...".tr,
              style:
                  TextStyle(height: 1.2, color: textPrimaryColor, fontSize: 14),
            )
          ],
        ),
      );
    });
  }
}
