import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/Auth/otpalert.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyRegister extends StatefulWidget {
  @override
  _PropertyRegisterState createState() => _PropertyRegisterState();
}

class _PropertyRegisterState extends State<PropertyRegister> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _otpkey = GlobalKey<FormBuilderState>();
  final otp = TextEditingController();
  var _currentGender;

  var _currentWard;
  bool checkboxValue = false;
  var onStepContinue;
  // List<ImageInputAdapter> _images;
  _PropertyRegisterState({this.existingImages});
  final List<BlogImage>? existingImages;
  var name = TextEditingController();
  var kittanumber = TextEditingController();
  var sabikgabisa = TextEditingController();
  var sabikwoda = TextEditingController();
  var landropanimeasure = TextEditingController();
  var landaanameasure = TextEditingController();
  var landpaisameasure = TextEditingController();
  var landdaammeasure = TextEditingController();
  var landbighameasure = TextEditingController();
  var landkathameasure = TextEditingController();
  var landdhurmeasure = TextEditingController();

  var jaggalocation = TextEditingController();
  var additionalInfo = TextEditingController();

  var wifename = TextEditingController();
  var husbandname = TextEditingController();

  var landConnectedLocation = TextEditingController();
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

  dynamic land_id;
  String? taxPayerId;

  List? familymember = [];
  ScrollController? _scrollController;
  int? landNumber;

  getTaxPayerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    taxPayerId = prefs.getString("sptaxID");
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    getTaxPayerId();
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController?.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void deactivate() {
    EasyLoading.dismiss();
  }

  var _district;

  // var _gender = [
  //   {"name": "Male", "value": "male"},
  //   {"name": "Female", "value": "female"},
  //   {"name": "others", "value": "other"}
  // ];

  var _currentroadtype;
  var _roadtype = [
    {"name": "गोरेटो", "value": "गोरेटो"},
    {"name": "कच्ची सडक", "value": "कच्ची सडक"},
    {"name": "ग्राभेल सडक", "value": "ग्राभेल सडक"},
    {"name": "पक्कि सडक", "value": "पक्कि सडक"},
  ];
  var _currentareaoflandtype;
  var _area = [
    {"name": "रोपनी/आना/पैसा/दाम", "value": "ropani_aana_paisa"},
    {"name": "बिग्गा/कट्ठा/धुर", "value": "bigha_katha_dhur"},
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

  List<Step> spr = <Step>[];
  List<Step> _getSteps(BuildContext context) {
    spr = <Step>[
      Step(
        title: Text('जग्गाको विवरण',
            style: TextStyle(
              color: (currentStep >= 0) ? tertiary : Colors.grey,
            )),
        isActive: (currentStep >= 0) ? true : false,
        state: _getState(0),
        content: step1jagga(),
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
      // Step(
      //   isActive: (currentStep >= 2) ? true : false,
      //   state: _getState(2),
      //   title: Text('प्रमाणित',
      //       style: TextStyle(
      //         color: (currentStep >= 2) ? tertiary : Colors.grey,
      //       )),
      //   // subtitle: const Text("Error!"),
      //   content: Otp(),
      // ),
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

  clearForm() {
    kittanumber.clear();
    sabikgabisa.clear();
    sabikwoda.clear();
    _currentWard = null;
    _currentareaoflandtype = null;
    landropanimeasure.clear();
    landaanameasure.clear();
    landpaisameasure.clear();
    landdaammeasure.clear();
    landbighameasure.clear();
    landkathameasure.clear();
    landdhurmeasure.clear();
    jaggalocation.clear();
    landConnectedLocation.clear();
    _currentroadtype = null;
    additionalInfo.clear();
    imageupload[0] = '';
    photolen = 0;
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
                  child: Text("सम्पति सूचीकृत फारम",
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
            height: photolen == 0 ? Get.height * 2 : Get.height * 3.5,
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
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  if (currentStep == 0) {
                                    submitForm();
                                  }
                                  if (currentStep == 1) {
                                    // if (landNumber! >= 1) {
                                    //   setState(() {
                                    //     landNumber = landNumber! - 1;
                                    //   });
                                    //   if (landNumber == 0) {
                                    //     print("no of land: $landNumber");
                                    validatePropertyLand();
                                    //   } else {
                                    //     EasyLoading.showSuccess(
                                    //         "next land information".tr,
                                    //         duration: Duration(seconds: 5));
                                    //     currentStep = 0;
                                    //     clearForm();
                                    //     print("no of land: $landNumber");
                                    //   }
                                    // }
                                    // onStepContinue();
                                  }
                                },
                                // onPressed: onStepContinue,
                                icon: Icon(Icons.send),
                                label: Text('SEND'.tr,
                                    style: TextStyle(
                                        color: textPrimaryLightColor,
                                        fontSize: 15)),
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )))),
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
  step1jagga() {
    return Container(
      child: Column(
        children: [
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                new ListTile(
                  leading: Icon(Icons.confirmation_number, color: primary),
                  title: new TextFormField(
                    controller: kittanumber,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'कित्ता नंबर भर्नुहोस',
                    ),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.place, color: primary),
                  title: new TextFormField(
                    controller: sabikgabisa,
                    decoration: new InputDecoration(
                      hintText: 'साबिक गाबिस भर्नुहोस',
                    ),
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.bookmark_add_rounded, color: primary),
                  title: new TextFormField(
                    controller: sabikwoda,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'साबिक वडा नंबर भर्नुहोस',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('हालको वडा नंबर भर्नुहोस'),
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

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('जग्गा को छेत्रफल केमा हाल्न चाहनुहुन्छ '),
                        isExpanded: true,
                        items: _area.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value: _currentareaoflandtype != null
                            ? _currentareaoflandtype
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _currentareaoflandtype = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.format_shapes,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                _currentareaoflandtype != null
                    ? _currentareaoflandtype == _area[0]['value']
                        ? Column(
                            children: [
                              new ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  controller: landropanimeasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल रोपनीमा हाल्नुहोस",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  controller: landaanameasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                      hintText: "छेत्रफल आनामा हाल्नुहोस"),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  controller: landpaisameasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल पैसामा हाल्नुहोस",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  controller: landdaammeasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल दाममा हाल्नुहोस",
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: landbighameasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल बिग्गामा हाल्नुहोस",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: landkathameasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल कट्ठामा हाल्नुहोस",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.legend_toggle_outlined,
                                    color: primary),
                                title: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: landdhurmeasure,
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'required_field'.tr),
                                  decoration: new InputDecoration(
                                    hintText: "छेत्रफल धुरमा हाल्नुहोस",
                                  ),
                                ),
                              ),
                            ],
                          )
                    : Container(),

                new ListTile(
                  leading: Icon(Icons.place, color: primary),
                  title: new TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[\u0900-\u097F-/ ]+")),
                    ],
                    controller: jaggalocation,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'जग्गा रहेको स्थान हाल्नुहोस (नेपालीमा)',
                    ),
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.add_road, color: primary),
                  title: new TextFormField(
                    controller: landConnectedLocation,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'जग्गा जोडिएको मुख्ये सड़क ',
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
                        hint: Text('सडक को प्रकार'),
                        isExpanded: true,
                        items: _roadtype.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value:
                            _currentroadtype != null ? _currentroadtype : null,
                        onChanged: (value) {
                          setState(() {
                            _currentroadtype = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.edit_road,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                new ListTile(
                  leading: Icon(
                    Icons.info,
                    color: primary,
                  ),
                  title: new TextFormField(
                    controller: additionalInfo,
                    decoration: new InputDecoration(
                      hintText: 'अन्य जानकारी भएमा हाल्नुहोस',
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),

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
    {"field": "lalpurja", "name": "लालपुर्जाको फोटो"},
    // {"name": "नागरिकताको फोटो पछाडि"},
    // {"name": " बुबाको नागरिकताको फोटो अगाडी"},
    // {"name": "बुबाको नागरिकताको फोटो पछाडि"},
    // {"name": "फोटो"}
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
                        // filepdf[index] != ''
                        //     ? Container(height: 20, child: Text(filepdf[index]))
                        //     : Container(),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  listofmember() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: familymember?.length,
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
                              child: Text(
                                  "${familymember?[index]['family_name']}"),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("${familymember?[index]['relation']}"),
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
                            familymember?.removeAt(index);
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
            backgroundColor: WidgetStateProperty.all(tertiary),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 16, horizontal: 100)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
      // duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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

        fileuploadLandPropertyDocument(image, land_id, field).then((res) => {
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
                  EasyLoading.showError(res['message']),
                }
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

        fileuploadLandPropertyDocument(image, land_id, field).then((res) => {
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
                  EasyLoading.showError(res['message']),
                }
            });
      }
    });
  }

  pdffilechooser(index) async {
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

      fileupload(file, land_id, index + 1).then((res) => {
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

    var data = {
      "kitta": kittanumber.text,
      "sabik_gabisa": sabikgabisa.text,
      "sabik_woda": sabikwoda.text,
      "woda_id": _currentWard,
      "tax_payer_id": taxPayerId,
      "land_unit": _currentareaoflandtype,
      "area_ropani": landropanimeasure.text,
      "area_aana": landaanameasure.text,
      "area_paisa": landpaisameasure.text,
      "area_daam": landdaammeasure.text,
      "area_bigha": landbighameasure.text,
      "area_katha": landkathameasure.text,
      "area_dhur": landdhurmeasure.text,
      "jagga_tole": jaggalocation.text,
      "sadak_name": landConnectedLocation.text,
      "sadak_type": _currentroadtype,
      "anya_jankari": additionalInfo.text,
    };

    if (_fbKey.currentState?.validate() == true) {
      postLandPropertydetails(data).then((res) => {
            EasyLoading.dismiss(),
            next(),
            _scrollToTop(),
            land_id = res['id'],
          });
    } else {
      EasyLoading.dismiss();

      // enterotp();
      _fbKey.currentState.printError(info: "Plese fill all field");
      // next();
    }
    return null;
  }

  validatePropertyLand() {
    EasyLoading.show(status: 'Please wait...'.tr);
    var data = {
      'property_id': land_id,
    };

    registerProperty(data).then((value) => {
          EasyLoading.dismiss(),
          if (value["status"] == true)
            {
              if (photolen >= 1)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BottomNavBar()),
                      (Route<dynamic> route) => false),
                  EasyLoading.showSuccess("land register message".tr,
                      duration: Duration(
                        seconds: 5,
                      )),
                }
              else
                {
                  EasyLoading.showError("कृपया कागजातहरू भर्नुहोस्"),
                }
            }
          else
            {
              EasyLoading.showError('${value['message']}'),
            }
        });
  }
}

class BlogImage {
  const BlogImage({
    @required this.storagePath,
    @required this.originalUrl,
    @required this.bucketName,
    this.id,
  });

  final String? storagePath;
  final String? originalUrl;
  final String? bucketName;
  final String? id;

  static String? get collectionPath => "blogImages";

  create() {}

  // static Future<BlogImage> fromUrl(String url) async {}
}
