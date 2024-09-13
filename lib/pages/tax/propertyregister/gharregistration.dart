import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/Auth/otpalert.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GharRegister extends StatefulWidget {
  final String? tax_payer_id;
  final String? totalhomes;

  const GharRegister({Key? key, this.tax_payer_id, this.totalhomes})
      : super(key: key);
  @override
  _GharRegisterState createState() => _GharRegisterState();
}

class _GharRegisterState extends State<GharRegister> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _otpkey = GlobalKey<FormBuilderState>();
  final otp = TextEditingController();
  var _currentGender;

  var _currentWard;
  bool? checkboxValue = false;
  var onStepContinue;
  // List<ImageInputAdapter> _images;
  _GharRegisterState({this.existingImages});
  final List<BlogImage>? existingImages;
  var name = TextEditingController();
  var kittanumber = TextEditingController();
  var sabikgabisa = TextEditingController();
  var sabikwoda = TextEditingController();
  var landmeasure = TextEditingController();
  var jaggalocation = TextEditingController();
  var lambai = TextEditingController();
  var chaudai = TextEditingController();
  var land_area = TextEditingController();
  var total_land_area = TextEditingController();

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
  bool? _talshinevalue = false;
  bool? _disputedvalue = false;
  bool? _othervalue = false;

  dynamic house_id;

  List? familymember = [];
  ScrollController? _scrollController;

  List? kittaList = [];
  String? sptaxID;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getTaxPayerID();
  }

  getTaxPayerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sptaxID = prefs.getString("sptaxID");
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

  // var _gender = [
  //   {"name": "Male", "value": "male"},
  //   {"name": "Female", "value": "female"},
  //   {"name": "others", "value": "other"}
  // ];

  var _currentroadtype;
  var _roadtype = [
    {"name": "गोरेटो", "value": "gorato"},
    {"name": "कच्ची सडक", "value": "kachha-sadak"},
    {"name": "पक्की सडक", "value": "pakka-sadak"}
  ];

  var _currentupayog;
  var _upayog = [
    {"name": "व्यापारिक", "value": "business"},
    {"name": "संस्थागत", "value": "industrial"},
    {"name": "औद्योगिक", "value": "organization"},
    {"name": "घरायसी", "value": "household"}
  ];

  var _currentprayogkarta;
  var _prayogkarta = [
    {"name": "स्वयम", "value": "self"},
    {"name": "भाडा", "value": "full_rent"},
    {"name": "मिस्रित", "value": "half_rent"},
  ];

  var _currentgharkobanot;
  var _gharkobanot = [
    {"name": "आर सि सि फ्रेम स्ट्रक्चर", "value": "rcc-frame-structure"},
    {
      "name":
          "सीमेंट वा माटोको जोड़ाईमा ईटा वा ढुङ्गा को गारो- जस्ता टायलको छाना",
      "value": "jastha-tayal"
    },
    {"name": "प्रिफायवको गारो रा टिन को छाना", "value": "prefab-teen"},
    {"name": "सेड", "value": "shade"},
    {"name": "कच्ची घर", "value": "kachhi-ghar"},
  ];
  var _currentGhartype;
  var _ghartype = [
    {"name": "भवन", "value": "bhaban"},
    {"name": "गोदाम", "value": "godam"},
    {"name": "टहरा", "value": "tahara"},
  ];

  var _currentghartalla;
  var _ghartalla = [
    {"name": "१ तल्ला ", "value": "1"},
    {"name": "१.५ तल्ला", "value": "1.5"},
    {"name": "२ तल्ला", "value": "2"},
    {"name": "२.५ तल्ला", "value": "2.5"},
    {"name": "३ तल्ला", "value": "3"},
    {"name": "३.५ तल्ला", "value": "3.5"},
    {"name": "४ तल्ला", "value": "4"},
    {"name": "४.५ तल्ला", "value": "4.5"},
    {"name": "५ तल्ला", "value": "5"},
    {"name": "५.५ तल्ला", "value": "5.5"},
    {"name": "६ तल्ला", "value": "6"},
    {"name": "६.५ तल्ला", "value": "6.5"},
    {"name": "७ तल्ला", "value": "7"},
    {"name": "७.५ तल्ला", "value": "7.5"},
    {"name": "८ तल्ला", "value": "8"},
    {"name": "८.५ तल्ला", "value": "8.5"},
    {"name": "९.५ तल्ला", "value": "9"},
    {"name": "९.५ तल्ला", "value": "9.5"},
    {"name": "१० तल्ला", "value": "10"},
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
        title: Text('घरको विवरण',
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
                                    // onStepContinue();
                                    validatePropertyLand();
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
                  leading: Icon(Icons.person, color: primary),
                  title: new TextFormField(
                    controller: kittanumber,
                    decoration: new InputDecoration(
                      hintText: 'घर रहेको कित्ता नंबर भर्नुहोस',
                    ),
                  ),
                ),

                addmorekitta(),
                kittaList!.length != 0 ? listofkitta() : Container(),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin:
                          EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                      child: DropdownButton(
                        hint: Text('घरको प्रकार '),
                        isExpanded: true,
                        items: _ghartype.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value:
                            _currentGhartype != null ? _currentGhartype : null,
                        onChanged: (value) {
                          setState(() {
                            _currentGhartype = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.house_siding,
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
                        hint: Text('तल्ला'),
                        isExpanded: true,
                        items: _ghartalla.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value: _currentghartalla != null
                            ? _currentghartalla
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _currentghartalla = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Icon(
                        Icons.flip_to_front_rounded,
                        color: primary,
                      ),
                    ),
                  ],
                ),

                new ListTile(
                  leading: Icon(Icons.format_shapes, color: primary),
                  title: new TextFormField(
                    controller: lambai,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'लम्बाई(फुटमा)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.format_shapes, color: primary),
                  title: new TextFormField(
                    controller: chaudai,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'चौडाई(फुटमा)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.format_shapes, color: primary),
                  title: new TextFormField(
                    controller: land_area,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'जगले ओगटेको छेत्रफल',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                new ListTile(
                  leading: Icon(Icons.bookmark_add_rounded, color: primary),
                  title: new TextFormField(
                    controller: total_land_area,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required_field'.tr),
                    decoration: new InputDecoration(
                      hintText: 'कुल ओगटेको छेत्रफल',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectNepaliDate(context);
                  },
                  child: new ListTile(
                    leading: Icon(Icons.date_range, color: primary),
                    title: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5.0)),
                      height: Get.height * 0.05,
                      width: Get.width,
                      child: Text("$construction_date"),
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
                        hint: Text('घरको बनोट र छाना'),
                        isExpanded: true,
                        items: _gharkobanot.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val["value"],
                              child: Text(val["name"]!.tr),
                            );
                          },
                        ).toList(),
                        value: _currentgharkobanot != null
                            ? _currentgharkobanot
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _currentgharkobanot = value;
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
                        hint: Text('घरको उपयोग'),
                        isExpanded: true,
                        items: _upayog.map(
                          (val) {
                            return DropdownMenuItem(
                                value: val["value"],
                                child: Text(
                                  val["name"]!,
                                ));
                          },
                        ).toList(),
                        value: _currentupayog != null ? _currentupayog : null,
                        onChanged: (value) {
                          setState(() {
                            _currentupayog = value;
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
                        hint: Text('प्रयोगकर्ता'),
                        isExpanded: true,
                        items: _prayogkarta.map(
                          (val) {
                            return DropdownMenuItem(
                                value: val["value"],
                                child: Text(
                                  val["name"]!,
                                ));
                          },
                        ).toList(),
                        value: _currentprayogkarta != null
                            ? _currentprayogkarta
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _currentprayogkarta = value;
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

                // new ListTile(
                //   leading: Icon(
                //     Icons.info,
                //     color: primary,
                //   ),
                //   title: new TextFormField(
                //     validator: FormBuilderValidators.email(context),
                //     controller: email,
                //     decoration: new InputDecoration(
                //       hintText: 'अन्य जानकारी भएमा हाल्नुहोस',
                //     ),
                //     keyboardType: TextInputType.multiline,
                //     textInputAction: TextInputAction.newline,
                //     minLines: 1,
                //     maxLines: 5,
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                labelText(
                  "अन्य थप विवरण",
                ),

                CheckboxListTile(
                  title: Text(
                    'talshine_jagga'.tr,
                    style: TextStyle(fontSize: 16, color: text),
                  ),
                  autofocus: false,
                  activeColor: primary,
                  checkColor: Colors.white,
                  selected: _talshinevalue!,
                  value: _talshinevalue,
                  onChanged: (value) {
                    setState(() {
                      _talshinevalue = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(
                    'disputed_jagga'.tr,
                    style: TextStyle(fontSize: 16, color: text),
                  ),
                  autofocus: false,
                  activeColor: primary,
                  checkColor: Colors.white,
                  selected: _disputedvalue!,
                  value: _disputedvalue,
                  onChanged: (value) {
                    setState(() {
                      _disputedvalue = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(
                    'other_jagga'.tr,
                    style: TextStyle(fontSize: 16, color: text),
                  ),
                  autofocus: false,
                  activeColor: primary,
                  checkColor: Colors.white,
                  selected: _othervalue!,
                  value: _othervalue,
                  onChanged: (value) {
                    setState(() {
                      _othervalue = value!;
                    });
                  },
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
    {"field": "nirman_permission", "name": "निर्माण अनुमति"},
    {"field": "karya_sampanna_doc", "name": "कार्य सम्पन्न कागजात"},
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
                            trailing: Container(
                              width: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        chooseimage(
                                            index, array[index]['field']);
                                      },
                                      child: Icon(Icons.camera_alt,
                                          color: primary, size: 27)),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       pdffilechooser(index);
                                  //     },
                                  //     child: Icon(Icons.attach_file,
                                  //         color: primary, size: 27))
                                ],
                              ),
                            ),
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

  addmorekitta() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(primary),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        label: Text('addmore'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 15)),
        icon: Icon(Icons.add),
        onPressed: () {
          _fbKey.currentState?.save();
          var data = {"kitta_number": kittanumber.text};
          setState(() {
            kittaList!.add(data);
          });
          kittanumber.clear();
        },
      ),
    );
  }

  listofkitta() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: kittaList!.length,
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
                              child: Text(" Kitta Number "),
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
                                  Text("${kittaList![index]['kitta_number']}"),
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
                            kittaList?.removeAt(index);
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

  var construction_date = "बनेको मीति";
  selectNepaliDate(context) async {
    final NepaliDateTime? _picked = await picker
        .showAdaptiveDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(1975),
      lastDate: NepaliDateTime.now(),
      language: NepaliUtils().language,
      initialDatePickerMode: DatePickerMode.day,
    )
        .then((value) {
      setState(() {
        construction_date = "${value!.year}-${value.month}-${value.day}";
      });
      return null;
    });
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

    if (kittanumber.text != '') {
      var data = {"kittaNumber": name.text};
      kittaList!.add(data);
      name.clear();
    }

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

        fileuploadHousePropertyDocument(image, house_id, field).then((res) => {
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

        fileuploadHousePropertyDocument(image, house_id, field).then((res) => {
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

      fileuploadHousePropertyDocument(file, 'entry_id', index + 1)
          .then((res) => {
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
                  {EasyLoading.showError(res['message'])}
              });
      // User canceled the picker
    }
  }

  submitForm() {
    _fbKey.currentState?.save();
    EasyLoading.show(status: 'Please wait...'.tr);

    var data = {
      "type": _currentGhartype,
      "talla": _currentghartalla,
      "house_length": lambai.text,
      "width": chaudai.text,
      "land_area": land_area.text,
      "total_land_area": total_land_area.text,
      "construction_date": construction_date,
      "ghar_banot": _currentgharkobanot,
      "ghar_usage": _currentupayog,
      "prayokarta": _currentprayogkarta,
      "talshine_jagga": _talshinevalue,
      "disputed_land": _disputedvalue,
      "other_land": _othervalue,
      "kitta_number": kittaList!.length == 0 ? kittanumber.text : kittaList,
      "tax_payer_id": sptaxID,
    };

    if (_fbKey.currentState?.validate() == true) {
      postGharPropertydetails(data).then((res) => {
            if (res['status'] == true)
              {
                EasyLoading.dismiss(),
                setState(() {
                  house_id = res['data']['id'];
                }),
                next(),
                _scrollToTop(),
              }
            else
              {
                EasyLoading.showError(res['message'],
                    duration: Duration(seconds: 5)),
              }
          });
    } else {
      EasyLoading.dismiss();

      // enterotp();
      _fbKey.currentState.printError(info: "Plese fill all field");
      // next();
    }
  }

  validatePropertyLand() {
    EasyLoading.show(status: 'Please wait...'.tr);

    if (photolen >= 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()),
          (Route<dynamic> route) => false);
      EasyLoading.showSuccess("land register message".tr,
          duration: Duration(
            seconds: 5,
          ));
    } else {
      EasyLoading.showError("कृपया कागजातहरू भर्नुहोस्");
    }
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
