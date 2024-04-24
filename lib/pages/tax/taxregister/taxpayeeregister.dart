// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/Auth/otpalert.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/tax/taxregister/otpscreen.dart';

import '../../../constants/constants.dart';

class TaxPayeeRegister extends StatefulWidget {
  @override
  _TaxPayeeRegisterState createState() => _TaxPayeeRegisterState();
}

class _TaxPayeeRegisterState extends State<TaxPayeeRegister> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _otpkey = GlobalKey<FormBuilderState>();
  final otp = TextEditingController();
  var _currentGender;
  var _currentmaritalstatus;
  var _currentrelation;

  var _currentWard;
  bool checkboxValue = false;
  var onStepContinue;
  // List<ImageInputAdapter> _images;
  // _TaxPayeeRegisterState({this.existingImages});
  // final List<BlogImage>? existingImages;
  var name = TextEditingController();
  var firstname = TextEditingController();
  var middlename = TextEditingController();
  var lastname = TextEditingController();
  var fathername = TextEditingController();
  var mothername = TextEditingController();

  var wifename = TextEditingController();
  var husbandname = TextEditingController();

  var grandfathername = TextEditingController();
  var fatherinlawname = TextEditingController();

  var citizenship_number = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var phonenumber = TextEditingController();

  var address = TextEditingController();
  var tole = TextEditingController();
  var owner_house_number = TextEditingController();
  var provience;
  var _province;
  List? _childdistricts;
  var selectedDistrict;
  List? _childlocallevel;
  var selectedlocallevel;
  var _currentoccupation;
  int? entry_id;

  List familymember = [];
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    districtApi();
    localLevelApi();
    _scrollController = ScrollController();
  }

  void _scrollToTop() {
    _scrollController?.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  var _district;

  districtApi() {
    getDistrict().then((data) => {
          setState(() {
            _district = data;
          })
        });
  }

  var _localLevel;

  localLevelApi() {
    getLocalLevel().then((data) => {
          setState(() {
            _localLevel = data;
          })
        });
  }

  // var _gender = [
  //   {"name": "Male", "value": "male"},
  //   {"name": "Female", "value": "female"},
  //   {"name": "others", "value": "other"}
  // ];

  var _occupation = [
    {"name": "कृषि", "value": "कृषि"},
    {"name": "व्यवसाय", "value": "व्यवसाय"},
    {
      "name": "डकर्मी/ ढुंगा माटो आधि सम्बन्धि",
      "value": "डकर्मी/ ढुंगा माटो आधि सम्बन्धि"
    },
    {"name": "आरण्ड वा फलाम सम्बन्धि", "value": "आरण्ड वा फलाम सम्बन्धि"},
    {"name": "सरकारी", "value": "सरकारी"},
    {"name": "गैर सरकारी", "value": "गैर सरकारी"},
    {"name": "माछा पालन", "value": "माछा पालन"},
    {"name": "मौरी पालन", "value": "मौरी पालन"},
    {"name": "रेशम पालन", "value": "रेशम पालन"},
    {"name": "पशुपालन फर्मs", "value": "पशुपालन फर्मs"},
    {"name": "ईन्जिनियरिङ", "value": "ईन्जिनियरिङ"},
    {"name": "प्राबिधिक", "value": "प्राबिधिक"},
    {"name": "मेडिसिन", "value": "मेडिसिन"},
    {"name": "जेटीए", "value": "जेटीए"},
    {"name": "सिकर्मी/ काठ सम्बन्धि", "value": "सिकर्मी/ काठ सम्बन्धि"},
    {"name": "सामाजीक अभियान्ता", "value": "सामाजीक अभियान्ता"},
    {"name": "कपडा /टेलरिंग सम्बन्धि", "value": "कपडा /टेलरिंग सम्बन्धि"},
    {"name": "उद्यमी", "value": "उद्यमी"},
    {"name": "निर्माण कम्पनी", "value": "निर्माण कम्पनी"},
    {"name": "पत्रकारिता", "value": "पत्रकारिता"},
    {"name": "निजामती", "value": "निजामती"},
    {"name": "जनप्रतिनिधि", "value": "जनप्रतिनिधि"},
    {"name": "पशु /कृषि  प्राविधिक", "value": "पशु /कृषि  प्राविधिक"},
    {"name": "कलाकार", "value": "कलाकार"},
    {"name": "आर्मी", "value": "आर्मी"},
    {"name": "प्रहरी", "value": "प्रहरी"},
    {"name": "सशस्त्र", "value": "सशस्त्र"},
    {"name": "संघ संस्था", "value": "संघ संस्था"},
    {"name": "पाईलोट", "value": "पाईलोट"},
    {"name": "राजनिती", "value": "राजनिती"},
    {"name": "वकिल", "value": "वकिल"},
    {"name": "खेलाडी", "value": "खेलाडी"},
    {"name": "आरन", "value": "आरन"},
    {"name": "अन्य", "value": "अन्य"},
    {"name": "कुनै पनि काम गर्दिन ", "value": ""},
  ];

  var _relation = [
    {"name": "father", "value": "father"},
    {"name": "mother", "value": "mother"},
    {"name": "sister", "value": "sister"},
    {"name": "brother", "value": "brother"},
    {"name": "grandfather", "value": "grandfather"},
    {"name": "grandmother", "value": "grandmother"},
  ];

  var _marriage = [
    {"name": "unmarried", "value": "unmarried"},
    {"name": "married", "value": "married"},
    {"name": "divorced", "value": "divorced"}
  ];

  var _wards = [
    {"name": "१", "value": "1"},
    {"name": "२", "value": "2"},
    {"name": "३", "value": "3"},
    {"name": "४", "value": "4"},
    {"name": "५", "value": "5"},
    {"name": "६", "value": "6"},
    {"name": "७", "value": "7"},
    {"name": "८", "value": "8"},
    {"name": "९", "value": "9"},
    {"name": "९", "value": "9"},

    //
    {"name": "१०", "value": "10"},
    {"name": "११", "value": "11"},
    {"name": "१२", "value": "12"},
    {"name": "१३", "value": "13"},

    {"name": "१४", "value": "14"},
    {"name": "१५", "value": "15"},
    {"name": "१६", "value": "16"},
    {"name": "१७", "value": "17"},
    {"name": "१८", "value": "18"},
    {"name": "१९", "value": "19"},

    {"name": "२०", "value": "20"},
    {"name": "२१", "value": "21"},

    {"name": "२२", "value": "22"},
    {"name": "२३", "value": "23"},
    {"name": "२४", "value": "24"},
    {"name": "२५", "value": "25"},
    {"name": "२६", "value": "26"},
    {"name": "२७", "value": "27"},
    {"name": "२८", "value": "28"},
    {"name": "२९", "value": "29"},

    {"name": "३०", "value": "30"},
    {"name": "३१", "value": "31"},
    {"name": "३२", "value": "32"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},

    // {"name": "९", "value": "9"},
  ];

  var _provinces = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];

  List<Step> spr = <Step>[];
  List<Step> _getSteps(BuildContext context) {
    spr = <Step>[
      Step(
        title: Text('व्यक्तिगत विवरण',
            style: TextStyle(
              color: (currentStep >= 0) ? tertiary : Colors.grey,
            )),
        isActive: (currentStep >= 0) ? true : false,
        state: _getState(0),
        content: step1(),
      ),
      Step(
        isActive: (currentStep >= 1) ? true : false,
        state: _getState(1),
        title: Text('कागजात',
            style: TextStyle(
              color: (currentStep >= 1) ? tertiary : Colors.grey,
            )),
        content: step2(),
      ),
      Step(
        isActive: (currentStep >= 2) ? true : false,
        state: _getState(2),
        title: Text('प्रमाणित',
            style: TextStyle(
              color: (currentStep >= 2) ? tertiary : Colors.grey,
            )),
        // subtitle: const Text("Error!"),
        content: entry_id != null ? Otp(entry_id: entry_id) : Container(),
      ),
    ];
    return spr;
  }

  StepperType stepperType = StepperType.horizontal;

  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != spr.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  StepState _getState(int i) {
    if (currentStep > i)
      return StepState.complete;
    else if (currentStep == i)
      return StepState.editing;
    else
      return StepState.disabled;
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text("कर दर्ता फारम",
                      style: TextStyle(color: primary, fontSize: 22)),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: photolen == 0 ? Get.height * 2.5 : Get.height * 3.5,
            child: Theme(
              data: ThemeData(
                  shadowColor: Colors.transparent,
                  colorScheme: ColorScheme.light(primary: tertiary)
                      .copyWith(secondary: tertiary)),
              child: Stepper(
                physics: ClampingScrollPhysics(),
                controlsBuilder: (BuildContext context, onStepContinue) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: stepperType == StepperType.horizontal
                                ? Get.width * 0.85
                                : Get.width * 0.75,
                            height: 40,
                            child: currentStep != 2
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      if (currentStep == 0) {
                                        submitForm();
                                        _scrollToTop();
                                      }
                                      if (currentStep == 1) {
                                        if (photolen <= 2) {
                                          EasyLoading.showError(
                                              "कृपया कागजातहरू भर्नुहोस्");
                                        } else {
                                          next();
                                          onStepContinue.onStepContinue;
                                          _scrollToTop();
                                          taxVerifyOTP();
                                        }
                                      }
                                      if (currentStep == 2) {}
                                    },
                                    // onPressed: onStepContinue,
                                    icon: Icon(Icons.send),
                                    label: Text('SEND'.tr,
                                        style: TextStyle(
                                            color: textPrimaryLightColor,
                                            fontSize: 15)),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ))))
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: _getSteps(context),
                type: stepperType,
                currentStep: currentStep,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.list),
          onPressed: switchStepType,
        ),
      ),
    );
  }

