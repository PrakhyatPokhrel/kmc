// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
// import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:kmc/config/colors.dart';
// import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:get/get.dart';
// import 'package:kmc/pages/vital/vitalphotostaticdata.dart';

// class Divorce extends StatefulWidget {
//   @override
//   _DivorceState createState() => _DivorceState();
// }

// class _DivorceState extends State<Divorce> {
//   //start
//   String _divorceCourtTypeSelected;

//   var _divorceProvince;
//   List _divorceDistricts = List();
//   var _selectedDivorceDistrict;
//   List _divorcelocallevel = List();
//   var _selectedDivorcelocallevel;

//   final _courtNumber = TextEditingController();

//   DateTime _eCourtDate = DateTime.now();
//   NepaliDateTime _nCourtDate = NepaliDateTime.now();
//   String _eCourtDateString;
//   String _nCourtDateString;

//   final _dartaNumber = TextEditingController();

//   final _boyName = TextEditingController();
//   final _boyMiddleName = TextEditingController();
//   final _boyThar = TextEditingController();
//   final _boyNameEnglish = TextEditingController();
//   final _boyMiddleNameEnglish = TextEditingController();
//   final _boyTharEnglish = TextEditingController();

//   DateTime _eBoyBirthDate = DateTime.now();
//   NepaliDateTime _nBoyBirthDate = NepaliDateTime.now();
//   String _eBoyBirthDateString;
//   String _nBoyBirthDateString;

//   final _boyBirthNumber = TextEditingController();

//   bool _boyCheckBox;

//   final _boyPassportNumber = TextEditingController();

//   var _boyForeignCountry;

//   final _boyCitizenNumber = TextEditingController();

//   var _boyCitizenProvince;
//   List _boyCitizenDistricts = List();
//   var _selectedBoyCitizenDistrict;
//   List _boyCitizenlocallevel = List();
//   var _selectedBoyCitizenlocallevel;

//   DateTime _eBoyCitizenDate = DateTime.now();
//   NepaliDateTime _nBoyCitizenDate = NepaliDateTime.now();
//   String _eBoyCitizenDateString;
//   String _nBoyCitizenDateString;

//   var _boyProvince;
//   List _boyDistricts = List();
//   var _selectedBoyDistrict;
//   List _boylocallevel = List();
//   var _selectedBoylocallevel;

//   final _boyWoda = TextEditingController();
//   final _boySadak = TextEditingController();
//   final _boyTol = TextEditingController();
//   final _boyGhar = TextEditingController();

//   final _boyEducation = TextEditingController();
//   final _boyJob = TextEditingController();
//   final _boyReligion = TextEditingController();
//   final _boyCaste = TextEditingController();
//   final _boyLanguage = TextEditingController();

//   final _boyBaajeName = TextEditingController();
//   final _boyBaajeNameEnglish = TextEditingController();
//   final _boyFatherName = TextEditingController();
//   final _boyFatherNameEnglish = TextEditingController();
//   final _boyMotherName = TextEditingController();
//   final _boyMotherNameEnglish = TextEditingController();

//   final _girlName = TextEditingController();
//   final _girlMiddleName = TextEditingController();
//   final _girlThar = TextEditingController();
//   final _girlNameEnglish = TextEditingController();
//   final _girlMiddleNameEnglish = TextEditingController();
//   final _girlTharEnglish = TextEditingController();

//   DateTime _eGirlBirthDate = DateTime.now();
//   NepaliDateTime _nGirlBirthDate = NepaliDateTime.now();
//   String _eGirlBirthDateString;
//   String _nGirlBirthDateString;

//   final _girlBirthNumber = TextEditingController();

//   bool _girlCheckBox;

//   final _girlPassportNumber = TextEditingController();

//   var _girlForeignCountry;

//   final _girlCitizenNumber = TextEditingController();

//   var _girlCitizenProvince;
//   List _girlCitizenDistricts = List();
//   var _selectedGirlCitizenDistrict;
//   List _girlCitizenlocallevel = List();
//   var _selectedGirlCitizenlocallevel;

//   DateTime _eGirlCitizenDate = DateTime.now();
//   NepaliDateTime _nGirlCitizenDate = NepaliDateTime.now();
//   String _eGirlCitizenDateString;
//   String _nGirlCitizenDateString;

//   var _girlProvince;
//   List _girlDistricts = List();
//   var _selectedGirlDistrict;
//   List _girllocallevel = List();
//   var _selectedGirllocallevel;

//   final _girlWoda = TextEditingController();
//   final _girlSadak = TextEditingController();
//   final _girlTol = TextEditingController();
//   final _girlGhar = TextEditingController();

//   final _girlEducation = TextEditingController();
//   final _girlJob = TextEditingController();
//   final _girlReligion = TextEditingController();
//   final _girlCaste = TextEditingController();
//   final _girlLanguage = TextEditingController();

//   final _girlBaajeName = TextEditingController();
//   final _girlBaajeNameEnglish = TextEditingController();
//   final _girlFatherName = TextEditingController();
//   final _girlFatherNameEnglish = TextEditingController();
//   final _girlMotherName = TextEditingController();
//   final _girlMotherNameEnglish = TextEditingController();

//   DateTime _eDivorceMarriageDate = DateTime.now();
//   NepaliDateTime _nDivorceMarriageDate = NepaliDateTime.now();
//   String _eDivorceMarriageDateString;
//   String _nDivorceMarriageDateString;

//   final _childNumber = TextEditingController();
//   final _aliveChildNumber = TextEditingController();
//   final _parentsSonNumber = TextEditingController();
//   final _parentsDaughterNumber = TextEditingController();

//   final _otherBoySonNumber = TextEditingController();
//   final _otherBoyDaughterNumber = TextEditingController();

//   final _otherGirlSonNumber = TextEditingController();
//   final _otherGirlDaughterNumber = TextEditingController();

//   final _divorceSuchakName = TextEditingController();
//   final _divorceSuchakMiddleName = TextEditingController();
//   final _divorceSuchakThar = TextEditingController();
//   final _divorceSuchakNameEnglish = TextEditingController();
//   final _divorceSuchakMiddleNameEnglish = TextEditingController();
//   final _divorceSuchakTharEnglish = TextEditingController();
//   final _divorceSuchakRelation = TextEditingController();

//   //suchak address here
//   bool _divorceSuchakCheckBox;
//   final _divorceSuchakPassportNumber = TextEditingController();

//   var _divorceSuchakForeignCountry;

