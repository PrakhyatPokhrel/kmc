// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
// import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:kmc/config/colors.dart';
// import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

// import 'package:kmc/pages/vital/vitalphotostaticdata.dart';

// class Birth extends StatefulWidget {
//   @override
//   _BirthState createState() => _BirthState();
// }

// class _BirthState extends State<Birth> {
//   List<Step> spr = <Step>[];
//   dynamic _currentWard = null;
//   dynamic entry_id;
//   int currentStep = 0;
//   bool complete = false;
//   StepperType stepperType = StepperType.horizontal;
//   List<Step> _getSteps(BuildContext context) {
//     spr = <Step>[
//       Step(
//         title: Text('व्यक्तिगत विवरण',
//             style: TextStyle(
//               color: (currentStep >= 0) ? tertiary : Colors.grey,
//             )),
//         isActive: (currentStep >= 0) ? true : false,
//         state: _getState(0),
//         content: step1(),
//       ),
//       Step(
//         isActive: (currentStep >= 1) ? true : false,
//         state: _getState(1),
//         title: Text('कागजात',
//             style: TextStyle(
//               color: (currentStep >= 1) ? tertiary : Colors.grey,
//             )),
//         content: step2(),
//       ),
//       Step(
//         isActive: (currentStep >= 2) ? true : false,
//         state: _getState(2),
//         title: Text('भुक्तानी',
//             style: TextStyle(
//               color: (currentStep >= 2) ? tertiary : Colors.grey,
//             )),
//         // subtitle: const Text("Error!"),
//         content: step1(),
//       ),
//     ];
//     return spr;
//   }

//   labelText(text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(text,
//           textAlign: TextAlign.left,
//           style: TextStyle(fontSize: 16, color: primary)),
//     );
//   }

//   void _scrollToTop() {
//     print('scrolling');
//     _scrollController.animateTo(0,
//         duration: Duration(seconds: 1), curve: Curves.linear);
//   }

//   InputDecoration inputTheme() {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//       enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white, width: 0),
//           borderRadius: BorderRadius.circular(30.0)),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
//     );
//   }

//   next() {
//     currentStep + 1 != spr.length
//         ? goTo(currentStep + 1)
//         : setState(() => complete = true);
//   }

//   cancel() {
//     if (currentStep > 0) {
//       goTo(currentStep - 1);
//     }
//   }

//   goTo(int step) {
//     setState(() => currentStep = step);
//   }

//   StepState _getState(int i) {
//     if (currentStep > i)
//       return StepState.complete;
//     else if (currentStep == i)
//       return StepState.editing;
//     else
//       return StepState.disabled;
//   }

//   var _address = [
//     "घर",
//     "स्वास्थ्य संस्था",
//     "अस्पताल",
//     "अन्य",
//   ];

//   var _bakti = [
//     "घरको मानिस",
//     "सुडिनि",
//     "नर्स",
//     "स्वास्थ कर्मी",
//     "डाक्टर",
//     "अन्य",
//   ];

//   var _gender = [
//     "पुरुष",
//     "महिला",
//     "अन्य",
//   ];

//   var _birthType = [
//     "एकल",
//     "जुम्ल्याह",
//     "तिम्ल्याह वा सो भन्दा बढि ",
//   ];

//   var _provinces = [
//     "1",
//     "2",
//     "3",
//     "4",
//     "5",
//     "6",
//     "7",
//   ];

//   var _bikriti = ["छ", "छैन"];

//   DateTime _eChildDate = DateTime.now();
//   NepaliDateTime _nChildDate = NepaliDateTime.now();
//   String _eChildDatestring;
//   String _nChildDateString;

//   DateTime _eBajeCitizenDate = DateTime.now();
//   NepaliDateTime _nBajeCitizenDate = NepaliDateTime.now();
//   String _eBajeCitizenDateString;
//   String _nBajeCitizenDateString;

//   DateTime _eMarriageDate = DateTime.now();
//   NepaliDateTime _nMarriageDate = NepaliDateTime.now();
//   String _eMarriageDateString;
//   String _nMarriageDateString;

//   DateTime _eFatherDate = DateTime.now();
//   NepaliDateTime _nFatherDate = NepaliDateTime.now();
//   String _eFatherDateString;
//   String _nFatherDateString;

//   DateTime _eFatherCitizenDate = DateTime.now();
//   NepaliDateTime _nFatherCitizenDate = NepaliDateTime.now();
//   String _eFatherCitizenDateString;
//   String _nFatherCitizenDateString;

//   DateTime _eMotherDate = DateTime.now();
//   NepaliDateTime _nMotherDate = NepaliDateTime.now();
//   String _eMotherDateString;
//   String _nMotherDateString;

//   DateTime _eMotherCitizenDate = DateTime.now();
//   NepaliDateTime _nMotherCitizenDate = NepaliDateTime.now();
//   String _eMotherCitizenDateString;
//   String _nMotherCitizenDateString;

//   DateTime _eSuchakCitizenDate = DateTime.now();
//   NepaliDateTime _nSuchakCitizenDate = NepaliDateTime.now();
//   String _eSuchakCitizenDateString;
//   String _nSuchakCitizenDateString;

//   DateTime _eFormDate = DateTime.now();
//   NepaliDateTime _nFormDate = NepaliDateTime.now();
//   String _eFormDateString;
//   String _nFormDateString;

//   Future<Null> selectedEnglishDate(BuildContext context, String data) async {
//     final DateTime picked = await showDatePicker(
//       initialDatePickerMode: DatePickerMode.year,
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1905),
//       lastDate: DateTime.now(),
//     );

//     if (_eChildDate != null && picked != _eChildDate ||
//         _eBajeCitizenDate != null && picked != _eBajeCitizenDate ||
//         _eMarriageDate != null && picked != _eMarriageDate ||
//         _eFatherDate != null && picked != _eFatherDate ||
//         _eFatherCitizenDate != null && picked != _eFatherCitizenDate ||
//         _eMotherDate != null && picked != _eMotherDate ||
//         _eMotherCitizenDate != null && picked != _eMotherCitizenDate ||
//         _eSuchakCitizenDate != null && picked != _eSuchakCitizenDate ||
//         _eFormDate != null && picked != _eFormDate) {
//       setState(() {
//         if (data == "eChildDate") {
//           _eChildDate = picked;
//           _eChildDatestring =
//               "${_eChildDate.year}/${_eChildDate.month}/${_eChildDate.day}";
//           print("${_eChildDate.year}/${_eChildDate.month}/${_eChildDate.day}");
//         } else if (data == "eBajeCitizenDate") {
//           _eBajeCitizenDate = picked;
//           _eBajeCitizenDateString =
//               "${_eBajeCitizenDate.year}/${_eBajeCitizenDate.month}/${_eBajeCitizenDate.day}";
//           print(
//               "${_eBajeCitizenDate.year}/${_eBajeCitizenDate.month}/${_eBajeCitizenDate.day}");
//         } else if (data == "eMarriageDate") {
//           _eMarriageDate = picked;
//           _eMarriageDateString =
//               "${_eMarriageDate.year}/${_eMarriageDate.month}/${_eMarriageDate.day}";
//           print(
//               "${_eMarriageDate.year}/${_eMarriageDate.month}/${_eMarriageDate.day}");
//         } else if (data == "eFatherDate") {
//           _eFatherDate = picked;
//           _eFatherDateString =
//               "${_eFatherDate.year}/${_eFatherDate.month}/${_eFatherDate.day}";
//           print(
//               "${_eFatherDate.year}/${_eFatherDate.month}/${_eFatherDate.day}");
//         } else if (data == "eFatherCitizenDate") {
//           _eFatherCitizenDate = picked;
//           _eFatherCitizenDateString =
//               "${_eFatherCitizenDate.year}/${_eFatherCitizenDate.month}/${_eFatherCitizenDate.day}";
//           print(
//               "${_eFatherCitizenDate.year}/${_eFatherCitizenDate.month}/${_eFatherCitizenDate.day}");
//         } else if (data == "eMotherDate") {
//           _eMotherDate = picked;
//           _eMotherDateString =
//               "${_eMotherDate.year}/${_eMotherDate.month}/${_eMotherDate.day}";
//           print(
//               "${_eMotherDate.year}/${_eMotherDate.month}/${_eMotherDate.day}");
//         } else if (data == "eMotherCitizenDate") {
//           _eMotherCitizenDate = picked;
//           _eMotherCitizenDateString =
//               "${_eMotherCitizenDate.year}/${_eMotherCitizenDate.month}/${_eMotherCitizenDate.day}";
//           print(
//               "${_eMotherCitizenDate.year}/${_eMotherCitizenDate.month}/${_eMotherCitizenDate.day}");
//         } else if (data == "eSuchakCitizenDate") {
//           _eSuchakCitizenDate = picked;
//           _eSuchakCitizenDateString =
//               "${_eSuchakCitizenDate.year}/${_eSuchakCitizenDate.month}/${_eSuchakCitizenDate.day}";
//           print(
//               "${_eSuchakCitizenDate.year}/${_eSuchakCitizenDate.month}/${_eSuchakCitizenDate.day}");
//         } else if (data == "eFormDate") {
//           _eFormDate = picked;
//           _eFormDateString =
//               "${_eFormDate.year}/${_eFormDate.month}/${_eFormDate.day}";
//           print("${_eFormDate.year}/${_eFormDate.month}/${_eFormDate.day}");
//         } else {
//           print("not found");
//         }
//       });
//     }
//   }

