import 'package:flutter/foundation.dart';

class Config {
  //name
  static const app_name = "Kathmandu Metropolitan City";
  static const palikaNameEnglish = "Kathmandu";
  static const palikaNameNepali = "काठमाडौँ";
  //type
  static const palikaTypeEnglish = "Metropolitan City";
  static const palikaTypeNepali = "महानगरपालिका";
  static const palikaShortTypeNepali = "न. पा.";
  //url

  static const base_url = kDebugMode
      ? 'https://erp.kathmandu.gov.np'
      
      : 'https://erp.kathmandu.gov.np';



      //for toilet testpurpose only 
  static const base_url_for_toilet="https://publicshauchalaya.palika.site";
  // static const base_url_for_toilet="http://192.168.137.1:1000";


  
  static const base_url_api = '$base_url/apilink';
  //keys
  static const pusher_key =
      kDebugMode ? "864676a8b9a44e73966d" : "864676a8b9a44e73966d";
  //wodaCount
  static const woda_count = 32;

  static const bool fillDummySifarishValue = kDebugMode ? true : false;

  //assets changes

  // assets/splash.jpg , splash.png
  // assets/images/icon.png -> without background app logo
  // assets/images/icons/parichaya.jpg , parichaya.png -> municipality office photo from google
  // android/app/src/main/res/ -> app icon changes with smartpalika heart in bottom -> use android studio

  // login token -> 999999
  // password ->
}
