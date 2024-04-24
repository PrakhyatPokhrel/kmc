import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';

class CustomSifarishLabelText extends StatelessWidget {
  const CustomSifarishLabelText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          color: primary,
        ),
      ),
    );
  }
}
