import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/sifarishbasicfieldmodal.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SifarishFormChild extends StatefulWidget {
  final data;
  final wardNumber;
  SifarishFormChild({this.data, required this.wardNumber});
  @override
  _SifarishFormChildState createState() => _SifarishFormChildState();
}

class _SifarishFormChildState extends State<SifarishFormChild> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    late Map<String, AbstractControl<dynamic>> formMap = {
      "count": FormControl<int>(validators: []),
    };
  late final FormGroup form;
  ScrollController? _scrollController;
  List documentfields = [];
  dynamic userdata;

//first basic form bata aako data lai manage garna ko lagi garira ho
  dynamic requiredfiledlist;
  dynamic mandatorydocuments;
  List array = [];
  List array1 = [];
  List dhacha = [];
  dynamic entry_id;
  dynamic child_status;
  int photolen = 0;
  dynamic imgfilecount;
  dynamic child_label;
  dynamic count;
  dynamic child_id;
  dynamic paymentdetails;
  final LocalStorage storage = new LocalStorage('changu');

  Future<BasicformModal> sifarishcall() async {
    var a = {'form_id': widget.data['form_id']};
    BasicformModal? sifarishlist = await sifarishchildFormfieldWithIdApi(a);
    if (sifarishlist!.fields != null) {
      for (var sifarishField in sifarishlist.fields!) {
        formMap[sifarishField.db_field] = FormControl<String>(validators: [
          if (sifarishField.type != "photo" &&
              sifarishField.type != "finger_print")
            Validators.required,
        ]);
      }
    }
    this.form = FormGroup(formMap);
    return sifarishlist;
  }

  void deactivate() {
    EasyLoading.dismiss();
  }

  // sifarish
  String fullName = "";

  // final form = FormGroup({
  //   "count": FormControl<int>(validators: []),
  //   'child_field1': FormControl<String>(validators: []),
  //   'child_field2': FormControl<String>(validators: []),
  //   'child_field3': FormControl<String>(validators: []),
  //   'child_field4': FormControl<String>(validators: []),
  //   'child_field5': FormControl<String>(validators: []),
  //   'child_field6': FormControl<String>(validators: []),
  //   'child_field7': FormControl<String>(validators: []),
  //   'child_field8': FormControl<String>(validators: []),
  //   'child_field9': FormControl<String>(validators: []),
  //   'child_field10': FormControl<String>(validators: []),
  //   'child_field11': FormControl<String>(validators: []),
  //   'child_field12': FormControl<String>(validators: []),
  //   'child_field13': FormControl<String>(validators: []),
  //   'child_field14': FormControl<String>(validators: []),
  //   'child_field15': FormControl<String>(validators: []),
  //   'child_field16': FormControl<String>(validators: []),
  //   'child_field17': FormControl<String>(validators: []),
  //   'child_field18': FormControl<String>(validators: []),
  //   'child_field19': FormControl<String>(validators: []),
  //   'child_field20': FormControl<String>(validators: []),
  // });

  dynamic formid;
  dynamic autolength;
  Future? getPopluarProductsFuture;

  @override
  void initState() {
    super.initState();
    var a = {'form_id': widget.data['form_id']};
    sifarishchildFormfieldWithIdApi(a).then((value) => null);

    setState(() {
      count = widget.data['count'];
      entry_id = widget.data['entry_id'];
    });
    dynamic s = storage.getItem('user');

    districtApi();
    localLevelApi();
    getsoredata();
    getPopluarProductsFuture = sifarishcall();
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  var _district;
  var districtforpro;
  var locallevelfordist;

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

  var _provinces = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];
  void _scrollToTop() {
    _scrollController?.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  getsoredata() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    dynamic s = jsonDecode(pref.getString('user')!);
    setState(() {
      userdata = s;
    });
  }

  var _currentGender;
  var _wodanumber;
  var _relation;

  var fields = {
    "field1": null,
    "field2": null,
    "field3": null,
    "field4": null,
    "field5": null,
    "field6": null,
    "field7": null,
    "field8": null,
    "field9": null,
    "field10": null,
  };

  // dynamic _currentWard;
  var field2 = TextEditingController();
  var field3 = TextEditingController();
  var field4 = TextEditingController();
  var field5 = TextEditingController();
  var field6 = TextEditingController();
  var field7 = TextEditingController();
  var field8 = TextEditingController();
  var field9 = TextEditingController();
  var field10 = TextEditingController();
  var field11 = TextEditingController();
  var field12 = TextEditingController();
  var field13 = TextEditingController();
  var field1 = TextEditingController();
  var field = TextEditingController();

  // var _gender = [
  //   {"name": "Male", "value": "male"},
  //   {"name": "Female", "value": "female"},
  //   {"name": "others", "value": "other"}
  // ];

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
                  child: Text(
                    '${widget.data['childlabel']}' + ' संख्या ' + '$count',
                    style: TextStyle(
                      color: primary,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                  ),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.list),
          onPressed: switchStepType,
        ),
        body: FutureBuilder(
            future: getPopluarProductsFuture,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerWidget().buildMovieShimmer();
              } else if (snapshot.hasError) {
                return Container();
              } else if (snapshot.hasData) {
                child_label = snapshot.data.childlabel;
                return Theme(
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
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: stepperType == StepperType.horizontal
                                    ? Get.width * 0.85
                                    : Get.width * 0.75,
                                height: 40,
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (currentStep == 0) {
                                        setState(() {
                                          _scrollToTop();
                                        });

                                        var datalist = {
                                          'form_id': widget.data['form_id'],
                                          'entry_id': widget.data['entry_id'],
                                          // "child_field1": this
                                          //     .form
                                          //     .control('child_field1')
                                          //     .value,
                                          // "child_field2": this
                                          //     .form
                                          //     .control('child_field2')
                                          //     .value,
                                          // "child_field3": this
                                          //     .form
                                          //     .control('child_field3')
                                          //     .value,
                                          // "child_field4": this
                                          //     .form
                                          //     .control('child_field4')
                                          //     .value,
                                          // "child_field5": this
                                          //     .form
                                          //     .control('child_field5')
                                          //     .value,
                                          // "child_field6": this
                                          //     .form
                                          //     .control('child_field6')
                                          //     .value,
                                          // "child_field7": this
                                          //     .form
                                          //     .control('child_field7')
                                          //     .value,
                                          // "child_field8": this
                                          //     .form
                                          //     .control('child_field8')
                                          //     .value,
                                          // "child_field9": this
                                          //     .form
                                          //     .control('child_field9')
                                          //     .value,
                                          // "child_field10": this
                                          //     .form
                                          //     .control('child_field10')
                                          //     .value,
                                          // "child_field11": this
                                          //     .form
                                          //     .control('child_field11')
                                          //     .value,
                                          // "child_field12": this
                                          //     .form
                                          //     .control('child_field12')
                                          //     .value,
                                          // "child_field13": this
                                          //     .form
                                          //     .control('child_field13')
                                          //     .value,
                                          // "child_field14": this
                                          //     .form
                                          //     .control('child_field14')
                                          //     .value,
                                          // "child_field15": this
                                          //     .form
                                          //     .control('child_field15')
                                          //     .value,
                                          // "child_field16": this
                                          //     .form
                                          //     .control('child_field16')
                                          //     .value,
                                          // "child_field17": this
                                          //     .form
                                          //     .control('child_field17')
                                          //     .value,
                                          // "child_field18": this
                                          //     .form
                                          //     .control('child_field18')
                                          //     .value,
                                          // "child_field19": this
                                          //     .form
                                          //     .control('child_field18')
                                          //     .value,
                                          // "child_field20": this
                                          //     .form
                                          //     .control('child_field18')
                                          //     .value,
                                          "pp_photo": uploadPPImage,
                                          // "full_name": fullName,
                                        };
                                        for (var key in formMap.keys) {
                                          datalist[key] =
                                              this.form.control(key).value;
                                        }
                                        // var navigationdata;

                                        if (this.form.valid) {
                                          EasyLoading.show(
                                              status: 'Please wait...'.tr);
                                          // MultipartFile.fromPath();
                                          childinfoFormsubmitApi(datalist)
                                              .then((value) => {
                                                    EasyLoading.dismiss(),
                                                    form.reset(),
                                                    array.clear(),
                                                    dhacha.clear(),
                                                    ppImagePath = "",
                                                    uploadRightF = null,
                                                    uploadLeftF = null,
                                                    uploadPPImage = null,
                                                    if (value['required_documents']
                                                            .length >
                                                        0)
                                                      {
                                                        value['required_documents']
                                                            .forEach(
                                                                (key, value) {
                                                          requiredfiledlist = {
                                                            'key': "$key",
                                                            'value': "$value"
                                                          };
                                                          array.add(
                                                              requiredfiledlist);
                                                        }),
                                                        value['mandatory_documents']
                                                            .forEach((key) {
                                                          mandatorydocuments = {
                                                            'key': "$key",
                                                          };
                                                          array1.add(
                                                              mandatorydocuments);
                                                        }),
                                                        child_id = value['data']
                                                            ['child_id'],
                                                        if (value['dhacha'] ==
                                                            null)
                                                          {
                                                            // dhacha.add(value['dhacha']),
                                                          },
                                                      },
                                                    if (value != null)
                                                      {
                                                        next(),
                                                        _scrollToTop(),
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode())
                                                        // onStepContinue(),
                                                      }
                                                  });
                                        } else {
                                          EasyLoading.showInfo(
                                              'required_fields'.tr,
                                              duration:
                                                  Duration(milliseconds: 2000));
                                        }
                                      } else if (count >= 2 &&
                                          currentStep == 1) {
                                        //!Changes count till its 1 and currentStep to 0
                                        setState(() {
                                          _scrollToTop();
                                          count = count - 1;
                                          onStepContinue.onStepContinue;
                                          next();
                                          currentStep = 0;
                                        });
                                      } else if (count == 1 &&
                                          currentStep == 1) {
                                        setState(
                                          () {
                                            var a = {
                                              'entry_id':
                                                  widget.data['entry_id']
                                            };

                                            EasyLoading.showInfo(
                                              'Please wait...'.tr,
                                            );

                                            sifarishpayment(a).then(
                                              (value) => {
                                                paymentdetails = {
                                                  'name': userdata['name'],
                                                  'mobile': userdata['mobile'],
                                                  'pagetitle': "सिफारिश सारांश",
                                                  'formName':
                                                      widget.data['formName'],
                                                  'formNum':
                                                      widget.data['form_id'],
                                                  'entry_id': entry_id,
                                                  'reference_id': value['data']
                                                      ['reference_id'],
                                                  'amount': value['data']
                                                      ['amount'],
                                                  'sp_pay_code': value['data']
                                                      ['sp_pay_code'],
                                                  'item_type': value['data']
                                                      ['item_type'],
                                                  'pay_id': value['data']
                                                      ['pay_id'],
                                                  'secure_pay_code':
                                                      value['data']
                                                          ['secure_pay_code']
                                                },
                                                EasyLoading.dismiss(),
                                                if (value['data']['amount'] ==
                                                        0 ||
                                                    value['data']['amount'] ==
                                                        0.0000)
                                                  {
                                                    freealert(),
                                                  }
                                                else
                                                  {
                                                    alertboxcall(),
                                                  }
                                              },
                                            );
                                          },
                                        );
                                      } else if (count == 0 &&
                                          currentStep == 1) {
                                        setState(() {
                                          var a = {
                                            'entry_id': widget.data['entry_id']
                                          };
                                          EasyLoading.showInfo(
                                              'Please wait...'.tr);

                                          sifarishpayment(a).then((value) => {
                                                EasyLoading.dismiss(),
                                                if (value['data']['amount'] ==
                                                    0)
                                                  {
                                                    freealert(),
                                                  }
                                                else
                                                  {
                                                    alertboxcall(),
                                                  }
                                              });
                                        });
                                      } else {
                                        EasyLoading.showSuccess(
                                          "तपाईको डाटा प्रक्रियामा रहेको छ, धन्यबाद",
                                        );
                                        Get.off(BottomNavBar());
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //     SnackBar(
                                        //         content: Text(
                                        //             'तपाईको डाटा प्रक्रियामा रहेको छ, धन्यबाद ')));
                                      }
                                      this.field.clear();
                                      this.field2.clear();
                                      this.field3.clear();
                                      this.field4.clear();
                                      this.field5.clear();
                                      this.field6.clear();
                                      this.field7.clear();
                                      this.field8.clear();
                                      this.field9.clear();
                                      this.field10.clear();
                                      this.field11.clear();
                                      this.field12.clear();
                                      this.field13.clear();
                                      uploadPPImage = null;
                                      uploadLeftF = null;
                                      uploadRightF = null;
                                      ppImagePath = "";
                                      rightFinger = "";

                                      leftFinger = "";
                                      // form.reset();
                                    },
                                    // onPressed: onStepContinue,
                                    icon: Icon(Icons.upload),
                                    label: Text('SEND'.tr),
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
                    steps: _getSteps(context, snapshot),
                    type: stepperType,
                    currentStep: currentStep,
                    onStepContinue: next,
                    onStepTapped: (step) => goTo(step),
                    onStepCancel: cancel,
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }

  List<Step> spr = <Step>[];
  List<Step> _getSteps(BuildContext context, AsyncSnapshot snapshot) {
    spr = <Step>[
      Step(
        title: Text('अन्य विवरण',
            style: TextStyle(
              color: (currentStep >= 0) ? tertiary : Colors.grey,
            )),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Icon(
        //       Icons.home,
        //       color: (currentStep >= 0) ? tertiary : Colors.grey,
        //     ),
        //     Text('व्यक्तिगत विवरण',style: TextStyle(color: (currentStep >= 0) ? tertiary : Colors.grey,)),
        //   ],
        // ),
        isActive: (currentStep >= 0) ? true : false,
        state: _getState(0),
        content: step1(snapshot),
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

      //!Payment 3rd Third Step Removed HERE
      // Step(
      //     isActive: (currentStep >= 2) ? true : false,
      //     state: _getState(2),
      //     title: Text('भुक्तानी',
      //         style: TextStyle(
      //           color: (currentStep >= 2) ? tertiary : Colors.grey,
      //         )),
      //     // subtitle: const Text("Error!"),
      //     content: Payment(
      //         data: paymentdetails, ward: int.parse(widget.wardNumber))),
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

  labelText(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: primary)),
    );
  }

  InputDecoration inputTheme() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(30.0)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }

  apifields(AsyncSnapshot snapshot) {
    print("child sifaraish");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (BuildContext context) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              child_status = snapshot.data.form_child;
              child_label = snapshot.data.childlabel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot.data.form_child == '1'
                      ? labelText(snapshot.data.childlabel)
                      : Container(),
                  snapshot.data.form_child == '1'
                      ? ReactiveDropdownField<int>(
                          decoration: inputTheme(),
                          formControlName: 'count',
                          validationMessages: (control) =>
                              {'required': "validation_field".tr},
                          items: [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('1'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('2'),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text('3'),
                              ),
                              DropdownMenuItem(
                                value: 4,
                                child: Text('4'),
                              )
                            ])
                      : Container(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.fields.length,
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        if (snapshot.data.fields[index].type == "text") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[\u0900-\u097F-/ ]+")),
                                ],
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "number") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                keyboardType: TextInputType.number,
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "float") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                keyboardType: TextInputType.number,
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "date") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                onTap: () {
                                  picker
                                      .showAdaptiveDatePicker(
                                          context: context,
                                          initialDate:
                                              picker.NepaliDateTime.now(),
                                          firstDate:
                                              picker.NepaliDateTime(1975),
                                          language: NepaliUtils().language,
                                          lastDate: picker.NepaliDateTime(2100))
                                      .then((value) {
                                    var currencyInWords = NepaliNumberFormat(
                                      inWords: false,
                                    );

                                    var day;
                                    var month;
                                    if (value!.day < 10) {
                                      day = "0${value.day}";
                                    } else {
                                      day = "${value.day}";
                                    }
                                    if (value.month < 10) {
                                      month = "0${value.month}";
                                    } else {
                                      month = "${value.month}";
                                    }
                                    this
                                            .form
                                            .control(snapshot
                                                .data.fields[index].db_field)
                                            .value =
                                        "${NepaliUnicode.convert("${value.year}")}/${NepaliUnicode.convert("$month")}/${NepaliUnicode.convert("$day")}";
                                  });
                                },
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "select") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveDropdownField(
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                // hint: Text('GENDER'.tr),
                                isExpanded: true,
                                items: v.map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: ' $val',
                                      child: Text('$val'),
                                    );
                                  },
                                ).toList(),

                                onChanged: (value) {
                                  setState(() {
                                    this
                                        .form
                                        .control(snapshot
                                            .data.fields[index].db_field)
                                        .value = value;
                                  });
                                },
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "province") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveDropdownField(
                                formControlName:
                                    '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                // hint: Text('GENDER'.tr),
                                isExpanded: true,
                                items: _provinces.map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: ' $val',
                                      child: Text('$val'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) async {
                                  // this
                                  //     .form
                                  //     .control(snapshot
                                  //         .data.fields[index].db_field)
                                  //     .value = value;
                                  setState(() {
                                    var a = int.parse('$value');
                                    districtforpro = _district['$a'];
                                    Future.delayed(Duration(seconds: 3600),
                                        () => 'Result');
                                  });

                                  // });
                                },
                                validationMessages: (control) =>
                                    {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "district") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              districtforpro != null
                                  ? ReactiveDropdownField(
                                      formControlName:
                                          '${snapshot.data.fields[index].db_field}',
                                      decoration: inputTheme(),
                                      // hint: Text('GENDER'.tr),
                                      isExpanded: true,
                                      items: districtforpro!.map(
                                        (val) {
                                          return DropdownMenuItem(
                                            value: '${val['np_label']}',
                                            child: Text('${val['np_label']}'),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        this
                                            .form
                                            .control(snapshot
                                                .data.fields[index].db_field)
                                            .value = value;

                                        setState(() {
                                          locallevelfordist =
                                              _localLevel[value];
                                        });
                                      },
                                      validationMessages: (control) =>
                                          {'required': "validation_field".tr},
                                    )
                                  : Container()
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "local_level") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              locallevelfordist != null
                                  ? ReactiveDropdownField(
                                      formControlName:
                                          '${snapshot.data.fields[index].db_field}',
                                      decoration: inputTheme(),
                                      // hint: Text('GENDER'.tr),
                                      isExpanded: true,
                                      items: locallevelfordist!.map(
                                        (val) {
                                          return DropdownMenuItem(
                                            value: '${val['np_label']}',
                                            child: Text('${val['np_label']}'),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        this
                                            .form
                                            .control(snapshot
                                                .data.fields[index].db_field)
                                            .value = value;
                                      },
                                      validationMessages: (control) =>
                                          {'required': "validation_field".tr},
                                    )
                                  : Container(),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "photo") {
                          print(snapshot.data.fields[index]);
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                                      '${snapshot.data.fields[index].name}',
                                      style:
                                          TextStyle(fontSize: 16, color: text),
                                    ),
                                    trailing: Container(
                                      width: 70,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                chooseimage(index, "photo");
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
                                // Expanded(
                                //   child: labelText(
                                //       snapshot.data.fields[index].name),
                                // ),
                                // Container(),
                                // GestureDetector(
                                //     onTap: () {
                                //       chooseimage(index, "photo");
                                //     },
                                //     child: Icon(Icons.camera_alt,
                                //         color: primary, size: 27)),
                                // Card(
                                //   elevation: 0,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20.0),
                                //   ),
                                //   child: ListTile(
                                //     // title: Text(
                                //     //   '${snapshot.data.fields[index].name}',
                                //     //   style: TextStyle(
                                //     //       fontSize: 16, color: text),
                                //     // ),
                                //     trailing: Container(
                                //       width: 70,
                                //       child: Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [

                                //           // GestureDetector(
                                //           //     onTap: () {
                                //           //       pdffilechooser(index);
                                //           //     },
                                //           //     child: Icon(Icons.attach_file,
                                //           //         color: primary, size: 27))
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                ppImagePath != ""
                                    ? Container(
                                        width: 500,
                                        height: 300,
                                        child: Image.file(
                                          File(ppImagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(),
                                // filepdf[index] != ''
                                //     ? Container(
                                //         width: 500,
                                //         height: 300,
                                //         child: Image.asset('assets/images/pdf.jpg',
                                //             height: 80,
                                //             width: 80,
                                //             fit: BoxFit.contain),
                                //       )
                                //     : Container(),
                              ],
                            ),
                          );
                        } else if (snapshot.data.fields[index].type ==
                            "full_name") {
                          return Container();
                        } else {
                          return Container();
                        }
                      }),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget step1(AsyncSnapshot snapshot) {
    return Column(
      children: [
        Column(
          children: [
            ReactiveForm(
                formGroup: this.form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    apifields(snapshot),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  step2() {
    if (array.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("कुनै आवेदन फेला परेन, कृपया अगाडि बढ्नुहोस् । ",
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // height: photolen == 0
              //     ? Get.height * 0.1 * array.length
              //     : Get.height * 0.1 * array.length + (photolen * 303),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: array.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    // if (array.isEmpty) {
                    //   return Padding(
                    //     padding: const EdgeInsets.only(bottom: 5.0),
                    //     child: Text(
                    //         "कुनै आवेदन फेला परेन, कृपया अगाडि बढ्नुहोस् । ",),
                    //   );
                    // }
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
                                '${array[index]['value']}',
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
                                          chooseimage(index, "");
                                        },
                                        child: Icon(Icons.camera_alt,
                                            color: primary, size: 27)),
                                    GestureDetector(
                                        onTap: () {
                                          pdffilechooser(index);
                                        },
                                        child: Icon(Icons.attach_file,
                                            color: primary, size: 27))
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
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.contain),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
            ),
            // titleText('form_sample'.tr),
            // Container(
            //     height: Get.height * 0.09 * dhacha.length,
            //     child: ListView.builder(
            //         itemCount: dhacha.length,
            //         itemBuilder: (BuildContext ctxt, int index) {
            //           return ListTile(
            //             title: Text(
            //               '${dhacha[index].dhacha_name}',
            //               style: TextStyle(fontSize: 16, color: text),
            //             ),
            //             leading:
            //                 Icon(Icons.file_present, color: primary, size: 27),
            //           );
            //         })),
          ],
        ),
      );
    }
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(color: primary, fontSize: 18)),
    );
  }

  chooseimage(index, type) {
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
                      getImageFromGallery(index, type);
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.image, color: primary),
                      title: Text('load_gallery'.tr),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      getImageFromCamera(index, type);
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

  Future getImageFromGallery(index, type) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    Uint8List imagebytes = await image!.readAsBytes();
    //  MultipartFile.fromFile();
    // image.path;
    // final bytes = Io.File(image.path).readAsBytesSync();

    // String img64 = base64Encode(bytes);
    // print(img64);

    setState(() {
      var a = {
        index: image,
      };

      if (type == "photo") {
        String base64string =
            base64.encode(imagebytes); //convert bytes to base64 string
        // print(base64string);
        setState(() {
          ppImagePath = image.path;
          uploadPPImage = base64string;
          // filepdf[index] = '';
        });
      } else {
        EasyLoading.show(status: 'Please wait...'.tr);
        childsifarishdocsupload(image, child_id, index + 1).then((res) => {
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
                  imgfilecount++,
                }
              else
                {EasyLoading.showError('netwok_error_please_try_again'.tr)}
            });
      }
    });
  }

  List<dynamic> imageupload = [
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
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];

  //PassportSize picture
  String ppImagePath = "";
  String rightFinger = "";
  String leftFinger = "";
  //For bas64 image
  String? uploadPPImage;
  String? uploadRightF;
  String? uploadLeftF;
  Future getImageFromCamera(index, type) async {
    final ImagePicker _picker = ImagePicker();

    var image = await _picker.pickImage(source: ImageSource.camera);
    Uint8List imagebytes = await image!.readAsBytes();
    setState(() {
      // var a = {
      //   index: image,
      // };

      if (type == "photo") {
        //convert to bytes
        String base64string =
            base64.encode(imagebytes); //convert bytes to base64 string
        print(base64string);
        setState(() {
          ppImagePath = image.path;
          uploadPPImage = base64string;
          // filepdf[index] = '';
        });
      } else {
        EasyLoading.show(status: 'Please wait...'.tr);

        fileupload(image, child_id, index + 1).then((res) => {
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
                  imgfilecount++,
                }
              else
                {EasyLoading.showError('netwok_error_please_try_again'.tr)}
            });
      }
    });
  }

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
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];

  pdffilechooser(index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File? file = File(result.files.single.path!);

      EasyLoading.show(status: 'Please wait...'.tr);

      childsifarishdocsupload(file, child_id, index + 1).then((res) => {
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
                imgfilecount++,
                // setState(() {
                //   photolen++;
                // }),
              }
            else
              {}
          });
    } else {
      EasyLoading.showError('netwok_error_please_try_again'.tr);
      // User canceled the picker
    }
  }

  freealert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('दर्ता सफल',
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text(
                'यो सेवा नि:शुल्क रहेको छ। तपाईले भर्नुभएको ई-सिफारिस काठमाडौँ महानगरपालिका वडा कार्यालयमा दर्ता भएको छ। आवेदन तथा दस्तावेज मान्य भएको खण्डमा सिफारिश प्रतिलिपि यसै एप्स वा ईमेलमार्फत पाउनुहुनेछ। दस्तावेज मान्य नभएमा त्यसको जानकारी पाउनुहुनेछ।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(tertiary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('धन्यबाद'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.off(BottomNavBar());
                  },
                ),
              ),
            ],
          );
        });
  }

  submitbasicformfield() {}

  alertboxcall() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text('दर्ता सफल',
              textAlign: TextAlign.center, style: TextStyle(color: primary)),
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
                  backgroundColor: WidgetStateProperty.all(tertiary),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
                  Navigator.pop(context);
                  Get.off(BottomNavBar());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