//   Future<Null> selectNepaliDate(BuildContext context, String data) async {
//     final NepaliDateTime? _picked = await picker.showMaterialDatePicker(
//       context: context,
//       initialDate: NepaliDateTime.now(),
//       firstDate: NepaliDateTime(2000),
//       lastDate: NepaliDateTime.now(),
//       initialDatePickerMode: DatePickerMode.year,
//     );
//     if (_nChildDate != null && _picked != _nChildDate ||
//         _nBajeCitizenDate != null && _picked != _nBajeCitizenDate ||
//         _nMarriageDate != null && _picked != _nMarriageDate ||
//         _nFatherDate != null && _picked != _nFatherDate ||
//         _nFatherCitizenDate != null && _picked != _nFatherCitizenDate ||
//         _nMotherDate != null && _picked != _eMotherDate ||
//         _nMotherCitizenDate != null && _picked != _nMotherCitizenDate ||
//         _nSuchakCitizenDate != null && _picked != _nSuchakCitizenDate ||
//         _nFormDate != null && _picked != _nFormDate) {
//       setState(() {
//         if (data == "nChildDate") {
//           _nChildDate = _picked;
//           _nChildDateString =
//               "${_nChildDate.year}/${_nChildDate.month}/${_nChildDate.day}";
//           print("${_nChildDate.year}/${_nChildDate.month}/${_nChildDate.day}");
//         } else if (data == "nBajeCitizenDate") {
//           _nBajeCitizenDate = _picked;
//           _nBajeCitizenDateString =
//               "${_nBajeCitizenDate.year}/${_nBajeCitizenDate.month}/${_nBajeCitizenDate.day}";
//           print(
//               "${_nBajeCitizenDate.year}/${_nBajeCitizenDate.month}/${_nBajeCitizenDate.day}");
//         } else if (data == "nMarriageDate") {
//           _nMarriageDate = _picked;
//           _nMarriageDateString =
//               "${_nMarriageDate.year}${_nMarriageDate.month}/${_nMarriageDate.day}";
//           print(
//               "${_nMarriageDate.year}/${_nMarriageDate.month}/${_nMarriageDate.day}");
//         } else if (data == "nFatherDate") {
//           _nFatherDate = _picked!;
//           _nFatherDateString =
//               "${_nFatherDate.year}/${_nFatherDate.month}/${_nFatherDate.day}";
//           print(
//               "${_nFatherDate.year}/${_nFatherDate.month}/${_nFatherDate.day}");
//         } else if (data == "nFatherCitizenDate") {
//           _nFatherCitizenDate = _picked!;
//           _nFatherCitizenDateString =
//               "${_nFatherCitizenDate.year}/${_nFatherCitizenDate.month}/${_nFatherCitizenDate.day}";
//           print(
//               "${_nFatherCitizenDate.year}/${_nFatherCitizenDate.month}/${_nFatherCitizenDate.day}");
//         } else if (data == "nMotherDate") {
//           _nMotherDate = _picked!;
//           _nMotherDateString =
//               "${_nMotherDate.year}/${_nMotherDate.month}/${_nMotherDate.day}";

//           print(
//               "${_nMotherDate.year}/${_nMotherDate.month}/${_nMotherDate.day}");
//         } else if (data == "nMotherCitizenDate") {
//           _nMotherCitizenDate = _picked!;
//           _nMotherCitizenDateString =
//               "${_nMotherCitizenDate.year}/${_nMotherCitizenDate.month}/${_nMotherCitizenDate.day}";
//           print(
//               "${_nMotherCitizenDate.year}/${_nMotherCitizenDate.month}/${_nMotherCitizenDate.day}");
//         } else if (data == "nSuchakCitizenDate") {
//           _nSuchakCitizenDate = _picked!;
//           _nSuchakCitizenDateString =
//               "${_nSuchakCitizenDate.year}/${_nSuchakCitizenDate.month}/${_nSuchakCitizenDate.day}";
//           print(
//               "${_nSuchakCitizenDate.year}/${_nSuchakCitizenDate.month}/${_nSuchakCitizenDate.day}");
//         } else if (data == "nFormDate") {
//           _nFormDate = _picked!;
//           _nFormDateString =
//               "${_nFormDate.year}/${_nFormDate.month}/${_nFormDate.day}";
//           print("${_nFormDate.year}/${_nFormDate.month}/${_nFormDate.day}");
//         } else {
//           print("not found");
//         }
//       });
//     }
//   }

//   final _formKey = GlobalKey<FormState>();

//   final baby_name = TextEditingController();
//   final baby_middle_name = TextEditingController();
//   final baby_surname = TextEditingController();
//   final baby_name_english = TextEditingController();
//   final baby_middle_name_english = TextEditingController();
//   final baby_surname_english = TextEditingController();
//   final caste = TextEditingController();
//   var _province;
//   List? _childdistricts;
//   var selectedChildDistrict;
//   List? _childlocallevel;
//   var selectedChildlocallevel;
//   NepaliDateTime? _selectedDateTime;
//   bool? _babycheckIdentity;
//   // NepaliDateTime _selectedChildDateTime;

//   final weight = TextEditingController();
//   final bikriti = TextEditingController();
//   final bikriti_english = TextEditingController();
//   final birth_address = TextEditingController();
//   final birth_address_english = TextEditingController();
//   final gabisa = TextEditingController();
//   final bidesh_name = TextEditingController();
//   final bideshi_thegana = TextEditingController();
//   final woda = TextEditingController();

//   final baje_name = TextEditingController();
//   final baje_middle_name = TextEditingController();
//   final baje_thar = TextEditingController();
//   final baje_name_english = TextEditingController();
//   final baje_middle_name_english = TextEditingController();
//   final baje_thar_english = TextEditingController();
//   final gbirthplaceController = TextEditingController();
//   final egbirthplaceController = TextEditingController();
//   var _gprovince;
//   List? _bajedistricts;
//   var selectedbajeDistrict;
//   List? _bajelocallevel;
//   var selectedbajelocallevel;
//   bool? _bajecheckIdentity;

//   final father_name = TextEditingController();
//   final father_middle_name = TextEditingController();
//   final father_thar = TextEditingController();
//   final father_name_english = TextEditingController();
//   final father_middle_name_english = TextEditingController();
//   final father_thar_english = TextEditingController();
//   final father_gabisa = TextEditingController();
//   final father_woda = TextEditingController();
//   final father_citizen_number = TextEditingController();
//   final father_passport_number = TextEditingController();
//   final father_education = TextEditingController();
//   final father_job = TextEditingController();
//   final father_religion = TextEditingController();
//   final father_language = TextEditingController();
//   final fbirthplaceController = TextEditingController();
//   final efbirthplaceController = TextEditingController();
//   var _fprovince;
//   List? _fatherdistricts;
//   var selectedfatherDistrict;
//   List? _fatherlocallevel;
//   var selectedfatherlocallevel;
//   bool? _fathercheckIdentity;

