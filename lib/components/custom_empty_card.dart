import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class CustomEmptyCard extends StatelessWidget {
  const CustomEmptyCard({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
        ),
        Icon(
          Icons.no_sim_outlined,
          size: 80,
          color: primary,
        ),
        Text(
          message ?? "empty_data".tr,
          style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16),
        )
      ],
    );
  }
}
