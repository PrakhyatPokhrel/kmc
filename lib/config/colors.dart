import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Color statusBar =
//     HexColor(primary.value.toRadixString(16)).withOpacity(0.5);

Color secondary = Color(0xFFDC4346);
Color primary = Color(0xFF3B5CA5);
const secondary_c = 0xFF47D477;
Color tertiary = Color(0xFFEDAB74);
Color background = Color.fromARGB(255, 247, 248, 250);
Color text = Colors.blueGrey.shade600;
Color textPrimaryDarkColor = Colors.blueGrey.shade600;
// Color tertiary = Colors.green.shade400;
// Color tertiary = Colors.orange.shade500;
// Color statusBar = Color(0xFF009688).withOpacity(0.5);
Color statusBar = Colors.teal.shade100;
Color textPrimaryLightColor = Colors.white;
Color white = Colors.white;
Color backgroundColorBorder = Colors.grey.shade200;
Color textPrimaryColor = Colors.black54;
Color disabledColor = Color(0xFF4CAF50).withOpacity(0.5);
Color shadowColor = Color(0xFFB2B2B2).withOpacity(.16);

//textColors
Color textsecondaryLightColor = Colors.white;
Color textsecondaryDarkColor = Colors.black;
Color textSecondaryLightColor = Colors.black87;
Color textSecondary54 = Colors.black54;
Color textSecondaryDarkColor = Colors.blue;
Color hintTextColor = Colors.white30;
Color bucketDialogueUserColor = Colors.red;
Color disabledTextColour = Colors.black54;
Color placeHolderColor = Colors.black26;
Color dividerColor = Colors.black26;

InputDecorationTheme formInput() {
  return InputDecorationTheme(
    border: OutlineInputBorder(),
    labelStyle:
        TextStyle(color: secondary, fontSize: 16.0, fontFamily: 'Mukta'),
  );
}