//   var _divorceSuchakProvince;
//   List _divorceSuchakDistricts = List();
//   var _selectedDivorceSuchakDistrict;
//   List _divorceSuchaklocallevel = List();
//   var _selectedDivorceSuchaklocallevel;

//   final _divorceSuchakWoda = TextEditingController();
//   final _divorceSuchakSadak = TextEditingController();
//   final _divorceSuchakTol = TextEditingController();
//   final _divorceSuchakGhar = TextEditingController();
//   final _divorceSuchakCitizenNumber = TextEditingController();

//   var _divorceSuchakCitizenProvince;
//   List _divorceSuchakCitizenDistricts = List();
//   var _selectedDivorceSuchakCitizenDistrict;
//   List _divorceSuchakCitizenlocallevel = List();
//   var _selectedDivorceSuchakCitizenlocallevel;

//   NepaliDateTime _nDivorceSuchakCitizenDate = NepaliDateTime.now();
//   String _nDivorceSuchakCitizenDateString;

//   DateTime _eDivorceSuchakFormDate = DateTime.now();
//   NepaliDateTime _nDivorceSuchakFormDate = NepaliDateTime.now();
//   String _eDivorceSuchakFormDateString;
//   String _nDivorceSuchakFormDateString;

//   final _formFillerNumber = TextEditingController();
//   final _remarks = TextEditingController();
//   final _remarksEnglish = TextEditingController();

//   //end

//   List<Step> spr = <Step>[];

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
//         content: step1(),
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

//   var _divorceCourtType = ["जिल्ला अदालत", "पुनराबेदन अदालत", "सर्वोच्च अदालत"];

//   var _provinces = [
//     "1",
//     "2",
//     "3",
//     "4",
//     "5",
//     "6",
//     "7",
//   ];

//   Future<Null> selectedEnglishDate(BuildContext context, String data) async {
//     final DateTime picked = await showDatePicker(
//       initialDatePickerMode: DatePickerMode.year,
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1905),
//       lastDate: DateTime.now(),
//     );

//     if (_eCourtDate != null && picked != _eCourtDate ||
//         _eBoyBirthDate != null && picked != _eBoyBirthDate ||
//         _eBoyCitizenDate != null && picked != _eBoyCitizenDate ||
//         _eGirlBirthDate != null && picked != _eGirlBirthDate ||
//         _eDivorceMarriageDate != null && picked != _eDivorceMarriageDate ||
//         _eDivorceSuchakFormDate != null && picked != _eDivorceSuchakFormDate ||
//         _eGirlCitizenDate != null && picked != _eGirlCitizenDate) {
//       setState(() {
//         if (data == "eCourtDate") {
//           _eCourtDate = picked;
//           _eCourtDateString =
//               "${_eCourtDate.year}/${_eCourtDate.month}/${_eCourtDate.day}";
//           print("${_eCourtDate.year}/${_eCourtDate.month}/${_eCourtDate.day}");
//         } else if (data == "eBoyBirthDate") {
//           _eBoyBirthDate = picked;
//           _eBoyBirthDateString =
//               "${_eBoyBirthDate.year}/${_eBoyBirthDate.month}/${_eBoyBirthDate.day}";
//           print(
//               "${_eBoyBirthDate.year}/${_eBoyBirthDate.month}/${_eBoyBirthDate.day}");
//         } else if (data == "eBoyCitizenDate") {
//           _eBoyCitizenDate = picked;
//           _eBoyCitizenDateString =
//               "${_eBoyCitizenDate.year}/${_eBoyCitizenDate.month}/${_eBoyCitizenDate.day}";
//           print(
//               "${_eBoyCitizenDate.year}/${_eBoyCitizenDate.month}/${_eBoyCitizenDate.day}");
//         } else if (data == "eGirlBirthDate") {
//           _eGirlBirthDate = picked;
//           _eGirlBirthDateString =
//               "${_eGirlBirthDate.year}/${_eGirlBirthDate.month}/${_eGirlBirthDate.day}";
//           print(
//               "${_eGirlBirthDate.year}/${_eGirlBirthDate.month}/${_eGirlBirthDate.day}");
//         } else if (data == "eDivorceMarriageDate") {
//           _eDivorceMarriageDate = picked;
//           _eDivorceMarriageDateString =
//               "${_eDivorceMarriageDate.year}/${_eDivorceMarriageDate.month}/${_eDivorceMarriageDate.day}";
//           print(
//               "${_eDivorceMarriageDate.year}/${_eDivorceMarriageDate.month}/${_eDivorceMarriageDate.day}");
//         } else if (data == "eDivorceSuchakFormDate") {
//           _eDivorceSuchakFormDate = picked;
//           _eDivorceSuchakFormDateString =
//               "${_eDivorceSuchakFormDate.year}/${_eDivorceSuchakFormDate.month}/${_eDivorceSuchakFormDate.day}";
//           print(
//               "${_eDivorceSuchakFormDate.year}/${_eDivorceSuchakFormDate.month}/${_eDivorceSuchakFormDate.day}");
//         } else if (data == "eGirlCitizenDate") {
//           _eGirlCitizenDate = picked;
//           _eGirlCitizenDateString =
//               "${_eGirlCitizenDate.year}/${_eGirlCitizenDate.month}/${_eGirlCitizenDate.day}";
//           print(
//               "${_eGirlCitizenDate.year}/${_eGirlCitizenDate.month}/${_eGirlCitizenDate.day}");
//         } else {
//           print("not found");
//         }
//       });
//     }
//   }

