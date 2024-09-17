import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/colors.dart';

class SifarishSuccessDialog extends StatelessWidget {
  const SifarishSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text('दर्ता सफल', textAlign: TextAlign.center, style: TextStyle(color: primary)),
      content: Text(
        "यहाँको ई-सिफारिश प्रक्रियामा गएको छ । \nरुजु भएको खण्डमा भुक्तानीका लागि SMS प्राप्त गर्नुहुनेछ। \nकारणवस रुजु नभएको सच्चाउनका लागि जानकारी प्राप्त गर्नुहुनेछ।",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(tertiary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Text('ठिक छ'),
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
              Get.off(BottomNavBar());
            },
          ),
        ),
      ],
    );
  }
}
