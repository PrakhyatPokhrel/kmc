// import 'package:flutter/material.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
// import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:kmc/config/colors.dart';
// import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:get/get.dart';

// class Death extends StatefulWidget {
//   @override
//   _DeathState createState() => _DeathState();
// }

// class _DeathState extends State<Death> {
//   List<Step> spr = <Step>[];
//   dynamic _currentWard = null;

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

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     coutryapi();
//     districtApi();
//     localLevelApi();
//   }

//   var _dprovince;
//   List _deathPersonDistrict = List();
//   var selectedDeathPersonDistrict;
//   List _deathPersonLocalLevel = List();
//   var selectedDeathPersonLocalLevel;

//   var _deathProvince;
//   List _deathPersonDeathDistrict = List();
//   var selectedDeathPersonDeathDistrict;
//   List _deathPersonDeathLocalLevel = List();
//   var selectedDeathPersonDeathLocalLevel;

//   var _edeathProvince;
//   List _edeathPersonDeathDistrict = List();
//   var eselectedDeathPersonDeathDistrict;
//   List _edeathPersonDeathLocalLevel = List();
//   var eselectedDeathPersonDeathLocalLevel;

//   var _deathCitizenProvince;
//   List _deathPersonCitizenDistrict = List();
//   var selectedDeathPersonCitizenDistrict;
//   List _deathPersonCitizenLocalLevel = List();
//   var selectedDeathPersonCitizenLocalLevel;

//   var _deadSuchakprovince;
//   List _deadSuchakJilla = List();
//   var _dead_suchak_jilla;
//   List _deathSuchakLocalLevel = List();
//   var _dead_suchak_local_level;

//   var dead_suchak_citizen_Province;
//   List _deathSuchakCitizenDistrict = List();
//   var dead_suchak_citizen_jilla;
//   List _deathSuchakCitizenLocalLevel = List();
//   var dead_suchak_citizen_Local_Level;

//   List _country = List();
//   var dead_foreign_country;

//   coutryapi() {
//     getCountries().then((value) => {
//           setState(() {
//             _country = value['result'];
//           })
//         });
//   }

//   var _province;
//   var _provinces = [
//     "1",
//     "2",
//     "3",
//     "4",
//     "5",
//     "6",
//     "7",
//   ];

//   var _deathPlace;
//   var _deathPlaces = [
//     "घर",
//     "हस्पिटल",
//     "others",
//   ];

//   var _death_marital_status;
//   var _deathMaritalStatus = [
//     "बिबाहित",
//     "अबिबाहित",
//   ];

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

//   final janma_darta_number = TextEditingController();
//   final dead_person_name = TextEditingController();
//   final dead_person_middle_name = TextEditingController();
//   final dead_person_thar = TextEditingController();
//   final dead_person_name_english = TextEditingController();
//   final dead_person_middle_name_english = TextEditingController();
//   final dead_person_thar_english = TextEditingController();
//   final janma_gabisa = TextEditingController();
//   final janma_woda = TextEditingController();
//   final janma_sadak = TextEditingController();
//   final janma_tol = TextEditingController();
//   final janma_ghar = TextEditingController();
//   final dead_person_gabisa = TextEditingController();
//   final dead_person_gabisa_english = TextEditingController();
//   final dead_person_woda_english = TextEditingController();
//   final dead_person_sadak_english = TextEditingController();
//   final dead_person_tol_english = TextEditingController();
//   final dead_person_ghar_englsih = TextEditingController();

//   final dead_person_woda = TextEditingController();
//   final dead_person_sadak = TextEditingController();
//   final dead_person_tol = TextEditingController();
//   final dead_person_ghar = TextEditingController();
//   final dead_passport_number = TextEditingController();
//   final dead_citizen_number = TextEditingController();
//   final dead_education = TextEditingController();
//   final dead_language = TextEditingController();
//   final dead_religion = TextEditingController();
//   final dead_caste = TextEditingController();

//   final dead_baaje_name = TextEditingController();
//   final dead_baaje_middle_name = TextEditingController();
//   final dead_baaje_thar = TextEditingController();
//   final dead_baaje_name_english = TextEditingController();
//   final dead_baaje_middle_name_english = TextEditingController();
//   final dead_baaje_thar_english = TextEditingController();

//   final dead_father_name = TextEditingController();
//   final dead_father_middle_name = TextEditingController();
//   final dead_father_thar = TextEditingController();
//   final dead_father_name_english = TextEditingController();
//   final dead_father_middle_name_english = TextEditingController();
//   final dead_father_thar_english = TextEditingController();

//   final dead_mother_name = TextEditingController();
//   final dead_mother_middle_name = TextEditingController();
//   final dead_mother_thar = TextEditingController();
//   final dead_mother_name_english = TextEditingController();
//   final dead_mother_middle_name_english = TextEditingController();
//   final dead_mother_thar_english = TextEditingController();

//   final dead_spouse_name = TextEditingController();
//   final dead_spouse_middle_name = TextEditingController();
//   final dead_spouse_thar = TextEditingController();
//   final dead_spouse_name_english = TextEditingController();
//   final dead_spouse_middle_name_english = TextEditingController();
//   final dead_spouse_thar_english = TextEditingController();
//   final dead_cause = TextEditingController();

//   var bibahikArray = [];