//   var _fCitizenProvince;
//   List? _fatherCitizenDistricts;
//   var selectedfatherCitizenDistrict;
//   List? _fatherCitizenlocallevel;
//   var selectedfatherCitizenlocallevel;

//   final father_sadak = TextEditingController();
//   final father_tol = TextEditingController();
//   final father_ghar = TextEditingController();

//   final mother_name = TextEditingController();
//   final mother_middle_name = TextEditingController();
//   final mother_thar = TextEditingController();
//   final mother_name_english = TextEditingController();
//   final mother_middle_name_english = TextEditingController();
//   final mother_thar_english = TextEditingController();
//   final mother_gabisa = TextEditingController();
//   final mother_woda = TextEditingController();
//   final mother_education = TextEditingController();
//   final mother_job = TextEditingController();
//   final mother_religion = TextEditingController();
//   final mother_language = TextEditingController();
//   final mother_passport_number = TextEditingController();
//   final mbirthplaceController = TextEditingController();
//   final embirthplaceController = TextEditingController();
//   bool? _mothercheckIdentity;
//   var _mProvince;
//   List? _motherdistricts;
//   var selectedmotherDistrict;
//   List? _motherlocallevel;
//   var selectedmotherlocallevel;

//   var _mCitizenProvince;
//   List? _motherCitizenDistricts;
//   var selectedmotherCitizenDistrict;
//   List? _motherCitizenlocallevel;
//   var selectedmotherCitizenlocallevel;

//   final mother_sadak = TextEditingController();
//   final mother_tol = TextEditingController();
//   final mother_ghar = TextEditingController();
//   final mother_citizen_number = TextEditingController();

//   final total_born_children = TextEditingController();
//   final total_alive_children = TextEditingController();
//   final marriage_certificate_number = TextEditingController();
//   final baje_citizen_number = TextEditingController();

//   final baby_suchak_name = TextEditingController();
//   final baby_suchak_middle_name = TextEditingController();
//   final baby_suchak_thar = TextEditingController();
//   final baby_suchak_name_english = TextEditingController();
//   final baby_suchak_middle_name_english = TextEditingController();
//   final baby_suchak_thar_english = TextEditingController();
//   final baby_suchak_relation = TextEditingController();
//   final baby_suchak_passport_number = TextEditingController();
//   final baby_suchak_gabisa = TextEditingController();
//   final baby_suchak_woda = TextEditingController();
//   final baby_suchak_sadak = TextEditingController();
//   final baby_suchak_tol = TextEditingController();
//   final baby_suchak_ghar = TextEditingController();
//   final baby_suchak_number = TextEditingController();
//   final baby_suchak_address = TextEditingController();
//   final baby_suchak_address_english = TextEditingController();
//   bool? _suchakcheckIdentity;

//   var _sprovince;
//   List _suchakdistricts;
//   var selectedsuchakDistrict;
//   List _suchaklocallevel;
//   var selectedsuchaklocallevel;

//   var _sCitizenProvince;
//   List _suchakCitizenDistricts;
//   var selectedsuchakCitizenDistrict;
//   List _suchakCitizenlocallevel;
//   var selectedsuchakCitizenlocallevel;

//   final form_filler_number = TextEditingController();
//   final remarks = TextEditingController();
//   final remarks_english = TextEditingController();

//   var _currentAddressSelected;
//   var _currentByaktiSelected;
//   var _currentGenderSelected;
//   var _currentBirthTYpeSelected;
//   var _currentBikritiSelected;

//   var country;
//   var _gCountry;
//   var _fCountry;
//   var _mCountry;
//   var _sCountry;
//   var requiredfiledlist;
//   List array = [];
//   ScrollController _scrollController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _babycheckIdentity = false;
//     _bajecheckIdentity = false;
//     _fathercheckIdentity = false;
//     _mothercheckIdentity = false;
//     _suchakcheckIdentity = false;
//     coutryapi();
//     districtApi();
//     localLevelApi();

//     //photo files array
//     VITAL_PHOTO_LIST[0]['fields'].forEach((key, value) {
//       print(key);
//      
//       if (value != null) {
//         requiredfiledlist = {'key': "${key}", 'value': "${value}"};
//         array.add(requiredfiledlist);
//       }
//     });
//     _scrollController = ScrollController();
//   }

//   List _country = List();

//   coutryapi() {
//     getCountries().then((value) => {
//           setState(() {
//             _country = value['result'];
//           })
//         });
//   }

//   var _district;

//   districtApi() {
//     getDistrict().then((data) => {
//           setState(() {
//             _district = data;
//           })
//         });
//   }

//   var _localLevel;