//STEP 1 FORM
  step1() {
    return Container(
      child: Column(
        children: [
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: firstname,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'first_name'.tr,
                    ),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: middlename,
                    decoration: new InputDecoration(
                      hintText: 'middle_name'.tr,
                    ),
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: lastname,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'last_name'.tr,
                    ),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: fathername,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'father_name'.tr,
                    ),
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: mothername,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'mother_name'.tr,
                    ),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: grandfathername,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'grand_father'.tr,
                    ),
                  ),
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('GENDER'.tr),
                        isExpanded: true,
                        items: Constants.gender.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!),
                            );
                          },
                        ).toList(),
                        value: _currentGender != null ? _currentGender : null,
                        onChanged: (value) {
                          setState(() {
                            _currentGender = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.attribution_outlined,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('occupationname'.tr),
                        isExpanded: true,
                        items: _occupation.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value: _currentoccupation != null
                            ? _currentoccupation
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _currentoccupation = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.attribution_outlined,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 44.0),
                          margin: EdgeInsets.only(
                              top: 5.0, left: 28.0, right: 16.0),
                          child: DropdownButton(
                            hint: Text('marriage_status'.tr),
                            isExpanded: true,
                            items: _marriage.map(
                              (val) {
                                return DropdownMenuItem(
                                  value: val["value"],
                                  child: Text(val["name"]!.tr),
                                );
                              },
                            ).toList(),
                            value: _currentmaritalstatus != null
                                ? _currentmaritalstatus
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _currentmaritalstatus = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Icon(
                            Icons.people,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.attribution_outlined,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                _currentmaritalstatus != "unmarried" && _currentGender != "male"
                    ? new ListTile(
                        leading: Icon(Icons.person, color: primary),
                        title: new TextFormField(
                          controller: fatherinlawname,
                          // validator: FormBuilderValidators.required(context,
                          //     errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'father_inlawa'.tr,
                          ),
                        ),
                      )
                    : Container(),
                new ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: primary,
                  ),
                  title: new TextFormField(
                    controller: citizenship_number,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'citizenship_number'.tr,
                    ),
                  ),
                ),

                // new ListTile(
                //   leading: Icon(Icons.home, color: primary),
                //   title: new TextFormField(
                //     controller: address,
                //     validator: FormBuilderValidators.required(context,
                //         errorText: 'required_field'.tr),
                //     decoration: new InputDecoration(
                //       hintText: 'address'.tr,
                //     ),
                //   ),
                // ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text(
                          "प्रदेश",
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: _provinces.map((item) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(item, style: TextStyle(color: primary)),
                            ),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _childdistricts = _district[value];

                            this._province = value;

                            selectedDistrict = null;
                            selectedlocallevel = null;
                          });
                        },
                        value: _province,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.location_city,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text(
                          "जिल्ला",
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: _childdistricts?.map((item) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['np_label'],
                                  style: TextStyle(color: primary)),
                            ),
                            value: item['np_label'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _childlocallevel = _localLevel[value];
                            this.selectedDistrict = value;
                          });
                        },
                        value: selectedDistrict,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.location_city,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text(
                          "न.पा. /गा.पा.",
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: _childlocallevel?.map((item) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['np_label'],
                                  style: TextStyle(color: primary)),
                            ),
                            value: item['np_label'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            this.selectedlocallevel = value;
                          });
                        },
                        value: selectedlocallevel,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.location_city,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                new ListTile(
                  leading: Icon(
                    Icons.email,
                    color: primary,
                  ),
                  title: new TextFormField(
                    validator: FormBuilderValidators.email(context),
                    controller: email,
                    decoration: new InputDecoration(
                      hintText: 'EMAIL'.tr,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.phone, color: primary),
                  title: new TextFormField(
                    controller: mobile,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'MOBILE-NUM'.tr,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.phone, color: primary),
                  title: new TextFormField(
                    controller: phonenumber,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'Phone-NUM'.tr,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('Wardno'.tr),
                        isExpanded: true,
                        items: _wards.map(
                          (val) {
                            return DropdownMenuItem(
                                value: val["value"],
                                child: Text(
                                  val["name"]!,
                                ));
                          },
                        ).toList(),
                        value: _currentWard != null ? _currentWard : null,
                        onChanged: (value) {
                          setState(() {
                            _currentWard = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.location_city,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                new ListTile(
                  leading: Icon(Icons.location_city_rounded, color: primary),
                  title: new TextFormField(
                    controller: tole,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'tole'.tr,
                    ),
                    // keyboardType: TextInputType.text,
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.location_city_rounded, color: primary),
                  title: new TextFormField(
                    controller: owner_house_number,

                    decoration: new InputDecoration(
                      hintText: 'owner_house_number'.tr,
                    ),
                    // keyboardType: TextInputType.text,
                  ),
                ),
                familymember.length != 0
                    ? labelText("सम्पति धनीको पारिवारिक बिवरण")
                    : Container(),

                familymember.length != 0 ? listofmember() : Container(),

                labelText("सम्पति धनीको पारिवारिक बिवरण"),
                new ListTile(
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: name,
                    // validator: FormBuilderValidators.required(context,
                    //     errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'familymember_name'.tr,
                    ),
                  ),
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('relation'.tr),
                        isExpanded: true,
                        items: _relation.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value:
                            _currentrelation != null ? _currentrelation : null,
                        onChanged: (value) {
                          setState(() {
                            _currentrelation = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.attribution_outlined,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                addmorefamilymember(),

                // signupButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  var photolen = 0;

  List<dynamic> imageupload = ['', '', '', '', '', '', '', '', '', '', '', ''];
  List<dynamic> filepdf = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List array = [
    {"field": "citizenship_front", "name": "नागरिकताको फोटो अगाडी"},
    {"field": "citizenship_back", "name": "नागरिकताको फोटो पछाडि"},
    {
      "field": "fathercitizenship_front",
      "name": " बुबाको नागरिकताको फोटो अगाडी"
    },
    {"field": "fathercitizenship_back", "name": "बुबाको नागरिकताको फोटो पछाडि"},
    {"field": "passport_photo", "name": "फोटो"},
    {"field": "malpot_rashid", "name": "मालपोत रशिद "},
    {"field": "manjurinama_document", "name": "मन्जुरीनामा कागजात "},
  ];
//Step 2 documents upload
  step2() {
    return Container(
      child: Column(
        // shrinkWrap: true,
        children: <Widget>[
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          Container(
            // height: photolen == 0
            //     ? Get.height * 0.09 * array.length
            //     : Get.height * 0.1 * array.length + (photolen * 303),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: array.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            title: Text(
                              '${array[index]['name']}',
                              style: TextStyle(fontSize: 16, color: text),
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  chooseimage(index, array[index]['field']);
                                },
                                child: Icon(Icons.camera_alt,
                                    color: primary, size: 27)),
                          ),
                        ),
                        imageupload[index] != ''
                            ? Container(
                                width: 500,
                                height: 300,
                                child: Image.file(
                                  File(imageupload[index]),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                        filepdf[index] != ''
                            ? Container(
                                width: 500,
                                height: 300,
                                child: Image.asset('assets/images/pdf.jpg',
                                    height: 80, width: 80, fit: BoxFit.contain),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  addmorefamilymember() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primary),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        label: Text('addmore'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 15)),
        icon: Icon(Icons.add),
        onPressed: () {
          _fbKey.currentState?.save();
          var data = {"family_name": name.text, "relation": _currentrelation};
          familymember.add(data);

          name.clear();
          setState(() {
            _currentrelation = null;
          });
        },
      ),
    );
  }

  listofmember() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: familymember.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(4),
                        },
                        border: TableBorder.all(
                            width: 1, color: Colors.black45), //table border
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("संख्या "),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" नाम "),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('relation'.tr),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${index + 1}"),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("${familymember[index]['family_name']}"),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${familymember[index]['relation']}"),
                            )),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            familymember.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.red[700],
                          ),
                          height: 40.0,
                          width: 120,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: white,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  'हटाउनुहोस',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(tertiary),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 16, horizontal: 100)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        child: Text('SEND'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
        onPressed: () {
          submitForm(); // Get.back();
        },
      ),
    );
  }

  void submit() {
    EasyLoading.show(status: 'Please wait...'.tr);

    _fbKey.currentState?.save();
    var data = {
      "name": name.text,
      "address": address.text,
      "email": email.text,
      "mobile": mobile.text,
      "password": citizenship_number.text,
      "gender": _currentGender,
      "woda": _currentWard,
      "user_img": userimagesignup != null ? userimagesignup : 'noImg.jpg',
    };
    var passdata;
    if (_fbKey.currentState?.validate() == true) {
      signUp(data).then((value) => {
            EasyLoading.dismiss(),
            if (value['success'])
              {
                passdata = {
                  'phone': mobile.text,
                  'user_id': value['data']['id']
                },
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPScreen(data: passdata)))
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error ! Please check all fields !!')))
                // Toast.show("Error ! Please check all fields !!", context,
                //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM)
              }
          });
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error ! Please check all fields !!')));
      // Toast.show("Please check all fields !!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  chooseimage(index, field) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return new Container(
            color: Colors.transparent,
            //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImageFromGallery(index, field);
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.image, color: primary),
                      title: Text('load_gallery'.tr),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      getImageFromCamera(index, field);
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.camera, color: primary),
                      title: Text('open_camera'.tr),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.cancel_outlined, color: primary),
                      title: Text('cancel'.tr),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera(index, field) async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        var a = {
          index: image,
        };
        setState(() {});
        EasyLoading.show(status: 'Please wait...'.tr);

        fileuploadTaxDocument(image, entry_id, field).then((res) => {
              EasyLoading.dismiss(),
              if (res == 200)
                {
                  if (imageupload[index] == '' && filepdf[index] == '')
                    {
                      setState(() {
                        photolen++;
                      }),
                    },
                  setState(() {
                    imageupload[index] = image.path;
                    filepdf[index] = '';
                  }),

                  // imgfilecount++,
                }
              else
                {EasyLoading.showError(res['message'])}
            });
      }
    });
  }

  labelText(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: primary)),
    );
  }

  Future getImageFromGallery(index, field) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        var a = {
          index: image,
        };
        EasyLoading.show(status: 'Please wait...'.tr);

        fileuploadTaxDocument(image, entry_id, field).then((res) => {
              EasyLoading.dismiss(),
              if (res == 200)
                {
                  if (imageupload[index] == '' && filepdf[index] == '')
                    {
                      setState(() {
                        photolen++;
                      }),
                    },
                  setState(() {
                    imageupload[index] = image.path;
                    filepdf[index] = '';
                  }),

                  // imgfilecount++,
                }
              else
                {
                  EasyLoading.showError('netwok_error_please_try_again'.tr),
                }
            });
      }
    });
  }

  pdffilechooser(index, field) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        // filepdf.insert(index, 'file_upload_successful'.tr);
      });
      EasyLoading.show(status: 'Please wait...'.tr);

      fileuploadTaxDocument(file, entry_id, field).then((res) => {
            EasyLoading.dismiss(),
            if (res == 200)
              {
                if (imageupload[index] != '')
                  {
                    setState(() {
                      imageupload[index] = '';
                    }),
                  },
                if (filepdf[index] == '' && imageupload[index] == '')
                  {
                    photolen++,
                  },
                setState(() {
                  filepdf[index] = 'file_upload_successful'.tr;
                }),
                // filepdf.insert(index, 'file_upload_successful'.tr),
                // imgfilecount++,
                // setState(() {
                //   photolen++;
                // }),
              }
            else
              {EasyLoading.showError('netwok_error_please_try_again'.tr)}
          });
      // User canceled the picker
    }
  }

  Widget? submitForm() {
    _fbKey.currentState?.save();
    EasyLoading.show(status: 'Please wait...'.tr);

    if (name.text != '') {
      var data = {"family_name": name.text, "relation": _currentrelation};
      familymember.add(data);
      name.clear();
      setState(() {
        _currentrelation = null;
      });
    }
    var data = {
      "owner_first_name": firstname.text,
      "owner_middle_name": middlename.text,
      "owner_last_name": lastname.text,
      "father_name": fathername.text,
      "mother_name": mothername.text,
      "grandfather_name": grandfathername.text,
      "citizenship_number": citizenship_number.text,
      "occupation": _currentoccupation,
      "owner_district": selectedDistrict,
      "owner_province": _province,
      "owner_local": selectedlocallevel,
      "owner_ward": _currentWard,
      "owner_tole": tole.text,
      "owner_house_number": owner_house_number.text,
      "owner_telephone": phonenumber.text,
      "owner_mobile": mobile.text,
      "owner_email": email.text,
      "family_members": familymember,
      "gender": Constants.gender,
      "maritial_status": _currentmaritalstatus,
      "mun_rmun": selectedlocallevel,
    };

    if (_fbKey.currentState?.validate() == true) {
      posttaxpayerdetails(data).then((res) => {
            if (res['status'] == true)
              {
                EasyLoading.dismiss(),
                next(),
                _scrollToTop(),
                setState(() {
                  entry_id = res['data']['owner_id'];
                })
              }
            else
              {
                EasyLoading.showError(res['message']),
              }
          });
    } else {
      EasyLoading.dismiss();

      // enterotp();
      _fbKey.currentState.printError(info: "Plese fill all field");
      // next();
    }
    return null;
  }

  // sends otp in otp screen
  taxVerifyOTP() {
    var data = {
      'owner_id': entry_id,
    };
    taxRegisterotpAPi(data);
  }

  taxRegisterFinal(data) {
    var data = {
      'owner_id': entry_id,
      // 'otp': Otp().,
    };
    taxRegisterSubmit(data);
  }
}

class BlogImage {
  const BlogImage({
    required this.storagePath,
    required this.originalUrl,
    required this.bucketName,
    this.id,
  });

  final String? storagePath;
  final String? originalUrl;
  final String? bucketName;
  final String? id;

  static String get collectionPath => "blogImages";

  create() {}

  // static Future<BlogImage> fromUrl(String url) async {}
}
