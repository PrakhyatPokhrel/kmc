import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class SifarishDescription extends StatelessWidget {
  const SifarishDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'palika-name'.tr +
                      ' ' +
                      'palika-name-sub'.tr +
                      ' ' +
                      ' र यस भित्रका वडाहरुलाई पेपरलेस बनाउने हाम्रो अभियान हो।',
                  style: TextStyle(
                    height: 1.5,
                    color: textPrimaryColor,
                    fontSize: 15,
                  ),
                ),
              ]),
        ),
        Spacer(),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/icons/newIcons/sifarish_top.svg',
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