//   localLevelApi() {
//     getLocalLevel().then((data) => {
//           setState(() {
//             _localLevel = data;
//           })
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: background,
//         appBar: AppBar(
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.transparent,
//           title: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('BIRTH'.tr + ' ' + 'REPORT'.tr,
//                     style: TextStyle(color: primary, fontSize: 22)),
//                 InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.arrow_back, color: primary, size: 28)),
//               ],
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           controller: _scrollController,
//           child: Container(
//             height: Get.height * 14,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Theme(
//                 data: ThemeData(
//                     shadowColor: Colors.transparent,
//                     accentColor: tertiary,
//                     colorScheme: ColorScheme.light(primary: tertiary)),
//                 child: Stepper(
//                   physics: ClampingScrollPhysics(),
//                   controlsBuilder: (BuildContext context,
//                       {VoidCallback onStepContinue,
//                       VoidCallback onStepCancel}) {
//                     return ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 60),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: SizedBox(
//                               width: stepperType == StepperType.horizontal
//                                   ? Get.width * 0.75
//                                   : Get.width * 0.60,
//                               height: 40,
//                               child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     if (currentStep == 0) {
//                                       setState(() {
//                                         _scrollToTop();
//                                       });
//                                       birthformsubmit();
//                                     } else if (currentStep == 1) {
//                                       setState(() {
//                                         _scrollToTop();
//                                       });
//                                       onStepContinue();
//                                     }
//                                     if (currentStep == 2) {
//                                       setState(() {
//                                         _scrollToTop();
//                                       });
//                                       onStepContinue();
//                                     }
//                                   },
//                                   // onPressed: onStepContinue,
//                                   icon: Icon(Icons.upload),
//                                   label: Text('SEND'.tr),
//                                   style: ButtonStyle(
//                                       shape: MaterialStateProperty.all<
//                                               RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   )))),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   steps: _getSteps(context),
//                   type: stepperType,
//                   currentStep: currentStep,
//                   onStepContinue: next,
//                   onStepTapped: (step) {
//                     goTo(step);
//                   },
//                   onStepCancel: cancel,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget step1() {
//     return Column(
//       children: [
//         Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Center(
//                 child: Text(
//                   "शिशुको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('शिशुको पहिलो नाम(नेपालीमा)'),
//               TextFormField(
//                 controller: baby_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुको बिचको नाम(नेपालीमा)'),
//               TextFormField(
//                 controller: baby_middle_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुको थर (नेपालीमा)'),
//               TextFormField(
//                 controller: baby_surname,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुको पहिलो नाम (in English)'),
//               TextFormField(
//                 controller: baby_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुको बिचको नाम (in English)'),
//               TextFormField(
//                 controller: baby_middle_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुको थर (in English)'),
//               TextFormField(
//                 controller: baby_surname_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('जन्म मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eChildDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eChildDate.year}-${_eChildDate.month}-${_eChildDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nChildDate");
//                             print(
//                                 "${_nChildDate.year}-${_nChildDate.month}-${_nChildDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nChildDate.year}-${_nChildDate.month}-${_nChildDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('शिशु जन्मेको ठाउँ'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text("Select"),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _address.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               item,
//                               style: TextStyle(color: primary),
//                             ),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this._currentAddressSelected = value;
//                         });
//                       },
//                       value: _currentAddressSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('शिशु जन्मदा मदत गर्ने व्यक्ति'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text("Select"),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _bakti.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               item,
//                               style: TextStyle(color: primary),
//                             ),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this._currentByaktiSelected = value;
//                         });
//                       },
//                       value: _currentByaktiSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("लिङ्ग"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text("Select"),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _gender.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item, style: TextStyle(color: primary)),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this._currentGenderSelected = value;
//                         });
//                       },
//                       value: _currentGenderSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('जात / जाती'),
//               TextFormField(
//                 controller: caste,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText("जन्मको किसिम"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text("Select"),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _birthType.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item, style: TextStyle(color: primary)),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this._currentBirthTYpeSelected = value;
//                         });
//                       },
//                       value: _currentBirthTYpeSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('बच्चाको तौल (किलोमा)'),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: weight,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText("शारीरिक बिकृति"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text("Select"),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _bikriti.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item, style: TextStyle(color: primary)),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this._currentBikritiSelected = value;
//                         });
//                       },
//                       value: _currentBikritiSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('शारीरिक बिकृति भएमा उल्लेख गर्ने (नेपालीमा)'),
//               TextFormField(
//                 controller: bikriti,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शारीरिक बिकृति भएमा उल्लेख गर्ने (in English)'),
//               TextFormField(
//                 controller: bikriti_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "शिशु जन्मेको ठेगाना",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('जन्मेको ठेगाना (नेपालीमा) '),
//               TextFormField(
//                 controller: birth_address,
//                 autofocus: false,
//                 decoration: InputDecoration(
//                   hintText: "जस्तै: थापाथली",
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: Colors.white, width: 0),
//                       borderRadius: BorderRadius.circular(30.0)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0)),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('जन्मेको ठेगाना (in English)'),
//               TextFormField(
//                 controller: birth_address_english,
//                 autofocus: false,
//                 decoration: InputDecoration(
//                   hintText: "eg:Thapathali",
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: Colors.white, width: 0),
//                       borderRadius: BorderRadius.circular(30.0)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0)),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "स्थायी ठेगाना",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                   ),
//                 ),
//               ),
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _babycheckIdentity,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _babycheckIdentity = value;
//                   });
//                 },
//               ),
//               _babycheckIdentity
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("देशको नाम"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: white,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                   hint: Text("Select"),
//                                   isExpanded: true,
//                                   items: _country.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: new Text(
//                                           item['name'],
//                                         ),
//                                       ),
//                                       value: item['name'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                      
//                                       this.country = value;
//                                     });
//                                   },
//                                   value: country),
//                             ),
//                           ),
//                         ),
//                         labelText('ठेगाना (नेपालीमा)'),
//                         TextFormField(
//                           controller: bidesh_name,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('ठेगाना (in English)'),
//                         TextFormField(
//                           controller: bideshi_thegana,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("प्रदेश"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: white,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 hint: Text(
//                                   "Select",
//                                 ),
//                                 isExpanded: true,
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 items: _provinces.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(item,
//                                           style: TextStyle(color: primary)),
//                                     ),
//                                     value: item,
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _childdistricts = _district[value];
//                                     print(_district[value]);
//                                     this._province = value;
//                                     print(_province);
//                                     selectedChildDistrict = null;
//                                     selectedChildlocallevel = null;
//                                   });
//                                 },
//                                 value: _province,
//                               ),
//                             ),
//                           ),
//                         ),
//                         labelText("जिल्ला"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: white,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 hint: Text(
//                                   "Select",
//                                 ),
//                                 isExpanded: true,
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 items: _childdistricts.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(item['np_label'],
//                                           style: TextStyle(color: primary)),
//                                     ),
//                                     value: item['np_label'],
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _childlocallevel = _localLevel[value];
//                                     this.selectedChildDistrict = value;
//                                    
//                                     selectedChildlocallevel = null;
//                                   });
//                                 },
//                                 value: selectedChildDistrict,
//                               ),
//                             ),
//                           ),
//                         ),
//                         labelText("स्थानीय स्तर"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: white,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 hint: Text(
//                                   "Select",
//                                 ),
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 items: _childlocallevel.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(item['np_label'],
//                                           style: TextStyle(color: primary)),
//                                     ),
//                                     value: item['np_label'],
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     this.selectedChildlocallevel = value;
//                                    
//                                   });
//                                 },
//                                 value: selectedChildlocallevel,
//                               ),
//                             ),
//                           ),
//                         ),
//                         labelText('गा.वी.स./न.पा.'),
//                         TextFormField(
//                           controller: gabisa,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('वडा'),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           controller: woda,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "शिशुको बाजेको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('बाजेको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: baje_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको बिचको नाम(नेपालीमा)'),
//               TextFormField(
//                 controller: baje_middle_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको थर (नेपालीमा)'),
//               TextFormField(
//                 controller: baje_thar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको नाम (in English)'),
//               TextFormField(
//                 controller: baje_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको बिचको नाम(in English)'),
//               TextFormField(
//                 controller: baje_middle_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको थर (in English)'),
//               TextFormField(
//                 controller: baje_thar_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('ठेगाना'),
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _bajecheckIdentity,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _bajecheckIdentity = value;
//                   });
//                 },
//               ),
//               _bajecheckIdentity == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("देशको नाम"),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                                 isExpanded: true,
//                                 hint: Text("Select"),
//                                 items: _country.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 10.0),
//                                       child: new Text(
//                                         item['name'],
//                                       ),
//                                     ),
//                                     value: item['name'],
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                    
//                                     this._gCountry = value;
//                                   });
//                                 },
//                                 value: _gCountry),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("नागरिकता नं"),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: baje_citizen_number,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                           Row(
//                             children: [
//                               Expanded(
//                                   flex: 5,
//                                   child: Column(
//                                     children: [
//                                       labelText(' ई.सं. मा'),
//                                       GestureDetector(
//                                         onTap: () {
//                                           selectedEnglishDate(
//                                               context, "eBajeCitizenDate");
//                                         },
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               color: white,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           height: Get.height * 0.05,
//                                           width: Get.width * 0.3,
//                                           child: Text(
//                                               "${_eBajeCitizenDate.year}-${_eBajeCitizenDate.month}-${_eBajeCitizenDate.day}"),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               SizedBox(
//                                 width: Get.width * 0.02,
//                               ),
//                               Expanded(
//                                 flex: 5,
//                                 child: Column(
//                                   children: [
//                                     labelText('वि.सं. मा '),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         selectNepaliDate(
//                                             context, "nBajeCitizenDate");
//                                         print(
//                                             "${_nBajeCitizenDate.year}-${_nBajeCitizenDate.month}-${_nBajeCitizenDate.day}");
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: white,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0)),
//                                         height: Get.height * 0.05,
//                                         width: Get.width * 0.3,
//                                         child: Center(
//                                           child: Text(
//                                               '${_nChildDate.year}-${_nChildDate.month}-${_nChildDate.day}'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           labelText("प्रदेश"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   isExpanded: true,
//                                   hint: Text('Select'),
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _provinces.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item,
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item,
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _bajedistricts = _district[value];
//                                       this._gprovince = value;
//                                       print(_gprovince);
//                                       selectedChildDistrict = null;
//                                       selectedChildlocallevel = null;
//                                     });
//                                   },
//                                   value: _gprovince,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("जिल्ला"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _childdistricts.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _bajelocallevel = _localLevel[value];
//                                       this.selectedChildDistrict = value;
//                                      
//                                       selectedChildlocallevel = null;
//                                     });
//                                   },
//                                   value: selectedChildDistrict,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("स्थानीय स्तर"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _childlocallevel.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       this.selectedbajelocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: selectedbajelocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "शिशुको बाबु आमाको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('बाबुको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: father_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको बिचको नाम(नेपालीमा)'),
//               TextFormField(
//                 controller: father_middle_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको थर (नेपालीमा) '),
//               TextFormField(
//                 controller: father_thar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको नाम (in English)'),
//               TextFormField(
//                 controller: father_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको बिचको नाम(in English)'),
//               TextFormField(
//                 controller: father_middle_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको थर (in English)'),
//               TextFormField(
//                 controller: father_thar_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको नाम (नेपालीमा) '),
//               TextFormField(
//                 controller: mother_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको बिचको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: mother_middle_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको थर (नेपालीमा)'),
//               TextFormField(
//                 controller: mother_thar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको नाम (in English)'),
//               TextFormField(
//                 controller: mother_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको बिचको नाम (in English)'),
//               TextFormField(
//                 controller: mother_middle_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको थर (in English)'),
//               TextFormField(
//                 controller: mother_thar_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('यो शिशु सम्म गरि हाल सम्म जन्मेको सन्तानको संख्या'),
//               TextFormField(
//                 controller: total_born_children,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('यो शिशु सम्म गरि हाल सम्म जीवित सन्तानको संख्या'),
//               TextFormField(
//                 controller: total_alive_children,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिवाह दर्ता नं'),
//               TextFormField(
//                 controller: marriage_certificate_number,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिवाह भएको मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eMarriageDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eMarriageDate.year}-${_eMarriageDate.month}-${_eMarriageDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nMarriageDate");
//                             print(
//                                 "${_nMarriageDate.year}-${_nMarriageDate.month}-${_nMarriageDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nChildDate.year}-${_nChildDate.month}-${_nChildDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "शिशुको बाबुको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('जन्म मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eFatherDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eFatherDate.year}-${_eFatherDate.month}-${_eFatherDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nFatherDate");
//                             print(
//                                 "${_nFatherDate.year}-${_nFatherDate.month}-${_nFatherDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nFatherDate.year}-${_nFatherDate.month}-${_nFatherDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _fathercheckIdentity,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _fathercheckIdentity = value;
//                   });
//                 },
//               ),
//               _fathercheckIdentity == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("देशको नाम"),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                                 hint: Text("Select"),
//                                 isExpanded: true,
//                                 items: _country.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 10.0),
//                                       child: new Text(item['name'],
//                                           style: TextStyle(color: primary)),
//                                     ),
//                                     value: item['name'],
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                    
//                                     this._fCountry = value;
//                                   });
//                                 },
//                                 value: _fCountry),
//                           ),
//                         ),
//                         labelText('पासपोर्ट नम्बर'),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           controller: father_passport_number,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("प्रदेश"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   isExpanded: true,
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _provinces.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item,
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item,
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _fatherdistricts = _district[value];
//                                       print(_district[value]);
//                                       this._fprovince = value;
//                                       print(_fprovince);
//                                       selectedfatherDistrict = null;
//                                       selectedfatherlocallevel = null;
//                                     });
//                                   },
//                                   value: _fprovince,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("जिल्ला"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _fatherdistricts.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Text(item['np_label'],
//                                           style: TextStyle(color: primary)),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _fatherlocallevel = _localLevel[value];
//                                       this.selectedfatherDistrict = value;
//                                      
//                                       selectedfatherlocallevel = null;
//                                     });
//                                   },
//                                   value: selectedfatherDistrict,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("स्थानीय स्तर"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _fatherlocallevel.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       this.selectedfatherlocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: selectedfatherlocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText('गा.वी.स./न.पा.'),
//                           TextFormField(
//                             controller: father_gabisa,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('वडा'),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: father_woda,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('सडक/ मार्ग'),
//                           TextFormField(
//                             controller: father_sadak,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('गाउँ/टोल'),
//                           TextFormField(
//                             controller: father_tol,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('घर नं'),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: father_ghar,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('नागरिकता नं '),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: father_citizen_number,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                           Row(
//                             children: [
//                               Expanded(
//                                   flex: 5,
//                                   child: Column(
//                                     children: [
//                                       labelText(' ई.सं. मा'),
//                                       GestureDetector(
//                                         onTap: () {
//                                           selectedEnglishDate(
//                                               context, "eFatherCitizenDate");
//                                         },
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               color: white,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           height: Get.height * 0.05,
//                                           width: Get.width * 0.3,
//                                           child: Text(
//                                               "${_eFatherCitizenDate.year}-${_eFatherCitizenDate.month}-${_eFatherCitizenDate.day}"),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               SizedBox(
//                                 width: Get.width * 0.02,
//                               ),
//                               Expanded(
//                                 flex: 5,
//                                 child: Column(
//                                   children: [
//                                     labelText('वि.सं. मा '),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         selectNepaliDate(
//                                             context, "nFatherCitizenDate");
//                                         print(
//                                             "${_nFatherCitizenDate.year}-${_nFatherCitizenDate.month}-${_nFatherCitizenDate.day}");
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: white,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0)),
//                                         height: Get.height * 0.05,
//                                         width: Get.width * 0.3,
//                                         child: Center(
//                                           child: Text(
//                                               '${_nFatherCitizenDate.year}-${_nFatherCitizenDate.month}-${_nFatherCitizenDate.day}'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           labelText('नागरिकता जारी प्रदेश'),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "प्रदेश चयन गर्नुहोस्",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _provinces.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item,
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item,
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _fatherCitizenDistricts =
//                                           _district[value];
//                                       print(_district[value]);
//                                       this._fCitizenProvince = value;
//                                       print(_fCitizenProvince);
//                                     });
//                                   },
//                                   value: _fCitizenProvince,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("नागरिकता जारी जिल्ला"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "जिल्ला चयन गर्नुहोस्",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _fatherCitizenDistricts.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _fatherCitizenlocallevel =
//                                           _localLevel[value];
//                                       this.selectedfatherCitizenDistrict =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value: selectedfatherCitizenDistrict,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("नागरिकता जारी स्थानीय स्तर"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "जिल्ला चयन गर्नुहोस्",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _fatherCitizenlocallevel.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       this.selectedfatherCitizenlocallevel =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value: selectedfatherCitizenlocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//               labelText('शिक्षाको उतिर्ण स्तर'),
//               TextFormField(
//                 controller: father_education,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पेशा '),
//               TextFormField(
//                 controller: father_job,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('धर्म '),
//               TextFormField(
//                 controller: father_religion,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('मातृभाषा'),
//               TextFormField(
//                 controller: father_language,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "शिशुको आमाको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('जन्म मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eMotherDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eMotherDate.year}-${_eMotherDate.month}-${_eMotherDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nMotherDate");
//                             print(
//                                 "${_nMotherDate.year}-${_nMotherDate.month}-${_nMotherDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nMotherDate.year}-${_nMotherDate.month}-${_nMotherDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _mothercheckIdentity,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _mothercheckIdentity = value;
//                   });
//                 },
//               ),
//               _mothercheckIdentity == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("देशको नाम"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: white,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                   isExpanded: true,
//                                   items: _country.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: new Text(
//                                           item['name'],
//                                         ),
//                                       ),
//                                       value: item['name'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                      
//                                       this._mCountry = value;
//                                     });
//                                   },
//                                   value: _mCountry),
//                             ),
//                           ),
//                         ),
//                         labelText('पासपोर्ट नम्बर'),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           controller: mother_passport_number,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("प्रदेश"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _provinces.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item,
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item,
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _motherdistricts = _district[value];
//                                       print(_district[value]);
//                                       this._mProvince = value;
//                                       print(_mProvince);
//                                       selectedmotherDistrict = null;
//                                       selectedmotherlocallevel = null;
//                                     });
//                                   },
//                                   value: _mProvince,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("जिल्ला"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _motherdistricts.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _motherlocallevel = _localLevel[value];
//                                       this.selectedmotherDistrict = value;
//                                      
//                                       selectedmotherlocallevel = null;
//                                     });
//                                   },
//                                   value: selectedmotherDistrict,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("स्थानीय स्तर"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _motherlocallevel.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       this.selectedmotherlocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: selectedmotherlocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//               labelText('गा.वी.स./न.पा.'),
//               TextFormField(
//                 controller: mother_gabisa,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('वडा'),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: mother_woda,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('सडक/ मार्ग'),
//               TextFormField(
//                 controller: mother_sadak,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('गाउँ/टोल'),
//               TextFormField(
//                 controller: mother_tol,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('घर नं'),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: mother_ghar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नागरिकता नं '),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: mother_citizen_number,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(
//                                   context, "eMotherCitizenDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eMotherCitizenDate.year}-${_eMotherCitizenDate.month}-${_eMotherCitizenDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nMotherCitizenDate");
//                             print(
//                                 "${_nMotherCitizenDate.year}-${_nMotherCitizenDate.month}-${_nMotherCitizenDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nMotherCitizenDate.year}-${_nMotherCitizenDate.month}-${_nMotherCitizenDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('नागरिकता जारी प्रदेश'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text(
//                         "Select",
//                       ),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _provinces.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item, style: TextStyle(color: primary)),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _motherCitizenDistricts = _district[value];
//                           print(_district[value]);
//                           this._mCitizenProvince = value;
//                           print(_mCitizenProvince);
//                         });
//                       },
//                       value: _mCitizenProvince,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("नागरिकता जारी जिल्ला"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text(
//                         "Select",
//                       ),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _motherCitizenDistricts.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item['np_label'],
//                                 style: TextStyle(color: primary)),
//                           ),
//                           value: item['np_label'],
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _motherCitizenlocallevel = _localLevel[value];
//                           this.selectedmotherCitizenDistrict = value;
//                          
//                         });
//                       },
//                       value: selectedmotherCitizenDistrict,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("नागरिकता जारी स्थानीय स्तर"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text(
//                         "Select",
//                       ),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _motherCitizenlocallevel.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item['np_label'],
//                                 style: TextStyle(color: primary)),
//                           ),
//                           value: item['np_label'],
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this.selectedmotherCitizenlocallevel = value;
//                          
//                         });
//                       },
//                       value: selectedmotherCitizenlocallevel,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('शिक्षाको उतिर्ण स्तर'),
//               TextFormField(
//                 controller: mother_education,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पेशा '),
//               TextFormField(
//                 controller: mother_job,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('धर्म '),
//               TextFormField(
//                 controller: mother_religion,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('मातृभाषा'),
//               TextFormField(
//                 controller: mother_language,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "सूचकको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText(
//                 "यसमा लेखेको विवरण साँचो हो । झुट्ठा ठहरे कानून बमोजिम सहुँला बुझाउँला । ",
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: baby_suchak_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम(नेपालीमा)'),
//               TextFormField(
//                 controller: baby_suchak_middle_name,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('थर (नेपालीमा) '),
//               TextFormField(
//                 controller: baby_suchak_thar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नाम (in English)'),
//               TextFormField(
//                 controller: baby_suchak_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम(in English)'),
//               TextFormField(
//                 controller: baby_suchak_middle_name_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('थर (in English)'),
//               TextFormField(
//                 controller: baby_suchak_thar_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('शिशुसंग को नाता'),
//               TextFormField(
//                 controller: baby_suchak_relation,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _suchakcheckIdentity,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _suchakcheckIdentity = value;
//                   });
//                 },
//               ),
//               _suchakcheckIdentity == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("देशको नाम"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: white,
//                             ),
//                             child: DropdownButton(
//                                 isExpanded: true,
//                                 items: _country.map((item) {
//                                   return DropdownMenuItem(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: new Text(
//                                         item['name'],
//                                       ),
//                                     ),
//                                     value: item['name'],
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                    
//                                     this._sCountry = value;
//                                   });
//                                 },
//                                 value: _sCountry),
//                           ),
//                         ),
//                         labelText('ठेगाना (नेपालीमा)'),
//                         TextFormField(
//                           controller: baby_suchak_address,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('ठेगाना (in English)'),
//                         TextFormField(
//                           controller: baby_suchak_address_english,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पासपोर्ट नम्बर'),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           controller: baby_suchak_passport_number,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("प्रदेश"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _provinces.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item,
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item,
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _suchakdistricts = _district[value];
//                                       print(_district[value]);
//                                       this._sprovince = value;
//                                       print(_sprovince);
//                                       selectedsuchakDistrict = null;
//                                       selectedsuchaklocallevel = null;
//                                     });
//                                   },
//                                   value: _sprovince,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("जिल्ला"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _suchakdistricts.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Text(item['np_label'],
//                                           style: TextStyle(color: primary)),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _suchaklocallevel = _localLevel[value];
//                                       this.selectedsuchakDistrict = value;
//                                      
//                                       selectedsuchaklocallevel = null;
//                                     });
//                                   },
//                                   value: selectedsuchakDistrict,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("स्थानीय स्तर"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: white,
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton(
//                                   hint: Text(
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _suchaklocallevel.map((item) {
//                                     return DropdownMenuItem(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(item['np_label'],
//                                             style: TextStyle(color: primary)),
//                                       ),
//                                       value: item['np_label'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       this.selectedsuchaklocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: selectedsuchaklocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//               labelText('गा.वी.स./न.पा.'),
//               TextFormField(
//                 controller: baby_suchak_gabisa,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('वडा'),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: baby_suchak_woda,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('सडक/ मार्ग'),
//               TextFormField(
//                 controller: baby_suchak_sadak,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('गाउँ/टोल'),
//               TextFormField(
//                 controller: baby_suchak_tol,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('घर नं'),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: baby_suchak_ghar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नागरिकता नं '),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: baby_suchak_number,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(
//                                   context, "eSuchakCitizenDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                 "${_eSuchakCitizenDate.year}-${_eSuchakCitizenDate.month}-${_eSuchakCitizenDate.day}",
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं. मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nSuchakCitizenDate");
//                             print(
//                                 "${_nSuchakCitizenDate.year}-${_nSuchakCitizenDate.month}-${_nSuchakCitizenDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nSuchakCitizenDate.year}/${_nSuchakCitizenDate.month}/${_nSuchakCitizenDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('नागरिकता जारी प्रदेश'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text(
//                         "Select",
//                       ),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _provinces.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item, style: TextStyle(color: primary)),
//                           ),
//                           value: item,
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _suchakCitizenDistricts = _district[value];
//                           print(_district[value]);
//                           this._sCitizenProvince = value;
//                           print(_sCitizenProvince);
//                           selectedsuchakCitizenDistrict = null;
//                           selectedsuchakCitizenlocallevel = null;
//                         });
//                       },
//                       value: _sCitizenProvince,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("नागरिकता जारी जिल्ला"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       hint: Text(
//                         "Select",
//                       ),
//                       isExpanded: true,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _suchakCitizenDistricts.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item['np_label'],
//                                 style: TextStyle(color: primary)),
//                           ),
//                           value: item['np_label'],
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _suchakCitizenlocallevel = _localLevel[value];
//                           this.selectedsuchakCitizenDistrict = value;
//                          
//                           selectedsuchakCitizenlocallevel = null;
//                         });
//                       },
//                       value: selectedsuchakCitizenDistrict,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("नागरिकता जारी स्थानीय स्तर"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: white,
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                       isExpanded: true,
//                       hint: Text(
//                         "Select",
//                       ),
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: _suchakCitizenlocallevel.map((item) {
//                         return DropdownMenuItem(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(item['np_label'],
//                                 style: TextStyle(color: primary)),
//                           ),
//                           value: item['np_label'],
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           this.selectedsuchakCitizenlocallevel = value;
//                          
//                         });
//                       },
//                       value: selectedsuchakCitizenlocallevel,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Center(
//                 child: Text(
//                   "फारम भर्नेको विवरण",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               labelText('फारम भरेको मिति (साल- महिना- गते)'),
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 5,
//                       child: Column(
//                         children: [
//                           labelText(' ई.सं.मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eFormDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eFormDate.year}/${_eFormDate.month}/${_eFormDate.day}"),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: Get.width * 0.02,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText('वि.सं.मा '),
//                         GestureDetector(
//                           onTap: () async {
//                             selectNepaliDate(context, "nFormDate");
//                             print(
//                                 "${_nFormDate.year}/${_nFormDate.month}/${_nFormDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nFormDate.year}/${_nFormDate.month}/${_nFormDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('फारम भर्नेको नम्बर '),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: form_filler_number,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('कैफियत (नेपालीमा)'),
//               TextFormField(
//                 controller: remarks,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('कैफियत (in English)'),
//               TextFormField(
//                 controller: remarks_english,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   var status;

//   Widget birthformsubmit() {
//     print(_eChildDatestring);
//     _formKey.currentState.save();
//     var birth_data = {
//       "baby_check_box": "${_babycheckIdentity}",
//       "baby_middle_name": "${baby_middle_name.text}",
//       "baby_middle_name_english": "${baby_middle_name_english.text}",
//       "baby_name": "${baby_name.text}",
//       "baby_name_english": "${baby_name_english.text}",
//       "baby_suchak_address": "${baby_suchak_address.text}",
//       "baby_suchak_address_english": "${baby_suchak_address_english.text}",
//       "baby_suchak_check_box": "${_suchakcheckIdentity}",
//       "baby_suchak_citizen_jilla": "${selectedsuchakCitizenDistrict}",
//       // "baby_suchak_date": _nSuchakCitizenDate,
//       "baby_suchak_foreign_country": "${_sCountry}",
//       // "baby_suchak_form_date": _nFormDate,
//       "baby_suchak_gabisa": "${selectedsuchakCitizenlocallevel}",
//       "baby_suchak_ghar": "${baby_suchak_ghar.text}",
//       "baby_suchak_jilla": "${selectedsuchakDistrict}",
//       "baby_suchak_middle_name": "${baby_suchak_middle_name.text}",
//       "baby_suchak_middle_name_english":
//           "${baby_suchak_middle_name_english.text}",
//       "baby_suchak_name": "${baby_suchak_name.text}",
//       "baby_suchak_name_english": "${baby_suchak_name_english.text}",
//       "baby_suchak_number": "${baby_suchak_number.text}",
//       "baby_suchak_passport_number": "${baby_suchak_passport_number.text}",
//       "baby_suchak_relation": "${baby_suchak_relation.text}",
//       "baby_suchak_sadak": "${baby_suchak_sadak.text}",
//       "baby_suchak_thar": "${baby_suchak_thar.text}",
//       "baby_suchak_thar_english": "${baby_suchak_thar_english.text}",
//       "baby_suchak_tol": "${baby_suchak_tol.text}",
//       "baby_suchak_woda": baby_suchak_woda.text,
//       "baby_surname": "${baby_surname.text}",
//       "baby_surname_english": "${baby_surname_english.text}",
//       "baje_check_box": "${_babycheckIdentity}",
//       // "baje_citizen_date": _nBajeCitizenDate,
//       "baje_citizen_jilla": "${selectedbajeDistrict}",
//       "baje_citizen_number": "${baje_citizen_number.text}",
//       "baje_foreign_country": "${_gCountry}",
//       "baje_middle_name": "${baje_middle_name.text}",
//       "baje_middle_name_english": "${baje_middle_name_english.text}",
//       "baje_name": "${baje_name.text}",
//       "baje_name_english": "${baje_name_english.text}",
//       "baje_thar": "${baje_thar.text}",
//       "baje_thar_english": "${baje_thar_english.text}",
//       "bidesh_name": "${_country}",
//       "bideshi_thegana": "${bideshi_thegana.text}",
//       "bideshi_thegana_english": "${bideshi_thegana.text}",
//       "bikriti": "${bikriti.text}",
//       "bikriti_english": "${bikriti_english.text}",
//       "birth_address": "${birth_address.text}",
//       "birth_address_english": "${birth_address_english.text}",
//       "birth_date_english": "${_eChildDatestring}",
//       // "birth_date_nepali": _nChildDate,
//       // "birth_marriage_date_english": _eMarriageDate,
//       // "birth_marriage_date_nepali": _nMarriageDate,
//       "caste": "${caste.text}",
//       "defect": "${_currentBikritiSelected}",
//       // "father_birth_date_english": _eFatherDate,
//       // "father_birth_date_nepali": _nFatherDate,
//       "father_check_box": "${_fathercheckIdentity}",
//       // "father_citizen_date": _nFatherCitizenDate,
//       "father_citizen_jilla": "${selectedfatherCitizenDistrict}",
//       "father_citizen_number": "${father_citizen_number.text}",
//       "father_education": "${father_education.text}",
//       "father_foreign_country": "${_fCountry}",
//       "father_gabisa": "${father_gabisa.text}",
//       "father_ghar": "${father_ghar.text}",
//       "father_jilla": "${selectedfatherDistrict}",
//       "father_job": "${father_job.text}",
//       "father_language": "${father_language.text}",
//       "father_middle_name": "${father_middle_name.text}",
//       "father_middle_name_english": "${father_middle_name_english.text}",
//       "father_name": "${father_name.text}",
//       "father_name_english": "${father_name_english.text}",
//       "father_passport_number": "${father_passport_number.text}",
//       "father_religion": "${father_religion.text}",
//       "father_sadak": "${father_sadak.text}",
//       "father_thar": "${father_thar.text}",
//       "father_thar_english": "${father_thar_english.text}",
//       "father_tol": "${father_tol.text}",
//       "father_woda": father_woda.text,
//       "form_filler_number": "${form_filler_number.text}",
//       "gabisa": "${gabisa.text}",
//       "helper": "${_currentByaktiSelected}",
//       "jilla": "${selectedChildDistrict}",
//       "marriage_certificate_number": "${marriage_certificate_number.text}",
//       // "mother_birth_date_english": _eMotherDate,
//       // "mother_birth_date_nepali": _nMotherDate,
//       "mother_check_box": "${_mothercheckIdentity}",
//       // "mother_citizen_date": _nMotherCitizenDate,
//       "mother_citizen_jilla": "${selectedmotherDistrict}",
//       "mother_citizen_number": "${mother_citizen_number.text}",
//       "mother_education": "${mother_education.text}",
//       "mother_foreign_country": "${_mCountry}",
//       "mother_gabisa": "${mother_gabisa.text}",
//       "mother_ghar": "${mother_ghar.text}",
//       "mother_jilla": "${_motherdistricts}",
//       "mother_job": "${mother_job.text}",
//       "mother_language": "${mother_language.text}",
//       "mother_middle_name": "${mother_middle_name.text}",
//       "mother_middle_name_english": "${mother_middle_name_english.text}",
//       "mother_name": "${mother_name.text}",
//       "mother_name_english": "${mother_name_english.text}",
//       "mother_passport_number": "${mother_passport_number.text}",
//       "mother_religion": "${mother_religion.text}",
//       "mother_sadak": "${mother_sadak.text}",
//       "mother_thar": "${mother_thar.text}",
//       "mother_thar_english": "${mother_thar_english.text}",
//       "mother_tol": "${mother_tol.text}",
//       "mother_woda": mother_woda.text,
//       "place": "${_currentAddressSelected}",
//       "remarks": "${remarks.text}",
//       "remarks_english": "${remarks_english.text}",
//       "sex": "${_currentGenderSelected}",
//       "total_alive_children": "${total_alive_children.text}",
//       "total_born_children": "${total_born_children.text}",
//       "type": "${_currentBirthTYpeSelected}",
//       "weight": "${weight}",
//       "woda": woda.text,
//     };

//     var dummy_data = {
//       'baby_check_box': true,
//       'baby_middle_name': "जानकारी",
//       'baby_middle_name_english': "tttt",
//       'baby_name': "जानकारी",
//       'baby_name_english': "tette",
//       'baby_suchak_address': "जानकारी",
//       'baby_suchak_address_english': "test",
//       'baby_suchak_check_box': true,
//       'baby_suchak_citizen_jilla': null,
//       'baby_suchak_date': null,
//       'baby_suchak_foreign_country': "Albania",
//       'baby_suchak_form_date': "2000-01-01",
//       'baby_suchak_gabisa': null,
//       'baby_suchak_ghar': null,
//       'baby_suchak_jilla': null,
//       'baby_suchak_middle_name': "जानकारी",
//       'baby_suchak_middle_name_english': "test",
//       'baby_suchak_name': "जानकारी",
//       'baby_suchak_name_english': "test",
//       'baby_suchak_number': null,
//       'baby_suchak_passport_number': "123",
//       'baby_suchak_relation': "test",
//       'baby_suchak_sadak': null,
//       'baby_suchak_thar': "जानकारी",
//       'baby_suchak_thar_english': "test",
//       'baby_suchak_tol': null,
//       'baby_suchak_woda': null,
//       'baby_surname': "जानकारी",
//       'baby_surname_english': "tttt",
//       'baje_check_box': false,
//       'baje_citizen_date': "2000-01-01",
//       'baje_citizen_jilla': "Ilam",
//       'baje_citizen_number': "123",
//       'baje_foreign_country': null,
//       'baje_middle_name': "जानकारी",
//       'baje_middle_name_english': "t",
//       'baje_name': "जानकारी",
//       'baje_name_english': "tt",
//       'baje_thar': "जानकारी",
//       'baje_thar_english': "t",
//       'bidesh_name': "Antigua and Barbuda",
//       'bideshi_thegana': "जानकारी",
//       'bideshi_thegana_english': "test",
//       'bikriti': "जानकारी",
//       'bikriti_english': "test",
//       'birth_address': "जानकारी",
//       'birth_address_english': "test",
//       'birth_date_english': "2021-02-11",
//       'birth_date_nepali': "2000-01-01",
//       'birth_marriage_date_english': "2021-02-11",
//       'birth_marriage_date_nepali': "2000-01-01",
//       'caste': "test",
//       'defect': "1",
//       'father_birth_date_english': "2021-02-11",
//       'father_birth_date_nepali': "2000-01-01",
//       'father_check_box': true,
//       'father_citizen_date': null,
//       'father_citizen_jilla': null,
//       'father_citizen_number': null,
//       'father_education': "teste",
//       'father_foreign_country': "Albania",
//       'father_gabisa': null,
//       'father_ghar': null,
//       'father_jilla': null,
//       'father_job': "test",
//       'father_language': "test",
//       'father_middle_name': "जानकारी",
//       'father_middle_name_english': "tet",
//       'father_name': "जानकारी",
//       'father_name_english': "test",
//       'father_passport_number': "123",
//       'father_religion': "etst",
//       'father_sadak': null,
//       'father_thar': "जानकारी",
//       'father_thar_english': "etst",
//       'father_tol': null,
//       'father_woda': null,
//       'form_filler_number': "9818238778",
//       'gabisa': null,
//       'helper': "family_member",
//       'jilla': null,
//       'marriage_certificate_number': "123",
//       'mother_birth_date_english': "2021-02-11",
//       'mother_birth_date_nepali': "2000-01-01",
//       'mother_check_box': true,
//       'mother_citizen_date': null,
//       'mother_citizen_jilla': null,
//       'mother_citizen_number': null,
//       'mother_education': "test",
//       'mother_foreign_country': "Albania",
//       'mother_gabisa': null,
//       'mother_ghar': null,
//       'mother_jilla': null,
//       'mother_job': "teste",
//       'mother_language': "test",
//       'mother_middle_name': "जानकारी",
//       'mother_middle_name_english': "test",
//       'mother_name': "जानकारी",
//       'mother_name_english': "test",
//       'mother_passport_number': "123",
//       'mother_religion': "test",
//       'mother_sadak': null,
//       'mother_thar': "जानकारी",
//       'mother_thar_english': "etst",
//       'mother_tol': null,
//       'mother_woda': null,
//       'place': "health_post",
//       'remarks': null,
//       'remarks_english': null,
//       'sex': "others",
//       'total_alive_children': "21",
//       'total_born_children': "3",
//       'type': "twin",
//       'weight': "2",
//       'woda': null
//     };
//     print(dummy_data);
//     birthformApi(birth_data).then((res) => {
//           if (res['status'] == true)
//             {
//               setState(() {
//                 status = true;
//               }),
//               entry_id = res['data']['entryid']
//             }
//         });
//   }

//   int photolen = 0;

//   step2() {
//     print(array);

//     return Container(
//       child: Column(
//         // shrinkWrap: true,
//         children: <Widget>[
//           // mainAxisAlignment: MainAxisAlignment.start,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           Container(
//             height: photolen == 0
//                 ? Get.height * 0.09 * array.length
//                 : Get.height * 0.1 * array.length + (photolen * 303),
//             child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: array.length,
//                 itemBuilder: (BuildContext ctxt, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                               '${array[index]['value']}',
//                               style: TextStyle(fontSize: 16, color: text),
//                             ),
//                             trailing: Container(
//                               width: 70,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         chooseimage(index);
//                                       },
//                                       child: Icon(Icons.camera_alt,
//                                           color: primary, size: 27)),
//                                   GestureDetector(
//                                       onTap: () {
//                                         pdffilechooser(index);
//                                       },
//                                       child: Icon(Icons.attach_file,
//                                           color: primary, size: 27))
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         imageupload[index] != ''
//                             ? Container(
//                                 width: 500,
//                                 height: 300,
//                                 child: Image.file(
//                                   imageupload[index],
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : Container(),
//                         filepdf[index] != ''
//                             ? Container(height: 20, child: Text(filepdf[index]))
//                             : Container(),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//           // titleText('form_sample'.tr),
//           // Container(
//           //     height: Get.height * 0.09 * dhacha.length,
//           //     child: ListView.builder(
//           //         itemCount: dhacha.length,
//           //         itemBuilder: (BuildContext ctxt, int index) {
//           //           return ListTile(
//           //             title: Text(
//           //               '${dhacha[index].dhacha_name}',
//           //               style: TextStyle(fontSize: 16, color: text),
//           //             ),
//           //             leading:
//           //                 Icon(Icons.file_present, color: primary, size: 27),
//           //           );
//           //         })),
//         ],
//       ),
//     );
//   }

//   chooseimage(index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return new Container(
//             color: Colors.transparent,
//             //could change this to Color(0xFF737373),
//             //so you don't have to change MaterialApp canvasColor
//             child: new Container(
//               decoration: new BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: new BorderRadius.only(
//                       topLeft: const Radius.circular(10.0),
//                       topRight: const Radius.circular(10.0))),
//               child: new Wrap(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       getImageFromGallery(index);
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.image, color: primary),
//                       title: Text('load_gallery'.tr),
//                     ),
//                   ),
//                   new GestureDetector(
//                     onTap: () {
//                       getImageFromCamera(index);
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.camera, color: primary),
//                       title: Text('open_camera'.tr),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.cancel_outlined, color: primary),
//                       title: Text('cancel'.tr),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Future getImageFromGallery(index) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     // final bytes = Io.File(image.path).readAsBytesSync();

//     // String img64 = base64Encode(bytes);
//     // print(img64);

//     setState(() {
//       if (image != null) {
//         var a = {
//           index: image,
//         };
//         fileuploadvitalko(image, entry_id, index + 1).then((res) => {
//               print('res$res'),
//               if (res == 200)
//                 {
//                   imageupload.insert(index, image),
//                   imgfilecount++,
//                   setState(() {
//                     photolen++;
//                   }),
//                 }
//               else
//                 {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//             });
//       }
//     });
//   }

//   List<dynamic> imageupload = [
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     ''
//   ];
//   int imgfilecount = 0;
//   Future getImageFromCamera(index) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (image != null) {
//         var a = {
//           index: image,
//         };
//         setState(() {
//           imageupload.insert(index, image);
//         });
//         fileuploadvitalko(image, entry_id, index + 1).then((res) => {
//               print('res$res'),
//               if (res == 200)
//                 {
//                   imageupload.insert(index, image),
//                   imgfilecount++,
//                   setState(() {
//                     photolen++;
//                   }),
//                 }
//               else
//                 {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//             });
//       }
//     });
//   }

//   List<dynamic> filepdf = [
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     ''
//   ];

//   pdffilechooser(index) async {
//     FilePickerResult result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path);
//       
//       setState(() {
//         filepdf.insert(index, 'फाइल अपलोड भयो।  ');
//       });

//       fileuploadvitalko(file, entry_id, index + 1).then((res) => {
//             print('res$res'),
//             if (res == 200)
//               {
//                 filepdf.insert(index, 'फाइल अपलोड भयो।  '),
//                 imgfilecount++,
//                 setState(() {
//                   photolen++;
//                 }),
//               }
//             else
//               {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//           });
//       // User canceled the picker
//     }
//   }
// }