//   Future<Null> selectNepaliDate(BuildContext context, String data) async {
//     final NepaliDateTime picked = await picker.showMaterialDatePicker(
//       context: context,
//       initialDate: NepaliDateTime.now(),
//       firstDate: NepaliDateTime(2000),
//       lastDate: NepaliDateTime.now(),
//       initialDatePickerMode: DatePickerMode.year,
//     );
//     if (_nCourtDate != null && picked != _nCourtDate ||
//         _nBoyBirthDate != null && picked != _nBoyBirthDate ||
//         _nBoyCitizenDate != null && picked != _nBoyCitizenDate ||
//         _nGirlBirthDate != null && picked != _nGirlBirthDate ||
//         _nDivorceMarriageDate != null && picked != _nDivorceMarriageDate ||
//         _nDivorceSuchakCitizenDate != null &&
//             picked != _nDivorceSuchakCitizenDate ||
//         _nDivorceSuchakFormDate != null && picked != _nDivorceSuchakFormDate ||
//         _nGirlCitizenDate != null && picked != _nGirlCitizenDate) {
//       setState(() {
//         if (data == "nCourtDate") {
//           _nCourtDate = picked;
//           _nCourtDateString =
//               "${_nCourtDate.year}/${_nCourtDate.month}/${_nCourtDate.day}";
//           print("${_nCourtDate.year}/${_nCourtDate.month}/${_nCourtDate.day}");
//         } else if (data == "nBoyBirthDate") {
//           _nBoyBirthDate = picked;
//           _nBoyBirthDateString =
//               "${_nBoyBirthDate.year}/${_nBoyBirthDate.month}/${_nBoyBirthDate.day}";
//           print(
//               "${_nBoyBirthDate.year}/${_nBoyBirthDate.month}/${_nBoyBirthDate.day}");
//         } else if (data == "nBoyCitizenDate") {
//           _nBoyCitizenDate = picked;
//           _nBoyCitizenDateString =
//               "${_nBoyCitizenDate.year}/${_nBoyCitizenDate.month}/${_nBoyCitizenDate.day}";
//           print(
//               "${_nBoyCitizenDate.year}/${_nBoyCitizenDate.month}/${_nBoyCitizenDate.day}");
//         } else if (data == "nGirlBirthDate") {
//           _nGirlBirthDate = picked;
//           _nGirlBirthDateString =
//               "${_nGirlBirthDate.year}/${_nGirlBirthDate.month}/${_nGirlBirthDate.day}";
//           print(
//               "${_nGirlBirthDate.year}/${_nGirlBirthDate.month}/${_nGirlBirthDate.day}");
//         } else if (data == "nDivorceMarriageDate") {
//           _nDivorceMarriageDate = picked;
//           _nDivorceMarriageDateString =
//               "${_nDivorceMarriageDate.year}/${_nDivorceMarriageDate.month}/${_nDivorceMarriageDate.day}";
//           print(
//               "${_nDivorceMarriageDate.year}/${_nDivorceMarriageDate.month}/${_nDivorceMarriageDate.day}");
//         } else if (data == "nDivorceSuchakCitizenDate") {
//           _nDivorceSuchakCitizenDate = picked;
//           _nDivorceSuchakCitizenDateString =
//               "${_nDivorceSuchakCitizenDate.year}/${_nDivorceSuchakCitizenDate.month}/${_nDivorceSuchakCitizenDate.day}";
//           print(
//               "${_nDivorceSuchakCitizenDate.year}/${_nDivorceSuchakCitizenDate.month}/${_nDivorceSuchakCitizenDate.day}");
//         } else if (data == "nDivorceSuchakFormDate") {
//           _nDivorceSuchakFormDate = picked;
//           _nDivorceSuchakFormDateString =
//               "${_nDivorceSuchakFormDate.year}/${_nDivorceSuchakFormDate.month}/${_nDivorceSuchakFormDate.day}";
//           print(
//               "${_nDivorceSuchakFormDate.year}/${_nDivorceSuchakFormDate.month}/${_nDivorceSuchakFormDate.day}");
//         } else if (data == "nGirlCitizenDate") {
//           _nGirlCitizenDate = picked;
//           _nGirlCitizenDateString =
//               "${_nGirlCitizenDate.year}/${_nGirlCitizenDate.month}/${_nGirlCitizenDate.day}";
//           print(
//               "${_nGirlCitizenDate.year}/${_nGirlCitizenDate.month}/${_nGirlCitizenDate.day}");
//         } else {
//           print("not found");
//         }
//       });
//     }
//   }

//   final _formKey = GlobalKey<FormState>();
//   var divorce_court_type;
//   var requiredfiledlist;
//   List array = [];
//   ScrollController _scrollController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _boyCheckBox = false;
//     _girlCheckBox = false;
//     _divorceSuchakCheckBox = false;
//     coutryapi();
//     districtApi();
//     localLevelApi();