//   clearForm() {
//     _formKey.currentState.save();
//     dead_spouse_name.clear();
//     dead_spouse_middle_name.clear();
//     dead_spouse_thar.clear();
//     dead_spouse_name_english.clear();
//     dead_spouse_middle_name_english.clear();
//     dead_spouse_thar_english.clear();
//     dead_cause.clear();
//   }

//   final dead_suchak_name = TextEditingController();
//   final dead_suchak_middle_name = TextEditingController();
//   final dead_suchak_thar = TextEditingController();
//   final dead_suchak_name_english = TextEditingController();
//   final dead_suchak_middle_name_english = TextEditingController();
//   final dead_suchak_thar_english = TextEditingController();
//   final dead_suchak_relation = TextEditingController();
//   final dead_suchak_passport_number = TextEditingController();
//   final dead_suchak_gabisa = TextEditingController();
//   final dead_suchak_woda = TextEditingController();
//   final dead_suchak_sadak = TextEditingController();
//   final dead_suchak_tol = TextEditingController();
//   final dead_suchak_ghar = TextEditingController();
//   final dead_suchak_gabisa_englsih = TextEditingController();
//   final dead_suchak_woda_englsih = TextEditingController();
//   final dead_suchak_sadak_englsih = TextEditingController();
//   final dead_suchak_tol_englsih = TextEditingController();

//   final dead_suchak_citizenship_number = TextEditingController();
//   final form_filler_number = TextEditingController();
//   final remarks = TextEditingController();
//   final remarks_english = TextEditingController();

//   var dead_suchak_foreign_country;

//   bool dead_check_box = false;
//   bool dead_suchak_check_box = false;

//   DateTime dead_birth_date_english = DateTime.now();
//   NepaliDateTime dead_birth_date_nepali = NepaliDateTime.now();
//   String dead_birth_date_english_string;
//   String dead_birth_date_nepali_string;

//   DateTime death_date_english = DateTime.now();
//   NepaliDateTime death_date_nepali = NepaliDateTime.now();
//   String death_date_english_string;
//   String death_date_nepali_string;

//   NepaliDateTime deadCitizenDate = NepaliDateTime.now();
//   String dead_citizen_date;

//   NepaliDateTime deadSuchakDate = NepaliDateTime.now();
//   String dead_suchak_date;

//   NepaliDateTime deadSuchakFormDate = NepaliDateTime.now();
//   String dead_suchak_form_date;

//   Future<Null> selectedEnglishDate(BuildContext context, String data) async {
//     final DateTime picked = await showDatePicker(
//       initialDatePickerMode: DatePickerMode.year,
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1905),
//       lastDate: DateTime.now(),
//     );

//     if (dead_birth_date_english != null && picked != dead_birth_date_english ||
//         death_date_english != null && picked != death_date_english) {
//       setState(() {
//         if (data == "deadBirthDateEnglish") {
//           dead_birth_date_english = picked;
//           dead_birth_date_english_string =
//               "${dead_birth_date_english.year}/${dead_birth_date_english.month}/${dead_birth_date_english.day}";
//           print(
//               "${dead_birth_date_english.year}/${dead_birth_date_english.month}/${dead_birth_date_english.day}");
//         } else if (data == "deadDeathDateEnglish") {
//           death_date_english = picked;
//           death_date_english_string =
//               "${death_date_english.year}/${death_date_english.month}/${death_date_english.day}";
//           print(
//               "${death_date_english.year}/${death_date_english.month}/${death_date_english.day}");
//         }
//       });
//     }
//   }