//     VITAL_PHOTO_LIST[3]['fields'].forEach((key, value) {
//       print(key);
//      
//       if (value != null) {
//         requiredfiledlist = {'key': "$key", 'value': "$value"};
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
//                 Text('DIVORCE'.tr + ' ' + 'REPORT'.tr,
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
//         body: Container(
//           height: Get.height * 0.95,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Theme(
//               data: ThemeData(
//                   shadowColor: Colors.transparent,
//                   accentColor: tertiary,
//                   colorScheme: ColorScheme.light(primary: tertiary)),
//               child: Stepper(
//                 physics: ClampingScrollPhysics(),
//                 controlsBuilder: (BuildContext context,
//                     {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//                   return ConstrainedBox(
//                     constraints: BoxConstraints(maxHeight: 60),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 20),
//                           child: SizedBox(
//                             width: stepperType == StepperType.horizontal
//                                 ? Get.width * 0.75
//                                 : Get.width * 0.60,
//                             height: 40,
//                             child: ElevatedButton.icon(
//                                 onPressed: () {
//                                   if (currentStep == 0) {
//                                     setState(() {
//                                       _scrollToTop();
//                                     });
//                                     divorceformsubmit();
//                                   } else if (currentStep == 1) {
//                                     setState(() {
//                                       _scrollToTop();
//                                     });
//                                     onStepContinue();
//                                   }
//                                   if (currentStep == 2) {
//                                     setState(() {
//                                       _scrollToTop();
//                                     });
//                                     onStepContinue();
//                                   }
//                                 },
//                                 // onPressed: onStepContinue,
//                                 icon: Icon(Icons.upload),
//                                 label: Text('SEND'.tr),
//                                 style: ButtonStyle(
//                                     shape: MaterialStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30.0),
//                                 )))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 steps: _getSteps(context),
//                 type: stepperType,
//                 currentStep: currentStep,
//                 onStepContinue: next,
//                 onStepTapped: (step) {
//                   goTo(step);
//                 },
//                 onStepCancel: cancel,
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
//                   "सम्बन्ध विच्छेद सम्बन्धी विवरण",
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
//               labelText('सम्बन्ध बिच्छेदको निर्णय गर्ने अदालत को किसिम'),
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
//                       items: _divorceCourtType.map((item) {
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
//                           this._divorceCourtTypeSelected = value;
//                         });
//                       },
//                       value: _divorceCourtTypeSelected,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("अदालत को प्रदेश"),
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
//                           _divorceDistricts = _district[value];
//                           print(_district[value]);
//                           this._divorceProvince = value;
//                           print(_divorceProvince);
//                           _selectedDivorceDistrict = null;
//                           _selectedDivorcelocallevel = null;
//                         });
//                       },
//                       value: _divorceProvince,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText("अदालत को जिल्ला"),
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
//                       items: _divorceDistricts.map((item) {
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
//                           _divorcelocallevel = _localLevel[value];
//                           this._selectedDivorceDistrict = value;
//                          
//                           _selectedDivorcelocallevel = null;
//                         });
//                       },
//                       value: _selectedDivorceDistrict,
//                     ),
//                   ),
//                 ),
//               ),
//               labelText('अदालतको निर्णय नं'),
//               TextFormField(
//                 controller: _courtNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('अदालतको निर्णय मिति (साल-महिना-गते)'),
//               Column(
//                 children: [
//                   labelText('वि.सं. मा '),
//                   GestureDetector(
//                     onTap: () async {
//                       selectNepaliDate(context, "nCourtDate");
//                       print(
//                           "${_nCourtDate.year}-${_nCourtDate.month}-${_nCourtDate.day}");
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: white,
//                           borderRadius: BorderRadius.circular(5.0)),
//                       height: Get.height * 0.05,
//                       width: Get.width * 0.3,
//                       child: Center(
//                         child: Text(
//                             '${_nCourtDate.year}-${_nCourtDate.month}-${_nCourtDate.day}'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('बिबाह दर्ता नं'),
//               TextFormField(
//                 controller: _dartaNumber,
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
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'पतिको विवरण',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('पहिलो नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyMiddleName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyThar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पहिलो नाम (in English)'),
//               TextFormField(
//                 controller: _boyNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (in English)'),
//               TextFormField(
//                 controller: _boyMiddleNameEnglish,
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
//                 controller: _boyTharEnglish,
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
//                           labelText('ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eBoyBirthDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eBoyBirthDate.year}-${_eBoyBirthDate.month}-${_eBoyBirthDate.day}"),
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
//                             selectNepaliDate(context, "nBoyBirthDate");
//                             print(
//                                 "${_nBoyBirthDate.year}-${_nBoyBirthDate.month}-${_nBoyBirthDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nBoyBirthDate.year}-${_nBoyBirthDate.month}-${_nBoyBirthDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('जन्म दर्ता नं'),
//               TextFormField(
//                 controller: _boyBirthNumber,
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
//                 value: _boyCheckBox,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _boyCheckBox = value;
//                   });
//                 },
//               ),
//               _boyCheckBox == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("पासपोर्ट नम्बर"),
//                         TextFormField(
//                           controller: _boyPassportNumber,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
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
//                                     this._boyForeignCountry = value;
//                                   });
//                                 },
//                                 value: _boyForeignCountry),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("नागरिकता नं"),
//                           TextFormField(
//                             controller: _boyCitizenNumber,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("नागरिकता जारी प्रदेश"),
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
//                                       _boyCitizenDistricts = _district[value];
//                                       this._boyCitizenProvince = value;
//                                       print(_boyCitizenProvince);
//                                       _selectedBoyCitizenDistrict = null;
//                                       _selectedBoyCitizenlocallevel = null;
//                                     });
//                                   },
//                                   value: _boyCitizenProvince,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _boyCitizenDistricts.map((item) {
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
//                                       _boyCitizenlocallevel =
//                                           _localLevel[value];
//                                       this._selectedBoyCitizenDistrict = value;
//                                      
//                                       _selectedBoyCitizenlocallevel = null;
//                                     });
//                                   },
//                                   value: _selectedBoyCitizenDistrict,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _boyCitizenlocallevel.map((item) {
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
//                                       this._selectedBoyCitizenlocallevel =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value: _selectedBoyCitizenlocallevel,
//                                 ),
//                               ),
//                             ),
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
//                                               context, "eBoyCitizenDate");
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
//                                               "${_eBoyCitizenDate.year}-${_eBoyCitizenDate.month}-${_eBoyCitizenDate.day}"),
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
//                                             context, "nBoyCitizenDate");
//                                         print(
//                                             "${_nBoyCitizenDate.year}-${_nBoyCitizenDate.month}-${_nBoyCitizenDate.day}");
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
//                                               '${_nBoyCitizenDate.year}-${_nBoyCitizenDate.month}-${_nBoyCitizenDate.day}'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Center(
//                             child: Text(
//                               'सम्बन्ध विच्छेद हुनु अगाडिको ठेगाना',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 24.0,
//                                 color: primary,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
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
//                                       _boyDistricts = _district[value];
//                                       this._boyProvince = value;
//                                       print(_boyProvince);
//                                       _selectedBoyDistrict = null;
//                                       _selectedBoylocallevel = null;
//                                     });
//                                   },
//                                   value: _boyProvince,
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
//                                   items: _boyDistricts.map((item) {
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
//                                       _boylocallevel = _localLevel[value];
//                                       this._selectedBoyDistrict = value;
//                                      
//                                       _selectedBoylocallevel = null;
//                                     });
//                                   },
//                                   value: _selectedBoyDistrict,
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
//                                   items: _boylocallevel.map((item) {
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
//                                       this._selectedBoylocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: _selectedBoylocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("वडा"),
//                           TextFormField(
//                             controller: _boyWoda,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("सडक/ मार्ग"),
//                           TextFormField(
//                             controller: _boySadak,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("गाउँ/टोल"),
//                           TextFormField(
//                             controller: _boyTol,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("घर नं"),
//                           TextFormField(
//                             controller: _boyGhar,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ]),
//               labelText("शिक्षाको उतिर्ण स्तर"),
//               TextFormField(
//                 controller: _boyEducation,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पेशा'),
//               TextFormField(
//                 controller: _boyJob,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText("धर्म"),
//               TextFormField(
//                 controller: _boyReligion,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('जात / जाती'),
//               TextFormField(
//                 controller: _boyCaste,
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
//                 controller: _boyLanguage,
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
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'पतिको परिवारको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('बाजेको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyBaajeName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _boyBaajeNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyFatherName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _boyFatherNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _boyMotherName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _boyMotherNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),

//               //girl start here

//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'पत्नीको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('पहिलो नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlMiddleName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlThar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पहिलो नाम (in English)'),
//               TextFormField(
//                 controller: _girlNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (in English)'),
//               TextFormField(
//                 controller: _girlMiddleNameEnglish,
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
//                 controller: _girlTharEnglish,
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
//                           labelText('ई.सं. मा'),
//                           GestureDetector(
//                             onTap: () {
//                               selectedEnglishDate(context, "eGirlBirthDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eGirlBirthDate.year}-${_eGirlBirthDate.month}-${_eGirlBirthDate.day}"),
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
//                             selectNepaliDate(context, "nGirlBirthDate");
//                             print(
//                                 "${_nGirlBirthDate.year}-${_nGirlBirthDate.month}-${_nGirlBirthDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nGirlBirthDate.year}-${_nGirlBirthDate.month}-${_nGirlBirthDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('जन्म दर्ता नं'),
//               TextFormField(
//                 controller: _girlBirthNumber,
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
//                 value: _girlCheckBox,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _girlCheckBox = value;
//                   });
//                 },
//               ),
//               _girlCheckBox == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("पासपोर्ट नम्बर"),
//                         TextFormField(
//                           controller: _girlPassportNumber,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
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
//                                     this._girlForeignCountry = value;
//                                   });
//                                 },
//                                 value: _girlForeignCountry),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           labelText("नागरिकता नं"),
//                           TextFormField(
//                             controller: _girlCitizenNumber,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("नागरिकता जारी प्रदेश"),
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
//                                       _girlCitizenDistricts = _district[value];
//                                       this._girlCitizenProvince = value;
//                                       print(_girlCitizenProvince);
//                                       _selectedGirlCitizenDistrict = null;
//                                       _selectedGirlCitizenlocallevel = null;
//                                     });
//                                   },
//                                   value: _girlCitizenProvince,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _girlCitizenDistricts.map((item) {
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
//                                       _girlCitizenlocallevel =
//                                           _localLevel[value];
//                                       this._selectedGirlCitizenDistrict = value;
//                                      
//                                       _selectedGirlCitizenlocallevel = null;
//                                     });
//                                   },
//                                   value: _selectedGirlCitizenDistrict,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _girlCitizenlocallevel.map((item) {
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
//                                       this._selectedGirlCitizenlocallevel =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value: _selectedGirlCitizenlocallevel,
//                                 ),
//                               ),
//                             ),
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
//                                               context, "eGirlCitizenDate");
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
//                                               "${_eGirlCitizenDate.year}-${_eGirlCitizenDate.month}-${_eGirlCitizenDate.day}"),
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
//                                             context, "nGirlCitizenDate");
//                                         print(
//                                             "${_nGirlCitizenDate.year}-${_nGirlCitizenDate.month}-${_nGirlCitizenDate.day}");
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
//                                               '${_nGirlCitizenDate.year}-${_nGirlCitizenDate.month}-${_nGirlCitizenDate.day}'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Center(
//                             child: Text(
//                               'सम्बन्ध विच्छेद हुनु अगाडिको ठेगाना',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 24.0,
//                                 color: primary,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
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
//                                       _girlDistricts = _district[value];
//                                       this._girlProvince = value;
//                                       print(_girlProvince);
//                                       _selectedGirlDistrict = null;
//                                       _selectedGirllocallevel = null;
//                                     });
//                                   },
//                                   value: _girlProvince,
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
//                                   items: _girlDistricts.map((item) {
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
//                                       _girllocallevel = _localLevel[value];
//                                       this._selectedGirlDistrict = value;
//                                      
//                                       _selectedGirllocallevel = null;
//                                     });
//                                   },
//                                   value: _selectedGirlDistrict,
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
//                                   items: _girllocallevel.map((item) {
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
//                                       this._selectedGirllocallevel = value;
//                                      
//                                     });
//                                   },
//                                   value: _selectedGirllocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("वडा"),
//                           TextFormField(
//                             controller: _girlWoda,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("सडक/ मार्ग"),
//                           TextFormField(
//                             controller: _girlSadak,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("गाउँ/टोल"),
//                           TextFormField(
//                             controller: _girlTol,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("घर नं"),
//                           TextFormField(
//                             controller: _girlGhar,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ]),
//               labelText("शिक्षाको उतिर्ण स्तर"),
//               TextFormField(
//                 controller: _girlEducation,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पेशा'),
//               TextFormField(
//                 controller: _girlJob,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText("धर्म"),
//               TextFormField(
//                 controller: _girlReligion,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('जात / जाती'),
//               TextFormField(
//                 controller: _girlCaste,
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
//                 controller: _girlLanguage,
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
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'पत्नीको परिवारको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('बाजेको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlBaajeName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाजेको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _girlBaajeNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlFatherName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बाबुको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _girlFatherNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको पुरा नाम थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _girlMotherName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमाको पुरा नाम थर (in English)'),
//               TextFormField(
//                 controller: _girlMotherNameEnglish,
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
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'पति-पत्नीको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('बिबाह भएको मिति (साल- महिना- गते)'),
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
//                                   context, "eDivorceMarriageDate");
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Text(
//                                   "${_eDivorceMarriageDate.year}-${_eDivorceMarriageDate.month}-${_eDivorceMarriageDate.day}"),
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
//                             selectNepaliDate(context, "nDivorceMarriageDate");
//                             print(
//                                 "${_nDivorceMarriageDate.year}-${_nDivorceMarriageDate.month}-${_nDivorceMarriageDate.day}");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Center(
//                               child: Text(
//                                   '${_nDivorceMarriageDate.year}-${_nDivorceMarriageDate.month}-${_nDivorceMarriageDate.day}'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('बैबाहिक सम्बन्ध बाट पाएको सन्तानको संख्या'),
//               TextFormField(
//                 controller: _childNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('हाल सम्म जीवित सन्तानको संख्या'),
//               TextFormField(
//                 controller: _aliveChildNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमा बाबु संग बसेको छोराको संख्या'),
//               TextFormField(
//                 controller: _parentsSonNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('आमा बाबु संग बसेको छोरीको संख्या'),
//               TextFormField(
//                 controller: _parentsDaughterNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पतिको अन्य ब्यक्तिसंग बसेको छोराको संख्या'),
//               TextFormField(
//                 controller: _otherBoySonNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पतिको अन्य ब्यक्तिसंग बसेको छोरीको संख्या'),
//               TextFormField(
//                 controller: _otherBoyDaughterNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पत्नी को अन्य ब्यक्तिसंग बसेको छोराको संख्या'),
//               TextFormField(
//                 controller: _otherGirlSonNumber,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पत्नी को अन्य ब्यक्तिसंग बसेको छोरीको संख्या'),
//               TextFormField(
//                 controller: _otherGirlDaughterNumber,
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
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'सूचकको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Text(
//                 'यसमा लेखेको विवरण साँचो हो । झुट्ठा ठहरे कानून बमोजिम सहुँला बुझाउँला।',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: primary,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               labelText('पहिलो नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _divorceSuchakName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (नेपालीमा)'),
//               TextFormField(
//                 controller: _divorceSuchakMiddleName,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('थर (नेपालीमा)'),
//               TextFormField(
//                 controller: _divorceSuchakThar,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('पहिलो नाम (in English)'),
//               TextFormField(
//                 controller: _divorceSuchakNameEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('बिचको नाम (in English)'),
//               TextFormField(
//                 controller: _divorceSuchakMiddleNameEnglish,
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
//                 controller: _divorceSuchakTharEnglish,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               labelText('नाता'),
//               TextFormField(
//                 controller: _divorceSuchakRelation,
//                 autofocus: false,
//                 decoration: inputTheme(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//               ),
//               //TODO
//               CheckboxListTile(
//                 title: labelText("विदेशी हो"),
//                 value: _divorceSuchakCheckBox,
//                 controlAffinity: ListTileControlAffinity.leading,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _divorceSuchakCheckBox = value;
//                   });
//                 },
//               ),
//               _divorceSuchakCheckBox == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         labelText("पासपोर्ट नम्बर"),
//                         TextFormField(
//                           controller: _divorceSuchakPassportNumber,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
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
//                                     this._divorceSuchakForeignCountry = value;
//                                   });
//                                 },
//                                 value: _divorceSuchakForeignCountry),
//                           ),
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
//                                       _divorceSuchakDistricts =
//                                           _district[value];
//                                       this._divorceSuchakProvince = value;
//                                       print(_divorceSuchakProvince);
//                                       _selectedDivorceSuchakDistrict = null;
//                                       _selectedDivorceSuchaklocallevel = null;
//                                     });
//                                   },
//                                   value: _divorceSuchakProvince,
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
//                                   items: _divorceSuchakDistricts.map((item) {
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
//                                       _divorceSuchaklocallevel =
//                                           _localLevel[value];
//                                       this._selectedDivorceSuchakDistrict =
//                                           value;
//                                      
//                                       _selectedDivorceSuchaklocallevel = null;
//                                     });
//                                   },
//                                   value: _selectedDivorceSuchakDistrict,
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
//                                   items: _divorceSuchaklocallevel.map((item) {
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
//                                       this._selectedDivorceSuchaklocallevel =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value: _selectedDivorceSuchaklocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText("वडा"),
//                           TextFormField(
//                             controller: _divorceSuchakWoda,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("सडक/ मार्ग"),
//                           TextFormField(
//                             controller: _divorceSuchakSadak,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("गाउँ/टोल"),
//                           TextFormField(
//                             controller: _divorceSuchakTol,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("घर नं"),
//                           TextFormField(
//                             controller: _divorceSuchakGhar,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           labelText("नागरिकता नं"),
//                           TextFormField(
//                             controller: _divorceSuchakCitizenNumber,
//                             autofocus: false,
//                             decoration: inputTheme(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                           //TODO
//                           labelText("नागरिकता जारी प्रदेश"),
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
//                                       _divorceSuchakCitizenDistricts =
//                                           _district[value];
//                                       this._divorceSuchakCitizenProvince =
//                                           value;
//                                       print(_divorceSuchakCitizenProvince);
//                                       _selectedDivorceSuchakCitizenDistrict =
//                                           null;
//                                       _selectedDivorceSuchakCitizenlocallevel =
//                                           null;
//                                     });
//                                   },
//                                   value: _divorceSuchakCitizenProvince,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _divorceSuchakCitizenDistricts
//                                       .map((item) {
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
//                                       _divorceSuchakCitizenlocallevel =
//                                           _localLevel[value];
//                                       this._selectedDivorceSuchakCitizenDistrict =
//                                           value;
//                                      
//                                       _selectedDivorceSuchakCitizenlocallevel =
//                                           null;
//                                     });
//                                   },
//                                   value: _selectedDivorceSuchakCitizenDistrict,
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
//                                     "Select",
//                                   ),
//                                   isExpanded: true,
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   items: _divorceSuchakCitizenlocallevel
//                                       .map((item) {
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
//                                       this._selectedDivorceSuchakCitizenlocallevel =
//                                           value;
//                                      
//                                     });
//                                   },
//                                   value:
//                                       _selectedDivorceSuchakCitizenlocallevel,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Column(
//                                   children: [
//                                     labelText('वि.सं. मा '),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         selectNepaliDate(context,
//                                             "nDivorceSuchakCitizenDate");
//                                         print(
//                                             "${_nDivorceSuchakCitizenDate.year}-${_nDivorceSuchakCitizenDate.month}-${_nDivorceSuchakCitizenDate.day}");
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
//                                               '${_nDivorceSuchakCitizenDate.year}-${_nDivorceSuchakCitizenDate.month}-${_nDivorceSuchakCitizenDate.day}'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: Text(
//                   'फारम भर्नेको विवरण',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     color: primary,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               labelText('फारम भरेको मिति (साल- महिना- गते)'),
//               Column(
//                 children: [
//                   labelText('वि.सं. मा '),
//                   GestureDetector(
//                     onTap: () async {
//                       selectNepaliDate(context, "nDivorceSuchakFormDate");
//                       print(
//                           "${_nDivorceSuchakFormDate.year}-${_nDivorceSuchakFormDate.month}-${_nDivorceSuchakFormDate.day}");
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: white,
//                           borderRadius: BorderRadius.circular(5.0)),
//                       height: Get.height * 0.05,
//                       width: Get.width * 0.3,
//                       child: Center(
//                         child: Text(
//                             '${_nDivorceSuchakFormDate.year}-${_nDivorceSuchakFormDate.month}-${_nDivorceSuchakFormDate.day}'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               labelText('फारम भर्नेको नम्बर'),
//               TextFormField(
//                 controller: _formFillerNumber,
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
//                 controller: _remarks,
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
//                 controller: _remarksEnglish,
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

//               // Container(
//               //   height: Get.height * 0.5,
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     crossAxisAlignment: CrossAxisAlignment.center,
//               //     children: <Widget>[
//               //       Padding(
//               //         padding: const EdgeInsets.only(top: 20),
//               //         child: SizedBox(
//               //           width: stepperType == StepperType.horizontal
//               //               ? Get.width * 0.75
//               //               : Get.width * 0.60,
//               //           height: 40,
//               //           child:
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   divorceformsubmit() {
//     _formKey.currentState.save();
//     if (!_formKey.currentState.validate()) {
//       var divorceData = {
//         "alive_child_number": _aliveChildNumber.text,
//         "boy_baaje_name": _boyBaajeName.text,
//         "boy_baaje_name_english": _boyBaajeNameEnglish.text,
//         "boy_birth_date": _nBoyBirthDateString,
//         "boy_birth_number": _boyBirthNumber.text,
//         "boy_caste": _boyCaste.text,
//         "boy_citizen_date": _nBoyCitizenDateString,
//         "boy_citizen_jilla": _selectedBoyCitizenDistrict,
//         "boy_citizen_number": _boyCitizenNumber.text,
//         "boy_citizen_pradesh": _boyCitizenProvince,
//         "boy_citizen_sthaniyataha": _selectedBoyCitizenlocallevel,
//         "boy_country": null,
//         // "boy_daughter_number":
//         "boy_education": _boyEducation.text,
//         "boy_father_name": _boyFatherName.text,
//         "boy_father_name_english": _boyFatherNameEnglish.text,
//         "boy_foreign_country": null,
//         "boy_foreign_country_english": _boyForeignCountry,
//         "boy_gabisa_nepali": _selectedBoyCitizenlocallevel,
//         "boy_ghar_nepali": _boyGhar.text,
//         "boy_jilla_nepali": _selectedBoyDistrict,
//         "boy_job": _boyJob.text,
//         "boy_language": _boyLanguage.text,
//         "boy_middle_name": _boyMiddleName.text,
//         "boy_middle_name_english": _boyMiddleNameEnglish.text,
//         "boy_mother_name": _boyMotherName.text,
//         "boy_mother_name_english": _boyMotherNameEnglish.text,
//         "boy_name": _boyName.text,
//         "boy_name_english": _boyNameEnglish.text,
//         //  boy_passport_date
//         //  boy_passport_date_english
//         "boy_passport_number": _boyPassportNumber.text,
//         //  boy_passport_number_english
//         "boy_pradesh": _boyProvince,
//         "boy_religion": _boyReligion.text,
//         // boy_sadak_english
//         "boy_sadak_nepali": _boySadak.text,
//         //boy_son_number
//         "boy_thar": _boyThar.text,
//         "boy_thar_english": _boyTharEnglish.text,
//         //boy_tol_english
//         "boy_tol_nepali": _boyTol.text,
//         //boy_woda_english
//         "boy_woda_nepali": _boyWoda.text,
//         "child_number": _childNumber.text,
//         "court_date_nepali": _nCourtDateString,
//         "court_number": _courtNumber.text,
//         "darta_number": _dartaNumber.text,
//         "divorce_court_type": _divorceCourtTypeSelected,
//         "divorce_jilla": _selectedDivorceDistrict,
//         "divorce_marriage_date_english": _eDivorceMarriageDateString,
//         "divorce_marriage_date_nepali": _nDivorceMarriageDateString,
//         "divorce_pradesh": _divorceProvince,
//         "divorce_suchak_citizen_jilla": _selectedDivorceSuchakCitizenDistrict,
//         "divorce_suchak_citizen_pradesh": _divorceSuchakCitizenProvince,
//         "divorce_suchak_citizen_sthaniyataha":
//             _selectedDivorceSuchakCitizenlocallevel,
//         "divorce_suchak_date": _nDivorceSuchakCitizenDateString,
//         "divorce_suchak_foreign_country": null,
//         "divorce_suchak_foreign_country_english": _divorceSuchakForeignCountry,
//         "divorce_suchak_form_date": _eDivorceSuchakFormDateString,
//         "divorce_suchak_gabisa": _selectedDivorceSuchaklocallevel,
//         "divorce_suchak_ghar": _divorceSuchakGhar.text,
//         "divorce_suchak_jilla": _selectedDivorceSuchakDistrict,
//         "divorce_suchak_middle_name": _divorceSuchakMiddleName.text,
//         "divorce_suchak_middle_name_english":
//             _divorceSuchakMiddleNameEnglish.text,
//         "divorce_suchak_name": _divorceSuchakName.text,
//         "divorce_suchak_name_english": _divorceSuchakNameEnglish.text,
//         "divorce_suchak_number": _divorceSuchakCitizenNumber.text,
//         "divorce_suchak_passport_number": _divorceSuchakPassportNumber.text,
//         // "divorce_suchak_passport_number_english": , //TODO-passport no. in english not defined
//         "divorce_suchak_pradesh": _divorceSuchakProvince,
//         "divorce_suchak_relation": _divorceSuchakRelation.text,
//         "divorce_suchak_sadak": _divorceSuchakSadak.text,
//         "divorce_suchak_thar": _divorceSuchakThar.text,
//         "divorce_suchak_thar_english": _divorceSuchakTharEnglish.text,
//         "divorce_suchak_tol": _divorceSuchakTol.text,
//         "divorce_suchak_woda": _divorceSuchakWoda.text,
//         "form_filler_number": _formFillerNumber.text,
//         "girl_baaje_name": _girlBaajeName.text,
//         "girl_baaje_name_english": _girlBaajeNameEnglish.text,
//         "girl_birth_date": _nGirlBirthDateString,
//         "girl_birth_number": _girlBirthNumber.text,
//         "girl_caste": _girlCaste.text,
//         // "girl_check_box": _girlCheckBox,
//         "girl_citizen_date": _nGirlCitizenDateString,
//         "girl_citizen_jilla": _selectedGirlCitizenDistrict,
//         "girl_citizen_number": _girlCitizenNumber.text,
//         "girl_citizen_pradesh": _girlCitizenProvince,
//         "girl_citizen_sthaniyataha": _selectedGirlCitizenlocallevel,
//         "girl_country": null,
//         //girl_daughter_number
//         "girl_education": _girlEducation.text,
//         "girl_father_name": _girlFatherName.text,
//         "girl_father_name_english": _girlFatherNameEnglish.text,
//         "girl_foreign_country": null,
//         "girl_foreign_country_english": _girlForeignCountry,
//         //girl_gabisa_english
//         "girl_gabisa_nepali": _selectedGirlCitizenlocallevel,
//         // "girl_ghar_english":
//         "girl_ghar_nepali": _girlGhar.text,
//         // girl_jilla_english
//         "girl_jilla_nepali": _selectedGirlDistrict,
//         "girl_job": _girlJob.text,
//         "girl_language": _girlLanguage.text,
//         "girl_middle_name": _girlMiddleName.text,
//         "girl_middle_name_english": _girlMiddleNameEnglish.text,
//         "girl_mother_name": _girlMotherName.text,
//         "girl_mother_name_english": _girlMotherNameEnglish.text,
//         "girl_name": _girlName.text,
//         "girl_name_english": _girlNameEnglish.text,
//         // girl_passport_date
//         // girl_passport_date_english
//         "girl_passport_number": _girlPassportNumber.text,
//         // girl_passport_number_english
//         "girl_pradesh": _girlProvince,
//         "girl_religion": _girlReligion.text,
//         // girl_sadak_english
//         "girl_sadak_nepali": _girlSadak.text,
//         // girl_son_number
//         "girl_thar": _girlThar.text,
//         "girl_thar_english": _girlTharEnglish.text,
//         // girl_tol_english
//         "girl_tol_nepali": _girlTol.text,
//         // "girl_woda_english"
//         "girl_woda_nepali": _girlWoda.text,
//         "other_boy_daughter_number": _otherBoyDaughterNumber.text,
//         "other_boy_son_number": _otherBoySonNumber.text,
//         "other_girl_daughter_number": _otherGirlDaughterNumber.text,
//         "other_girl_son_number": _otherGirlSonNumber.text,
//         "parents_daughter_number": _parentsDaughterNumber.text,
//         "parents_son_number": _parentsSonNumber.text,
//         "remarks": _remarks.text,
//         "remarks_english": _remarksEnglish.text,
//       };
//       var dummy_data = {
//         "alive_child_number": "3",
//         "boy_baaje_name": "नाम",
//         "boy_baaje_name_english": "नाम",
//         "boy_birth_date": "2021-02-17",
//         "boy_birth_number": "122",
//         "boy_caste": "k",
//         "boy_citizen_date": null,
//         "boy_citizen_jilla": null,
//         "boy_citizen_number": null,
//         "boy_citizen_pradesh": null,
//         "boy_citizen_sthaniyataha": null,
//         "boy_country": null,
//         "boy_education": "test",
//         "boy_father_name": "नाम",
//         "boy_father_name_english": "name",
//         "boy_foreign_country": "Antigua and Barbuda",
//         "boy_gabisa_nepali": null,
//         "boy_ghar_nepali": null,
//         "boy_jilla_nepali": null,
//         "boy_job": "k",
//         "boy_language": "k",
//         "boy_middle_name": "नाम",
//         "boy_middle_name_english": "name",
//         "boy_mother_name": "name",
//         "boy_mother_name_english": "name",
//         "boy_name": "नाम",
//         "boy_name_english": "name",
//         "boy_passport_number": "236",
//         "boy_pradesh": "1",
//         "boy_religion": "k",
//         "boy_sadak_nepali": null,
//         "boy_thar": "नाम",
//         "boy_thar_english": "name",
//         "boy_tol_nepali": null,
//         "boy_woda_nepali": null,
//         "child_number": "3",
//         "court_date_nepali": "1940-1-1",
//         "court_number": "123",
//         "darta_number": "345",
//         "divorce_court_type": "punarabedan",
//         "divorce_jilla": "Jhapa",
//         "divorce_marriage_date_english": "2021-02-17",
//         "divorce_marriage_date_nepali": "1940-1-1",
//         // "divorce_suchak_check_box": true,
//         "divorce_suchak_citizen_jilla": null,
//         "divorce_suchak_pradesh": null,
//         "divorce_suchak_sthaniyataha": null,
//         "divorce_suchak_date": null,
//         "divorce_suchak_foreign_country": "Albania",
//         "divorce_suchak_foreign_country_english": null,
//         "divorce_suchak_form_date": "1940-1-1",
//         "divorce_suchak_gabisa": null,
//         "divorce_suchak_ghar": null,
//         "divorce_suchak_jilla": null,
//         "divorce_suchak_middle_name": "नाम",
//         "divorce_suchak_middle_name_english": "name",
//         "divorce_suchak_name": "नाम",
//         "divorce_suchak_name_english": "name",
//         "divorce_suchak_number": null,
//         "divorce_suchak_passport_number": "345",
//         "divorce_suchak_passport_number_english": null,
//         "divorce_suchak_relation": "name",
//         "divorce_suchak_sadak": null,
//         "divorce_suchak_thar": "नाम",
//         "divorce_suchak_thar_english": "name",
//         "divorce_suchak_tol": null,
//         "divorce_suchak_woda": null,
//         "form_filler_number": "9898989898",
//         "girl_baaje_name": "नाम",
//         "girl_baaje_name_english": "नाम",
//         "girl_birth_date": "2021-02-17",
//         "girl_birth_number": "345",
//         "girl_caste": "test",
//         // "girl_check_box": false,
//         "girl_citizen_date": "1940-1-1",
//         "girl_citizen_jilla": "Dhankutta",
//         "girl_citizen_number": "345",
//         "girl_citizen_pradesh": "1",
//         "girl_citizen_sthaniyataha": "test",
//         "girl_country": null,
//         "girl_education": "test",
//         "girl_father_name": "नाम",
//         "girl_father_name_english": "name",
//         "girl_foreign_country": null,
//         "girl_foreign_country_english": null,
//         "girl_gabisa_nepali": "test",
//         "girl_ghar_nepali": "345",
//         "girl_jilla_nepali": "Panchthar",
//         "girl_job": "test",
//         "girl_language": "test",
//         "girl_middle_name": "नाम",
//         "girl_middle_name_english": "name",
//         "girl_mother_name": "name",
//         "girl_mother_name_english": "name",
//         "girl_name": "नाम",
//         "girl_name_english": "name",
//         "girl_passport_number": null,
//         "girl_religion": "test",
//         "girl_sadak_nepali": "test",
//         "girl_thar": "नाम",
//         "girl_thar_english": "name",
//         "girl_tol_nepali": "test",
//         "girl_woda_nepali": "2",
//         "other_boy_daughter_number": "3",
//         "other_boy_son_number": "3",
//         "other_girl_son_number": "1",
//         "other_girl_daughter_number": "0",
//         "parents_daughter_number": "3",
//         "parents_son_number": "3",
//         "remarks": null,
//         "remarks_english": null,
//       };

//       divorceData.forEach((key, value) {
//         // if (value != null) {
//         print(key + ':' + value.toString());
//         // }
//       });
//       divorceformApi(dummy_data).then((data) {
//         
//       });
//     }
//   }
// }