//   Future<Null> selectNepaliDate(BuildContext context, String data) async {
//     final NepaliDateTime _picked = await picker.showMaterialDatePicker(
//       context: context,
//       initialDate: NepaliDateTime.now(),
//       firstDate: NepaliDateTime(2000),
//       lastDate: NepaliDateTime.now(),
//       initialDatePickerMode: DatePickerMode.year,
//     );
//     if (dead_birth_date_nepali != null && _picked != dead_birth_date_nepali) {
//       setState(() {
//         if (data == "deadBirthDateNepali") {
//           dead_birth_date_nepali = _picked;
//           dead_birth_date_nepali_string =
//               "${dead_birth_date_nepali.year}/${dead_birth_date_nepali.month}/${dead_birth_date_nepali.day}";
//           print(
//               "${dead_birth_date_nepali.year}/${dead_birth_date_nepali.month}/${dead_birth_date_nepali.day}");
//         } else if (data == "deathDateNepali") {
//           death_date_nepali = _picked;
//           death_date_nepali_string =
//               "${death_date_nepali.year}/${death_date_nepali.month}/${death_date_nepali.day}";
//           print(
//               "${death_date_nepali.year}/${death_date_nepali.month}/${death_date_nepali.day}");
//         } else if (data == "deathCitizenDetail") {
//           deadCitizenDate = _picked;
//           dead_citizen_date =
//               "${deadCitizenDate.year}/${deadCitizenDate.month}/${deadCitizenDate.day}";
//           print(
//               "${deadCitizenDate.year}/${deadCitizenDate.month}/${deadCitizenDate.day}");
//         } else if (data == "deadSuchakDate") {
//           deadSuchakDate = _picked;
//           dead_suchak_date =
//               "${deadSuchakDate.year}/${deadSuchakDate.month}/${deadSuchakDate.day}";
//           print(
//               "${deadSuchakDate.year}/${deadSuchakDate.month}/${deadSuchakDate.day}");
//         } else if (data == "deadSuchakFormDate") {
//           deadSuchakFormDate = _picked;
//           dead_suchak_form_date =
//               "${deadSuchakFormDate.year}/${deadSuchakFormDate.month}/${deadSuchakFormDate.day}";
//           print(
//               "${deadSuchakFormDate.year}/${deadSuchakFormDate.month}/${deadSuchakFormDate.day}");
//         }
//       });
//     }
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
//                 Text('DEATH'.tr + ' ' + 'REPORT'.tr,
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
//           child: Container(
//             height: Get.height * 15,
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
//                                     deathformsubmit();
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
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
//                   Widget>[
//             Center(
//               child: Text(
//                 "मृतकको विवरण",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText("जन्म दर्ता नं "),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: janma_darta_number,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको पहिलो नाम(नेपालीमा)'),
//             TextFormField(
//               controller: dead_person_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको बिचको नाम(नेपालीमा)'),
//             TextFormField(
//               controller: dead_person_middle_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको थर(नेपालीमा)'),
//             TextFormField(
//               controller: dead_person_thar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको पहिलो नाम (in English)'),
//             TextFormField(
//               controller: dead_person_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको बिचको नाम(in English)'),
//             TextFormField(
//               controller: dead_person_middle_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकको थर(in English)'),
//             TextFormField(
//               controller: dead_person_thar_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('जन्म मिति (साल- महिना- गते) '),
//             Row(
//               children: [
//                 Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText(' ई.सं. मा'),
//                         GestureDetector(
//                           onTap: () {
//                             selectedEnglishDate(
//                                 context, "deadBirthDateEnglish");
//                           },
//                           child: Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Text(
//                                 "${dead_birth_date_english.year}-${dead_birth_date_english.month}-${dead_birth_date_english.day}"),
//                           ),
//                         ),
//                       ],
//                     )),
//                 SizedBox(
//                   width: Get.width * 0.02,
//                 ),
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       labelText('वि.सं. मा '),
//                       GestureDetector(
//                         onTap: () async {
//                           selectNepaliDate(context, "deadBirthDateNepali");
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: white,
//                               borderRadius: BorderRadius.circular(5.0)),
//                           height: Get.height * 0.05,
//                           width: Get.width * 0.3,
//                           child: Center(
//                             child: Text(
//                                 '${dead_birth_date_nepali.year}-${dead_birth_date_nepali.month}-${dead_birth_date_nepali.day}'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             labelText('मृत्यु मिति (साल- महिना- गते)'),
//             Row(
//               children: [
//                 Expanded(
//                     flex: 5,
//                     child: Column(
//                       children: [
//                         labelText(' ई.सं. मा'),
//                         GestureDetector(
//                           onTap: () {
//                             selectedEnglishDate(
//                                 context, "deadDeathDateEnglish");
//                           },
//                           child: Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: white,
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.3,
//                             child: Text(
//                                 "${death_date_english.year}-${death_date_english.month}-${death_date_english.day}"),
//                           ),
//                         ),
//                       ],
//                     )),
//                 SizedBox(
//                   width: Get.width * 0.02,
//                 ),
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       labelText('वि.सं. मा '),
//                       GestureDetector(
//                         onTap: () async {
//                           selectNepaliDate(context, "deathDateNepali");
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: white,
//                               borderRadius: BorderRadius.circular(5.0)),
//                           height: Get.height * 0.05,
//                           width: Get.width * 0.3,
//                           child: Center(
//                             child: Text(
//                                 '${death_date_nepali.year}-${death_date_nepali.month}-${death_date_nepali.day}'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "जन्म भएको ठेगाना",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                 ),
//               ),
//             ),
//             labelText("प्रदेश"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _provinces.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonDistrict = _district[value];
//                         print(_district[value]);
//                         this._dprovince = value;
//                         print(_dprovince);
//                         selectedDeathPersonDistrict = null;
//                         selectedDeathPersonLocalLevel = null;
//                       });
//                     },
//                     value: _dprovince,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("जिल्ला"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonDistrict.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonLocalLevel = _localLevel[value];
//                         print(_localLevel[value]);
//                         this.selectedDeathPersonDistrict = value;
//                        
//                         selectedDeathPersonLocalLevel = null;
//                       });
//                     },
//                     value: selectedDeathPersonDistrict,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("स्थानीय स्तर"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonLocalLevel.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         this.selectedDeathPersonLocalLevel = value;
//                        
//                       });
//                     },
//                     value: selectedDeathPersonLocalLevel,
//                   ),
//                 ),
//               ),
//             ),
//             labelText('गा.वी.स./न.पा.'),
//             TextFormField(
//               controller: janma_gabisa,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('वडा'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: janma_woda,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('सडक/ मार्ग'),
//             TextFormField(
//               controller: janma_sadak,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('गाउँ/टोल'),
//             TextFormField(
//               controller: janma_tol,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('घर नं'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: janma_ghar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText("मृत्यु भएको स्थान"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPlaces.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         this._deathPlace = value;
//                        
//                       });
//                     },
//                     value: _deathPlace,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "मृतकको ठेगाना",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText("प्रदेश"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _provinces.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonDeathDistrict = _district[value];
//                         print(_district[value]);
//                         this._deathProvince = value;
//                         print(_deathProvince);
//                         selectedDeathPersonDeathDistrict = null;
//                         selectedDeathPersonDeathLocalLevel = null;
//                       });
//                     },
//                     value: _deathProvince,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("जिल्ला"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonDeathDistrict.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonDeathLocalLevel = _localLevel[value];
//                         print(_localLevel[value]);
//                         this.selectedDeathPersonDeathDistrict = value;
//                        
//                         selectedDeathPersonDeathLocalLevel = null;
//                       });
//                     },
//                     value: selectedDeathPersonDeathDistrict,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("स्थानीय स्तर"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonDeathLocalLevel.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         this.selectedDeathPersonDeathLocalLevel = value;
//                        
//                       });
//                     },
//                     value: selectedDeathPersonDeathLocalLevel,
//                   ),
//                 ),
//               ),
//             ),
//             labelText('गा.वी.स./न.पा.'),
//             TextFormField(
//               controller: dead_person_gabisa,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('वडा'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: dead_person_woda,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('सडक/ मार्ग'),
//             TextFormField(
//               controller: dead_person_sadak,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('गाउँ/टोल'),
//             TextFormField(
//               controller: dead_person_tol,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('घर नं'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: dead_person_ghar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "मृतकको ठेगाना (in English)",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText("प्रदेश"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _provinces.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _edeathPersonDeathDistrict = _district[value];
//                         print(_district[value]);
//                         this._edeathProvince = value;
//                         print(_edeathProvince);
//                         eselectedDeathPersonDeathDistrict = null;
//                         eselectedDeathPersonDeathLocalLevel = null;
//                       });
//                     },
//                     value: _edeathProvince,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("जिल्ला"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _edeathPersonDeathDistrict.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _edeathPersonDeathLocalLevel = _localLevel[value];
//                         print(_localLevel[value]);
//                         this.eselectedDeathPersonDeathDistrict = value;
//                        
//                         eselectedDeathPersonDeathLocalLevel = null;
//                       });
//                     },
//                     value: eselectedDeathPersonDeathDistrict,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("स्थानीय स्तर"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _edeathPersonDeathLocalLevel.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         this.eselectedDeathPersonDeathLocalLevel = value;
//                        
//                       });
//                     },
//                     value: eselectedDeathPersonDeathLocalLevel,
//                   ),
//                 ),
//               ),
//             ),
//             labelText('गा.वी.स./न.पा.'),
//             TextFormField(
//               controller: dead_person_gabisa_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('वडा'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: dead_person_woda_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('सडक/ मार्ग'),
//             TextFormField(
//               controller: dead_person_sadak_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('गाउँ/टोल'),
//             TextFormField(
//               controller: dead_person_tol_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('घर नं'),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: dead_person_ghar_englsih,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "मृतकको विवरण",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             CheckboxListTile(
//               title: labelText("विदेशी हो"),
//               value: dead_check_box,
//               controlAffinity: ListTileControlAffinity.leading,
//               onChanged: (bool value) {
//                 setState(() {
//                   dead_check_box = value;
//                 });
//               },
//             ),
//             dead_check_box == true
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       labelText("देशको नाम"),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: white,
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                               hint: Text("Select"),
//                               isExpanded: true,
//                               items: _country.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: new Text(item['name'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['name'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                  
//                                   this.dead_foreign_country = value;
//                                 });
//                               },
//                               value: dead_foreign_country),
//                         ),
//                       ),
//                       labelText('पासपोर्ट नम्बर'),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: dead_passport_number,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   )
//                 : Container(),
//             labelText('नागरिकता नं '),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: dead_citizen_number,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                 GestureDetector(
//                   onTap: () async {
//                     selectNepaliDate(context, "deathCitizenDetail");
//                     print(
//                         "${deadCitizenDate.year}-${deadCitizenDate.month}-${deadCitizenDate.day}");
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: white, borderRadius: BorderRadius.circular(5.0)),
//                     height: Get.height * 0.05,
//                     width: Get.width * 0.3,
//                     child: Center(
//                       child: Text(
//                           '${deadCitizenDate.year}-${deadCitizenDate.month}-${deadCitizenDate.day}'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             labelText('नागरिकता जारी प्रदेश'),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _provinces.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonCitizenDistrict = _district[value];
//                         print(_district[value]);
//                         this._deathCitizenProvince = value;
//                         print(_deathCitizenProvince);
//                         selectedDeathPersonCitizenDistrict = null;
//                         selectedDeathPersonCitizenLocalLevel = null;
//                       });
//                     },
//                     value: _deathCitizenProvince,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("नागरिकता जारी जिल्ला"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: Text(
//                       "Select",
//                     ),
//                     isExpanded: true,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonCitizenDistrict.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _deathPersonCitizenLocalLevel = _localLevel[value];
//                         this.selectedDeathPersonCitizenDistrict = value;
//                        
//                         selectedDeathPersonCitizenLocalLevel = null;
//                       });
//                     },
//                     value: selectedDeathPersonCitizenDistrict,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("नागरिकता जारी स्थानीय स्तर"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathPersonCitizenLocalLevel.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['np_label'],
//                               style: TextStyle(color: primary)),
//                         ),
//                         value: item['np_label'],
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         this.selectedDeathPersonCitizenLocalLevel = value;
//                        
//                       });
//                     },
//                     value: selectedDeathPersonCitizenLocalLevel,
//                   ),
//                 ),
//               ),
//             ),
//             labelText("पूर्व बैबाहिक स्थिति "),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: white,
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     isExpanded: true,
//                     hint: Text(
//                       "Select",
//                     ),
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     items: _deathMaritalStatus.map((item) {
//                       return DropdownMenuItem(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item, style: TextStyle(color: primary)),
//                         ),
//                         value: item,
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _death_marital_status = value;
//                         print('_death_marital_status $_death_marital_status');
//                       });
//                     },
//                     value: _death_marital_status,
//                   ),
//                 ),
//               ),
//             ),
//             _death_marital_status == "बिबाहित"
//                 ? Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             "मृतक बिबाहित भएमा",
//                             style: TextStyle(
//                               fontSize: 24.0,
//                               color: primary,
//                             ),
//                           ),
//                         ),
//                         bibahikArray.length != 0
//                             ? Container(
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: bibahikArray.length,
//                                     itemBuilder: (context, index) {
//                                       return SingleChildScrollView(
//                                         child: Container(
//                                             padding: EdgeInsets.all(15),
//                                             child: Column(
//                                               children: [
//                                                 Table(
//                                                   columnWidths: {
//                                                     0: FlexColumnWidth(1),
//                                                     1: FlexColumnWidth(6),
//                                                     2: FlexColumnWidth(4),
//                                                   },
//                                                   border: TableBorder.all(
//                                                       width: 1,
//                                                       color: Colors
//                                                           .black45), //table border
//                                                   children: [
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("1. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको पहिलो नाम (नेपालीमा)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_name']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("2. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको बिचको नाम (नेपालीमा)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_middle_name']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("3. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको थर (नेपालीमा)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_thar']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("4. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको पहिलो नाम (in English)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_name_english']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("5. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको बिचको नाम (in English)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_middle_name_english']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("6. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "पति/पत्नीको थर (in English)"),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(bibahikArray[
//                                                                 index][
//                                                             'dead_spouse_thar_english']),
//                                                       )),
//                                                     ]),
//                                                     TableRow(children: [
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text("7. "),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Text(
//                                                               "मृत्यु भएको भए कारण "),
//                                                         ),
//                                                       )),
//                                                       TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             bibahikArray[index]
//                                                                 ['dead_cause']),
//                                                       )),
//                                                     ]),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: Get.height * 0.02,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       bibahikArray
//                                                           .removeAt(index);
//                                                     });
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20.0),
//                                                       color: Colors.red[700],
//                                                     ),
//                                                     height: 40.0,
//                                                     width: Get.width,
//                                                     child: Center(
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Icon(
//                                                             Icons.delete,
//                                                             color: white,
//                                                             size: 30.0,
//                                                           ),
//                                                           SizedBox(
//                                                             width: Get.width *
//                                                                 0.02,
//                                                           ),
//                                                           Text(
//                                                             'हटाउनुहोस',
//                                                             style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color: white,
//                                                               fontSize: 25.0,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )),
//                                       );
//                                     }),
//                               )
//                             : Container(),
//                         SizedBox(
//                           height: Get.height * 0.02,
//                         ),
//                         labelText('पति/पत्नीको पहिलो नाम (नेपालीमा)'),
//                         TextFormField(
//                           controller: dead_spouse_name,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पति/पत्नीको बिचको नाम (नेपालीमा)'),
//                         TextFormField(
//                           controller: dead_spouse_middle_name,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पति/पत्नीको थर (नेपालीमा)'),
//                         TextFormField(
//                           controller: dead_spouse_thar,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पति/पत्नीको पहिलो नाम (in English)'),
//                         TextFormField(
//                           controller: dead_spouse_name_english,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पति/पत्नीको बिचको नाम (in English)'),
//                         TextFormField(
//                           controller: dead_spouse_middle_name_english,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('पति/पत्नीको थर (in English)'),
//                         TextFormField(
//                           controller: dead_spouse_thar_english,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         labelText('मृत्यु भएको भए कारण'),
//                         TextFormField(
//                           controller: dead_cause,
//                           autofocus: false,
//                           decoration: inputTheme(),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'required';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.02,
//                         ),
//                         labelText(
//                             "दुई वा सोभन्दा बढी पत्नी भएमा सबैको नाम उल्लेख गर्ने (मृत्यु भएको समेत)"),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               // _formKey.currentState.save();
//                               // var a = {
//                               //   "dead_spouse_name": dead_spouse_name.text,
//                               //   "dead_spouse_middle_name":
//                               //       dead_spouse_middle_name.text,
//                               //   "dead_spouse_thar": dead_spouse_thar.text,
//                               //   "dead_spouse_name_english":
//                               //       dead_spouse_name_english.text,
//                               //   "dead_spouse_middle_name_english":
//                               //       dead_spouse_middle_name_english.text,
//                               //   "dead_spouse_thar_english":
//                               //       dead_spouse_thar_english.text,
//                               //   "dead_cause": dead_cause.text,
//                               // };
//                               // bibahikArray.add(a);
//                               // print(bibahikArray);

//                               bibahitarraydata('addmore');
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: primary,
//                             ),
//                             height: 50.0,
//                             width: Get.width,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     color: white,
//                                     size: 30.0,
//                                   ),
//                                   SizedBox(
//                                     width: Get.width * 0.02,
//                                   ),
//                                   Text(
//                                     'अर्को थप्नुहोस',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: white,
//                                       fontSize: 25.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Container(),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText('शिक्षाको उतिर्ण स्तर'),
//             TextFormField(
//               controller: dead_education,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मातृभाषा'),
//             TextFormField(
//               controller: dead_language,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('धर्म'),
//             TextFormField(
//               controller: dead_religion,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('जात / जाती'),
//             TextFormField(
//               controller: dead_caste,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "मृतकको परिवारको विवरण",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText('बाजेको नाम (नेपालीमा)'),
//             TextFormField(
//               controller: dead_baaje_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाजेको बिचको नाम(नेपालीमा)'),
//             TextFormField(
//               controller: dead_baaje_middle_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाजेको थर (नेपालीमा)'),
//             TextFormField(
//               controller: dead_baaje_thar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाजेको नाम (in English)'),
//             TextFormField(
//               controller: dead_baaje_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाजेको बिचको नाम(in English)'),
//             TextFormField(
//               controller: dead_baaje_middle_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाजेको थर (in English)'),
//             TextFormField(
//               controller: dead_baaje_thar_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको नाम (नेपालीमा)'),
//             TextFormField(
//               controller: dead_father_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको बिचको नाम(नेपालीमा)'),
//             TextFormField(
//               controller: dead_father_middle_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको थर (नेपालीमा) '),
//             TextFormField(
//               controller: dead_father_thar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको नाम (in English)'),
//             TextFormField(
//               controller: dead_father_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको बिचको नाम(in English)'),
//             TextFormField(
//               controller: dead_father_middle_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बाबुको थर (in English)'),
//             TextFormField(
//               controller: dead_father_thar_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको नाम (नेपालीमा) '),
//             TextFormField(
//               controller: dead_mother_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको बिचको नाम (नेपालीमा)'),
//             TextFormField(
//               controller: dead_mother_middle_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको थर (नेपालीमा)'),
//             TextFormField(
//               controller: dead_mother_thar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको नाम (in English)'),
//             TextFormField(
//               controller: dead_mother_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको बिचको नाम (in English)'),
//             TextFormField(
//               controller: dead_mother_middle_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('आमाको थर (in English)'),
//             TextFormField(
//               controller: dead_mother_thar_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "सूचकको विवरण",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             labelText(
//                 "यसमा लेखेको विवरण साँचो हो । झुट्ठा ठहरे कानून बमोजिम सहुँला बुझाउँला ।"),
//             labelText('पहिलो नाम (नेपालीमा) '),
//             TextFormField(
//               controller: dead_suchak_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बिचको नाम (नेपालीमा)'),
//             TextFormField(
//               controller: dead_suchak_middle_name,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('थर (नेपालीमा)'),
//             TextFormField(
//               controller: dead_suchak_thar,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('पहिलो नाम (in English)'),
//             TextFormField(
//               controller: dead_suchak_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('बिचको नाम (in English)'),
//             TextFormField(
//               controller: dead_suchak_middle_name_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('थर (in English)'),
//             TextFormField(
//               controller: dead_suchak_thar_english,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             labelText('मृतकसंग को नाता'),
//             TextFormField(
//               controller: dead_suchak_relation,
//               autofocus: false,
//               decoration: inputTheme(),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'required';
//                 }
//                 return null;
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "ठेगाना",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: primary,
//                 ),
//               ),
//             ),
//             CheckboxListTile(
//               title: labelText("विदेशी हो"),
//               value: dead_suchak_check_box,
//               controlAffinity: ListTileControlAffinity.leading,
//               onChanged: (bool value) {
//                 setState(() {
//                   dead_suchak_check_box = value;
//                 });
//               },
//             ),
//             dead_suchak_check_box == true
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       labelText("देशको नाम"),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: white,
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                               hint: Text("Select"),
//                               isExpanded: true,
//                               items: _country.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: new Text(item['name'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['name'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                  
//                                   this.dead_suchak_foreign_country = value;
//                                 });
//                               },
//                               value: dead_suchak_foreign_country),
//                         ),
//                       ),
//                       labelText('पासपोर्ट नम्बर'),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: dead_suchak_passport_number,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       labelText("प्रदेश"),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               hint: Text(
//                                 "Select",
//                               ),
//                               isExpanded: true,
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _provinces.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item,
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item,
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _deadSuchakJilla = _district[value];
//                                   print(_district[value]);
//                                   this._deadSuchakprovince = value;
//                                   print(_province);
//                                   _dead_suchak_jilla = null;
//                                   _dead_suchak_local_level = null;
//                                 });
//                               },
//                               value: _deadSuchakprovince,
//                             ),
//                           ),
//                         ),
//                       ),
//                       labelText("जिल्ला"),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               hint: Text(
//                                 "Select",
//                               ),
//                               isExpanded: true,
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _deadSuchakJilla.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item['np_label'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['np_label'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _deathSuchakLocalLevel = _localLevel[value];
//                                   this._dead_suchak_jilla = value;
//                                  
//                                   _dead_suchak_local_level = null;
//                                 });
//                               },
//                               value: _dead_suchak_jilla,
//                             ),
//                           ),
//                         ),
//                       ),
//                       labelText("स्थानीय स्तर"),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               isExpanded: true,
//                               hint: Text(
//                                 "Select",
//                               ),
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _deathSuchakLocalLevel.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item['np_label'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['np_label'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   this._dead_suchak_local_level = value;
//                                  
//                                 });
//                               },
//                               value: _dead_suchak_local_level,
//                             ),
//                           ),
//                         ),
//                       ),
//                       labelText('गा.वी.स./न.पा.'),
//                       TextFormField(
//                         controller: dead_suchak_gabisa,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('वडा'),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: dead_suchak_woda,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('सडक/ मार्ग'),
//                       TextFormField(
//                         controller: dead_suchak_sadak,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('गाउँ/टोल'),
//                       TextFormField(
//                         controller: dead_suchak_tol,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('घर नं'),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: dead_suchak_ghar,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "नागरिकता ",
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             color: primary,
//                           ),
//                         ),
//                       ),
//                       labelText("नागरिकता नं"),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: dead_suchak_citizenship_number,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                       GestureDetector(
//                         onTap: () async {
//                           selectNepaliDate(context, "deadSuchakDate");
//                           print(
//                               "${deadSuchakDate.year}-${deadSuchakDate.month}-${deadSuchakDate.day}");
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: white,
//                               borderRadius: BorderRadius.circular(5.0)),
//                           height: Get.height * 0.05,
//                           width: Get.width * 0.3,
//                           child: Center(
//                             child: Text(
//                                 '${deadSuchakDate.year}-${deadSuchakDate.month}-${deadSuchakDate.day}'),
//                           ),
//                         ),
//                       ),
//                       labelText('नागरिकता जारी प्रदेश'),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               hint: Text(
//                                 "Select",
//                               ),
//                               isExpanded: true,
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _provinces.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item,
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item,
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _deathSuchakCitizenDistrict =
//                                       _district[value];
//                                   print(_district[value]);
//                                   this.dead_suchak_citizen_Province = value;
//                                   print(dead_suchak_citizen_Province);
//                                   dead_suchak_citizen_jilla = null;
//                                   dead_suchak_citizen_Local_Level = null;
//                                 });
//                               },
//                               value: dead_suchak_citizen_Province,
//                             ),
//                           ),
//                         ),
//                       ),
//                       labelText("नागरिकता जारी जिल्ला"),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               hint: Text(
//                                 "Select",
//                               ),
//                               isExpanded: true,
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _deathSuchakCitizenDistrict.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item['np_label'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['np_label'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _deathSuchakCitizenLocalLevel =
//                                       _localLevel[value];
//                                   this.dead_suchak_citizen_jilla = value;
//                                  
//                                   selectedDeathPersonCitizenLocalLevel = null;
//                                 });
//                               },
//                               value: dead_suchak_citizen_jilla,
//                             ),
//                           ),
//                         ),
//                       ),
//                       labelText("नागरिकता जारी स्थानीय स्तर"),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: white,
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               isExpanded: true,
//                               hint: Text(
//                                 "Select",
//                               ),
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               items: _deathPersonCitizenLocalLevel.map((item) {
//                                 return DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(item['np_label'],
//                                         style: TextStyle(color: primary)),
//                                   ),
//                                   value: item['np_label'],
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   this.selectedDeathPersonCitizenLocalLevel =
//                                       value;
//                                  
//                                 });
//                               },
//                               value: selectedDeathPersonCitizenLocalLevel,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.02,
//                       ),
//                       Center(
//                         child: Text(
//                           "फारम भर्नेको विवरण",
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             color: primary,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.02,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           labelText('नागरिकता जारी मिति (साल- महिना- गते)'),
//                           GestureDetector(
//                             onTap: () async {
//                               selectNepaliDate(context, "deadSuchakFormDate");
//                               print(
//                                   "${deadSuchakFormDate.year}-${deadSuchakFormDate.month}-${deadSuchakFormDate.day}");
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.3,
//                               child: Center(
//                                 child: Text(
//                                     '${deadSuchakFormDate.year}-${deadSuchakFormDate.month}-${deadSuchakFormDate.day}'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       labelText('फारम भर्नेको नम्बर '),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: form_filler_number,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('कैफियत (नेपालीमा)'),
//                       TextFormField(
//                         controller: remarks,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                       labelText('कैफियत (in English)'),
//                       TextFormField(
//                         controller: remarks_english,
//                         autofocus: false,
//                         decoration: inputTheme(),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//           ]),
//         ),
//       ],
//     );
//   }

//   bibahitarraydata(data) {
//     _formKey.currentState.save();
//     var a = {
//       "dead_spouse_name": dead_spouse_name.text,
//       "dead_spouse_middle_name": dead_spouse_middle_name.text,
//       "dead_spouse_thar": dead_spouse_thar.text,
//       "dead_spouse_name_english": dead_spouse_name_english.text,
//       "dead_spouse_middle_name_english": dead_spouse_middle_name_english.text,
//       "dead_spouse_thar_english": dead_spouse_thar_english.text,
//       "dead_cause": dead_cause.text,
//     };
//     setState(() {
//       bibahikArray.add(a);
//       clearForm();
//     });

//     if (data == "submit") {
//       finalapisubmit();
//     } else {}
//   }

//   deathformsubmit() {
//     _formKey.currentState.save();

//     if (dead_spouse_name.text == null) {
//       finalapisubmit();
//     } else {
//       bibahitarraydata('submit');
//     }
//   }

//   finalapisubmit() {
//     var death_data = {
//       "aliases": "${bibahikArray}",
//       "dead_baaje_middle_name": "${dead_baaje_middle_name.text}",
//       "dead_baaje_middle_name_english":
//           "${dead_baaje_middle_name_english.text}",
//       "dead_baaje_name": "${dead_baaje_name.text}",
//       "dead_baaje_name_english": "${dead_baaje_name_english.text}",
//       "dead_baaje_thar": "${dead_baaje_thar.text}",
//       "dead_baaje_thar_english": "${dead_baaje_thar_english.text}",
//       "dead_birth_date_english": "${dead_birth_date_english}",
//       "dead_birth_date_nepali": "${dead_birth_date_nepali}",
//       "dead_caste": "${dead_caste.text}",
//       "dead_check_box": "${dead_check_box}",
//       "dead_citizen_date": "${dead_citizen_date}",
//       "dead_citizen_jilla": "${selectedDeathPersonCitizenDistrict}",
//       "dead_citizen_number": "${dead_citizen_number}",
//       "dead_education": "${dead_education.text}",
//       "dead_father_middle_name": "${dead_father_middle_name.text}",
//       "dead_father_middle_name_english":
//           "${dead_father_middle_name_english.text}",
//       "dead_father_name": "${dead_father_name.text}",
//       "dead_father_name_english": "${dead_father_name_english.text}",
//       "dead_father_thar": "${dead_father_thar.text}",
//       "dead_father_thar_english": "${dead_father_thar_english.text}",
//       "dead_foreign_country": "${dead_foreign_country}",
//       "dead_language": "${dead_language.text}",
//       "dead_mother_middle_name": "${dead_mother_middle_name.text}",
//       "dead_mother_middle_name_english":
//           "${dead_mother_middle_name_english.text}",
//       "dead_mother_name": "${dead_mother_name.text}",
//       "dead_mother_name_english": "${dead_mother_name_english.text}",
//       "dead_mother_thar": "${dead_mother_thar.text}",
//       "dead_mother_thar_english": "${dead_mother_thar_english.text}",
//       "dead_passport_number": "${dead_passport_number.text}",
//       "dead_person_gabisa": "${dead_person_gabisa.text}",
//       "dead_person_gabisa_english": "${dead_person_gabisa_english.text}",
//       "dead_person_ghar": "${dead_person_ghar.text}",
//       "dead_person_ghar_english": "${dead_person_ghar.text}",
//       "dead_person_jilla": "${selectedDeathPersonDeathDistrict}",
//       "dead_person_jilla_english": "${eselectedDeathPersonDeathDistrict}",
//       "dead_person_middle_name": "${dead_person_middle_name.text}",
//       "dead_person_middle_name_english":
//           "${dead_person_middle_name_english.text}",
//       "dead_person_name": "${dead_person_name.text}",
//       "dead_person_name_english": "${dead_person_name_english.text}",
//       "dead_person_sadak": "${dead_person_sadak.text}",
//       "dead_person_sadak_english": "${dead_person_sadak_english.text}",
//       "dead_person_thar": "${dead_person_thar.text}",
//       "dead_person_thar_english": "${dead_person_thar_english.text}",
//       "dead_person_tol": "${dead_person_tol.text}",
//       "dead_person_tol_english": "${dead_person_tol_english.text}",
//       "dead_person_woda": "${dead_person_woda.text}",
//       "dead_person_woda_english": "${dead_person_woda_english.text}",
//       "dead_religion": "${dead_religion.text}",
//       "dead_suchak_check_box": "${dead_suchak_check_box}",
//       "dead_suchak_citizen_jilla": "${dead_suchak_citizen_jilla}",
//       "dead_suchak_citizenship_number":
//           "${dead_suchak_citizenship_number.text}",
//       "dead_suchak_date": "${dead_suchak_date}",
//       "dead_suchak_foreign_country": "${dead_suchak_foreign_country}",
//       "dead_suchak_form_date": "${dead_suchak_form_date}",
//       "dead_suchak_gabisa": "${dead_suchak_gabisa.text}",
//       "dead_suchak_ghar": "${dead_suchak_ghar.text}",
//       "dead_suchak_jilla": "${_dead_suchak_jilla}",
//       "dead_suchak_middle_name": "${dead_suchak_middle_name.text}",
//       "dead_suchak_middle_name_english":
//           "${dead_suchak_middle_name_english.text}",
//       "dead_suchak_name": "${dead_suchak_name.text}",
//       "dead_suchak_name_english": "${dead_suchak_name_english.text}",
//       "dead_suchak_passport_number": "${dead_suchak_passport_number.text}",
//       "dead_suchak_relation": "${dead_suchak_relation.text}",
//       "dead_suchak_sadak": "${dead_suchak_sadak.text}",
//       "dead_suchak_thar": "${dead_suchak_thar.text}",
//       "dead_suchak_thar_english": "${dead_suchak_thar_english.text}",
//       "dead_suchak_tol": "${dead_suchak_tol.text}",
//       "dead_suchak_woda": "${dead_suchak_woda.text}",
//       "death_date_english": "${death_date_english}",
//       "death_date_nepali": "${death_date_nepali}",
//       "death_marital_status": "${_death_marital_status}",
//       "death_place": "${_deathPlace}",
//       "form_filler_number": "${form_filler_number.text}",
//       "janma_darta_number": "${janma_darta_number.text}",
//       "janma_gabisa": "${janma_gabisa.text}",
//       "janma_ghar": "${janma_ghar}",
//       "janma_jilla": "${selectedDeathPersonDistrict}",
//       "janma_sadak": "${janma_sadak.text}",
//       "janma_tol": "${janma_tol.text}",
//       "janma_woda": "${janma_woda.text}",
//       "remarks": "${remarks.text}",
//       "remarks_english": "${remarks_english.text}",
//     };
//     print(death_data);
//     deathformApi(death_data).then((res) => {});
//   }
// }
