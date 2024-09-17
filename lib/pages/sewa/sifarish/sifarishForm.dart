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
import 'package:kmc/pages/sewa/sifarish/childsifarish.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';

enum ImageType { passport, leftF, rightF, none }

class SifarishForm extends StatefulWidget {
  final data;
  SifarishForm({this.data});
  @override
  _SifarishFormState createState() => _SifarishFormState();
}

class _SifarishFormState extends State<SifarishForm> {
  late final FormGroup form;
  late Map<String, AbstractControl<dynamic>> formMap = {
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [
      Validators.email,
    ]),
    "woda_id": FormControl<String>(validators: [
      Validators.required,
    ]),
    "phone": FormControl<String>(
        validators: [Validators.required, Validators.maxLength(10), Validators.minLength(10)]),
    "address": FormControl<String>(validators: [
      Validators.required,
    ]),
    "citizenship_no": FormControl<String>(validators: [
      Validators.required,
    ]),
    "gender": FormControl<String>(validators: [
      Validators.required,
    ]),
  };
  final LocalStorage storage = new LocalStorage('changu');
  ScrollController? _scrollController;
  dynamic userdata;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List documentfields = [];
//first basic form bata aako data lai manage garna ko lagi garira ho
  dynamic requiredfiledlist;
  dynamic mandatorydocuments;
  List array = [];
  List array1 = [];
  List dhacha = [];
  dynamic entry_id;
  dynamic child_status;
  int photolen = 0;
  int imgfilecount = 0;
  dynamic child_label;
  dynamic count;
  dynamic reference_id;
  dynamic amount;
  dynamic sp_pay_code;
  dynamic item_type;
  dynamic pay_id;
  dynamic paymentdetails;
  //PassportSize picture
  String ppImagePath = "";
  String rightFingerPath = "";
  String leftFingerPath = "";
  //For bas64 image
  String? uploadPPImage;
  String? uploadRightF;
  String? uploadLeftF;
  Future<BasicformModal>? sifarishcall() async {
    var a = {'form_id': widget.data.form_id};

    BasicformModal? sifarishlist = await sifarishbasicFormfieldWithIdApi(a);
    if (sifarishlist!.fields != null) {
      for (var sifarishField in sifarishlist.fields!) {
        formMap[sifarishField.db_field] = FormControl<String>(validators: [
          if (sifarishField.type != "photo" && sifarishField.type != "finger_print") Validators.required,
        ]);
      }
    }
    if (sifarishlist.form_child == 1) {
      formMap['count'] = FormControl<int>(validators: [
        Validators.required,
      ]);
    }
    this.form = FormGroup(formMap);
    return sifarishlist;
  }

  // Future? getPopluarProductsFuture;
  late final Future? sifarishcallInstance;
  @override
  void initState() {
    dynamic s = storage.getItem('user');
    getsoredata();
    districtApi();
    localLevelApi();
    sifarishcallInstance = sifarishcall();
    _scrollController = ScrollController();
    super.initState();
    // print(widget.data['reference_id']);
  }

  var provience;
  var _province;
  List? _childdistricts;
  var selectedDistrict;
  List? _childlocallevel;
  var selectedlocallevel;
  var _district;
  List? districtforpro;
  List? locallevelfordist;

  districtApi() async {
    await getDistrict().then((data) => {
          setState(() {
            _district = data;
            districtforpro = data['3'];
          })
        });
  }

  var _localLevel;

  localLevelApi() async {
    await getLocalLevel().then((data) => {
          setState(() {
            _localLevel = data;
            locallevelfordist = data['काठमाण्डौं'];
          })
        });
  }

  void _scrollToTop() {
    _scrollController?.animateTo(0, duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  getsoredata() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    dynamic s = jsonDecode(pref.getString('user')!);
    setState(() {
      userdata = s;
    });
  }

  // sifarish

  // final form = FormGroup({
  //   'name': FormControl<String>(validators: [Validators.required]),
  //   'email': FormControl<String>(validators: [
  //     Validators.email,
  //   ]),
  //   "woda_id": FormControl<String>(validators: [
  //     Validators.required,
  //   ]),
  //   "phone": FormControl<String>(validators: [
  //     Validators.required,
  //     Validators.maxLength(10),
  //     Validators.minLength(10)
  //   ]),
  //   "address": FormControl<String>(validators: [
  //     Validators.required,
  //   ]),
  //   "citizenship_no": FormControl<String>(validators: [
  //     Validators.required,
  //   ]),
  //   "gender": FormControl<String>(validators: [
  //     Validators.required,
  //   ]),
  //   "count": FormControl<int>(validators: []),
  //   'field1': FormControl<String>(validators: []),
  //   'field2': FormControl<String>(validators: []),
  //   'field3': FormControl<String>(validators: []),
  //   'field4': FormControl<String>(validators: []),
  //   'field5': FormControl<String>(validators: []),
  //   'field6': FormControl<String>(validators: []),
  //   'field7': FormControl<String>(validators: []),
  //   'field8': FormControl<String>(validators: []),
  //   'field9': FormControl<String>(validators: []),
  //   'field10': FormControl<String>(validators: []),
  //   'field11': FormControl<String>(validators: []),
  //   'field12': FormControl<String>(validators: []),
  //   'field13': FormControl<String>(validators: []),
  //   'field14': FormControl<String>(validators: []),
  //   'field15': FormControl<String>(validators: []),
  //   'field16': FormControl<String>(validators: []),
  //   'field17': FormControl<String>(validators: []),
  //   'field18': FormControl<String>(validators: []),
  //   'field19': FormControl<String>(validators: []),
  //   'field20': FormControl<String>(validators: []),
  // });

  dynamic formid;
  dynamic autolength;

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
  var _provinces = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];
  dynamic _currentWard;
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
                    child: Text(widget.data.form_name, style: TextStyle(color: primary, fontSize: 22)),
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
              future: sifarishcallInstance,
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
                        colorScheme: ColorScheme.light(primary: tertiary).copyWith(secondary: tertiary)),
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
                                      ? Get.width * 0.86
                                      : Get.width * 0.78,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      var childformdata;
                                      if (currentStep == 0) {
                                        // setState(() {
                                        //   _scrollToTop();
                                        // });
                                        var datalist = {
                                          'form_id': widget.data.form_id,
                                          // "name": this
                                          //     .form
                                          //     .control('name')
                                          //     .value,
                                          // "email": this
                                          //     .form
                                          //     .control('email')
                                          //     .value,
                                          // "phone": this
                                          //     .form
                                          //     .control('phone')
                                          //     .value,
                                          // "woda_id": this
                                          //     .form
                                          //     .control('woda_id')
                                          //     .value,
                                          // "address": this
                                          //     .form
                                          //     .control('address')
                                          //     .value,
                                          // "citizenship_no": this
                                          //     .form
                                          //     .control('citizenship_no')
                                          //     .value,
                                          // "gender": this
                                          //     .form
                                          //     .control('gender')
                                          //     .value,
                                          // "field1": this
                                          //     .form
                                          //     .control('field1')
                                          //     .value,
                                          // "field2": this
                                          //     .form
                                          //     .control('field2')
                                          //     .value,
                                          // "field3": this
                                          //     .form
                                          //     .control('field3')
                                          //     .value,
                                          // "field4": this
                                          //     .form
                                          //     .control('field4')
                                          //     .value,
                                          // "field5": this
                                          //     .form
                                          //     .control('field5')
                                          //     .value,
                                          // "field6": this
                                          //     .form
                                          //     .control('field6')
                                          //     .value,
                                          // "field7": this
                                          //     .form
                                          //     .control('field7')
                                          //     .value,
                                          // "field8": this
                                          //     .form
                                          //     .control('field8')
                                          //     .value,
                                          // "field9": this
                                          //     .form
                                          //     .control('field9')
                                          //     .value,
                                          // "field10": this
                                          //     .form
                                          //     .control('field10')
                                          //     .value,
                                          // "field11": this
                                          //     .form
                                          //     .control('field11')
                                          //     .value,
                                          // "field12": this
                                          //     .form
                                          //     .control('field12')
                                          //     .value,
                                          // "field13": this
                                          //     .form
                                          //     .control('field13')
                                          //     .value,
                                          // "field14": this
                                          //     .form
                                          //     .control('field14')
                                          //     .value,
                                          // "field15": this
                                          //     .form
                                          //     .control('field15')
                                          //     .value,
                                          // "field16": this
                                          //     .form
                                          //     .control('field16')
                                          //     .value,
                                          // "field17": this
                                          //     .form
                                          //     .control('field17')
                                          //     .value,
                                          // "field18": this
                                          //     .form
                                          //     .control('field18')
                                          //     .value,
                                          // "field19": this
                                          //     .form
                                          //     .control('field18')
                                          //     .value,
                                          // "field20": this
                                          //     .form
                                          //     .control('field18')
                                          //     .value,
                                          "pp_photo": uploadPPImage,
                                          "l_finger": uploadLeftF,
                                          "r_finger": uploadRightF,
                                        };
                                        for (var key in formMap.keys) {
                                          datalist[key] = this.form.control(key).value;
                                        }
                                        if (this.form.contains('count')) {
                                          count = this.form.control('count').value;
                                        }
                                        var navigationdata;
                                        if (this.form.valid) {
                                          EasyLoading.show(status: 'Please wait...'.tr);

                                          basicinfoFormsubmitApi(datalist).then(
                                            (value) => {
                                              EasyLoading.dismiss(),
                                              array.clear(),
                                              dhacha.clear(),
                                              uploadPPImage = null,
                                              uploadRightF = null,
                                              uploadLeftF = null,
                                              ppImagePath = "",
                                              leftFingerPath = "",
                                              rightFingerPath = "",
                                              if (value?['required_documents'].length > 0)
                                                {
                                                  value['required_documents'].forEach(
                                                    (key, value) {
                                                      requiredfiledlist = {'key': "$key", 'value': "$value"};
                                                      array.add(requiredfiledlist);
                                                    },
                                                  ),
                                                  value['mandatory_documents'].forEach((key) {
                                                    mandatorydocuments = {
                                                      'key': "$key",
                                                    };

                                                    array1.add(mandatorydocuments);
                                                  }),
                                                },
                                              entry_id = value['data']['id']['entry_id'],
                                              if (value['dhacha'].length >= 0)
                                                {
                                                  // dhacha.add(value['dhacha']),
                                                },
                                              if (value != null)
                                                {
                                                  next(),
                                                  _scrollToTop(),
                                                  FocusScope.of(context).requestFocus(
                                                    FocusNode(),
                                                  )
                                                }
                                            },
                                          );
                                        } else {
                                          EasyLoading.dismiss();

                                          EasyLoading.showInfo(
                                            'required_fields'.tr,
                                            duration: Duration(
                                              milliseconds: 2000,
                                            ),
                                          );
                                        }
                                      } else if (currentStep == 1) {
                                        EasyLoading.show(status: 'Please wait...'.tr);
                                        _scrollToTop();
                                        if (currentStep == 1 && count != null) {
                                          EasyLoading.dismiss();
                                          childformdata = {
                                            'form_id': widget.data.form_id,
                                            'entry_id': entry_id,
                                            'title': widget.data.form_name,
                                            'childlabel': child_label,
                                            'count': count,
                                            'formName': widget.data.form_name,
                                          };

                                          Get.to(
                                            SifarishFormChild(
                                              data: childformdata,
                                              wardNumber: _currentWard,
                                            ),
                                          );
                                        } else {
                                          if (imgfilecount >= array1.length) {
                                            var a = {'entry_id': entry_id};
                                            sifarishpayment(a).then(
                                              (value) => {
                                                paymentdetails = {
                                                  'name': userdata['name'],
                                                  'mobile': userdata['mobile'],
                                                  'pagetitle': "सिफारिश सारांश",
                                                  'formName': widget.data.form_name,
                                                  'formNum': widget.data.form_id,
                                                  'entry_id': entry_id,
                                                  'reference_id': value['data']['reference_id'],
                                                  'amount': value['data']['amount'],
                                                  'sp_pay_code': value['data']['sp_pay_code'],
                                                  'item_type': value['data']['item_type'],
                                                  'pay_id': value['data']['pay_id'],
                                                  'secure_pay_code': value['data']['secure_pay_code']
                                                },
                                                EasyLoading.dismiss(),
                                                if (value['data']['amount'] == 0 ||
                                                    value['data']['amount'] == 0.0000)
                                                  {
                                                    alertboxcall(),
                                                  }
                                                else
                                                  {
                                                    alertSucessBox(),
                                                  }
                                              },
                                            );
                                          } else {
                                            EasyLoading.showError('upload_all_required_documents'.tr);
                                          }
                                        }
                                      }
                                    },
                                    // onPressed: onStepContinue,
                                    icon: Icon(Icons.upload),
                                    label: Text('SEND'.tr),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ),
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
                  return Container();
                }
              })),
    );
  }

  List<Step> spr = <Step>[];
  List<Step> _getSteps(BuildContext context, AsyncSnapshot snapshot) {
    spr = <Step>[
      Step(
        title: Text('व्यक्तिगत विवरण',
            style: TextStyle(
              color: (currentStep >= 0) ? tertiary : Colors.grey,
            )),
        isActive: (currentStep >= 0) ? true : false,
        state: _getState(0),
        content: step1(snapshot),
      ),
      Step(
        isActive: (currentStep >= 1) ? true : false,
        state: _getState(1),
        title: Text(
          'कागजात',
          style: TextStyle(
            color: (currentStep >= 1) ? tertiary : Colors.grey,
          ),
        ),
        content: step2(),
      ),
      //!3rd Third Payment Step removed
      // Step(
      //   isActive: (currentStep >= 2) ? true : false,
      //   state: _getState(2),
      //   title: Text('भुक्तानी',
      //       style: TextStyle(
      //         color: (currentStep >= 2) ? tertiary : Colors.grey,
      //       )),
      //   // subtitle: const Text("Error!"),
      //   content: paymentdetails != null
      //       ? Payment(data: paymentdetails, ward: int.parse(_currentWard))
      //       : Container(),
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
    currentStep + 1 != spr.length ? goTo(currentStep + 1) : setState(() => complete = true);
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
    if (step > currentStep) {
      setState(() {
        currentStep = step;
      });
    }
    //changed here
    // setState(() => currentStep = step);
  }

  labelText(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, textAlign: TextAlign.left, style: TextStyle(fontSize: 16, color: primary)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (
            context,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              child_label = snapshot.data.childlabel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot.data.form_child == 1 ? labelText(snapshot.data.childlabel) : Container(),
                  snapshot.data.form_child == 1
                      ? ReactiveDropdownField<int>(
                          decoration: inputTheme(),
                          formControlName: 'count',
                          validationMessages: (control) => {'required': "validation_field".tr},
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
                                  FilteringTextInputFormatter.allow(RegExp("[\u0900-\u097F-/ ]+")),
                                ],
                                validationMessages: (control) => {'required': "validation_field".tr},
                                formControlName: '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "number") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                keyboardType: TextInputType.number,
                                formControlName: '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) => {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "float") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveTextField(
                                keyboardType: TextInputType.number,
                                formControlName: '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) => {'required': "validation_field".tr},
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
                                          initialDate: picker.NepaliDateTime.now(),
                                          firstDate: picker.NepaliDateTime(1976),
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
                                    this.form.control(snapshot.data.fields[index].db_field).value =
                                        "${NepaliUnicode.convert("${value.year}")}/${NepaliUnicode.convert("$month")}/${NepaliUnicode.convert("$day")}";
                                  });
                                },
                                formControlName: '${snapshot.data.fields[index].db_field}',
                                decoration: inputTheme(),
                                validationMessages: (control) => {'required': "validation_field".tr},
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "select") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveDropdownField(
                                formControlName: '${snapshot.data.fields[index].db_field}',
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
                                validationMessages: (control) => {'required': "validation_field".tr},

                                onChanged: (value) {
                                  setState(() {
                                    this.form.control(snapshot.data.fields[index].db_field).value = value;
                                  });
                                },
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "province") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(snapshot.data.fields[index].name),
                              ReactiveDropdownField(
                                formControlName: '${snapshot.data.fields[index].db_field}',
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
                                validationMessages: (control) => {'required': "validation_field".tr},
                                onChanged: (value) async {
                                  // this
                                  //     .form
                                  //     .control(snapshot
                                  //         .data.fields[index].db_field)
                                  //     .value = value;
                                  setState(() {
                                    var a = int.parse('$value');
                                    districtforpro = _district['$a'];
                                    Future.delayed(Duration(seconds: 3600), () => 'Result');
                                  });

                                  // });
                                },
                              ),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "district") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              districtforpro != null
                                  ? labelText(snapshot.data.fields[index].name)
                                  : Container(),
                              districtforpro != null
                                  ? ReactiveDropdownField(
                                      formControlName: '${snapshot.data.fields[index].db_field}',
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
                                      validationMessages: (control) => {'required': "validation_field".tr},
                                      onChanged: (value) {
                                        this.form.control(snapshot.data.fields[index].db_field).value = value;

                                        setState(() {
                                          locallevelfordist = _localLevel[value];
                                        });
                                      },
                                    )
                                  : Container()
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "local_level") {
                          List v = [];
                          v = snapshot.data.fields[index].value;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              locallevelfordist != null
                                  ? labelText(snapshot.data.fields[index].name)
                                  : Container(),
                              locallevelfordist != null
                                  ? ReactiveDropdownField(
                                      formControlName: '${snapshot.data.fields[index].db_field}',
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
                                      validationMessages: (control) => {'required': "validation_field".tr},
                                      onChanged: (value) {
                                        this.form.control(snapshot.data.fields[index].db_field).value = value;
                                      },
                                    )
                                  : Container(),
                            ],
                          );
                        } else if (snapshot.data.fields[index].type == "photo") {
                          // print(snapshot.data.fields[index]);
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                                      style: TextStyle(fontSize: 16, color: text),
                                    ),
                                    trailing: Container(
                                      width: 70,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                chooseimage(index, ImageType.passport);
                                              },
                                              child: Icon(Icons.camera_alt, color: primary, size: 27)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ppImagePath != ""
                                    ? Center(
                                        child: Container(
                                          width: 300,
                                          height: 100,
                                          child: Image.file(
                                            File(ppImagePath),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        } else if (snapshot.data.fields[index].type == "finger_print") {
                          // print(snapshot.data.fields[index]);
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                                      style: TextStyle(fontSize: 16, color: text),
                                    ),
                                    trailing: Container(
                                      width: 70,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                if (snapshot.data.fields[index].name == "औंला छाप दायाँ") {
                                                  chooseimage(index, ImageType.rightF);
                                                } else {
                                                  chooseimage(index, ImageType.leftF);
                                                }
                                                // chooseimage(index,
                                                //     ImageType.passport);
                                              },
                                              child: Icon(Icons.camera_alt, color: primary, size: 27)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                snapshot.data.fields[index].name != "औंला छाप दायाँ"
                                    ? leftFingerPath != ""
                                        ? Center(
                                            child: Container(
                                              width: 300,
                                              height: 100,
                                              child: Image.file(
                                                File(leftFingerPath),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : rightFingerPath != ""
                                        ? Center(
                                            child: Container(
                                              width: 300,
                                              height: 100,
                                              child: Image.file(
                                                File(rightFingerPath),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          )
                                        : Container()
                              ],
                            ),
                          );
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

  step1(AsyncSnapshot snapshot) {
    return Column(
      children: [
        Column(
          children: [
            ReactiveForm(
                formGroup: this.form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText('तपाईंको पुरा नाम (नेपालीमा)'),
                    ReactiveTextField(
                      autofocus: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[\u0900-\u097F ]+")),
                      ],
                      decoration: inputTheme(),
                      formControlName: 'name',
                      validationMessages: (control) => {'required': "validation_field".tr},
                    ),
                    labelText('नागरिकता नं (नेपालीमा)'),
                    ReactiveTextField(
                      formControlName: 'citizenship_no',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[\u0900-\u097F-/ ]+")),
                      ],
                      decoration: inputTheme(),
                      validationMessages: (control) => {'required': "validation_field".tr},
                    ),
                    labelText('GENDER'.tr),
                    ReactiveDropdownField(
                      hint: Text('Select ...'),
                      formControlName: 'gender',
                      validationMessages: (control) => {'required': "validation_field".tr},
                      decoration: inputTheme(),
                      // hint: Text('GENDER'.tr),
                      isExpanded: true,
                      items: Constants.gender.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val["value"],
                            child: Text(val["name"]),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        // setState(() {
                        _currentGender = value;
                        // });
                      },
                    ),
                    labelText('मोबाईल नं. (कृपया सही जानकारी प्रदान गर्नुहोला)'),
                    ReactiveTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]+")),
                      ],
                      keyboardType: TextInputType.number,
                      formControlName: 'phone',
                      decoration: inputTheme(),
                      validationMessages: (control) => {'required': "validation_field".tr},
                    ),
                    labelText('ईमेल (भए सम्म प्रदान गर्नुहोला)'),
                    ReactiveTextField(
                      keyboardType: TextInputType.emailAddress,
                      formControlName: 'email',
                      decoration: inputTheme(),
                      validationMessages: (control) => {'email': 'कृपया आफ्नो मान्य इमेल प्रविष्ट गर्नुहोस्'},
                    ),
                    labelText('टोल (नेपालीमा)'),
                    ReactiveTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[\u0900-\u097F-/ ]+")),
                      ],
                      formControlName: 'address',
                      validationMessages: (control) => {'required': "validation_field".tr},
                      decoration: inputTheme(),
                    ),
                    labelText('वडा नं.'),
                    ReactiveDropdownField(
                      hint: Text('Select ...'),
                      validationMessages: (control) => {'required': "validation_field".tr},
                      formControlName: 'woda_id',
                      decoration: inputTheme(),
                      // hint: Text('GENDER'.tr),
                      isExpanded: true,
                      items: _wards.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val["value"],
                            child: Text(val["name"]!),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        // SharedPreferences pref =
                        //     await SharedPreferences.getInstance();
                        // pref.setString('wardNumber', "$value");
                        // setState(() {
                        _currentWard = value;
                        // });
                      },
                    ),
                    apifields(snapshot),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  step2() {
    print(array);
    return Container(
      child: Column(
        // shrinkWrap: true,
        children: <Widget>[
          // Text("adhfoi ewjfiosjf oiasj foiej "),
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          Container(
            // height: 2000,
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
                              '${array[index]['value']}',
                              style: TextStyle(fontSize: 16, color: text),
                            ),
                            trailing: Container(
                              width: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        chooseimage(index, ImageType.none);
                                      },
                                      child: Icon(Icons.camera_alt, color: primary, size: 27)),
                                  GestureDetector(
                                      onTap: () {
                                        pdffilechooser(index);
                                      },
                                      child: Icon(Icons.attach_file, color: primary, size: 27))
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
          // titleText('form_sample'.tr),
          Container(
              height: Get.height * 0.09 * dhacha.length,
              child: ListView.builder(
                  itemCount: dhacha.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      title: Text(
                        '${dhacha[index].dhacha_name}',
                        style: TextStyle(fontSize: 16, color: text),
                      ),
                      leading: Icon(Icons.file_present, color: primary, size: 27),
                    );
                  })),
        ],
      ),
    );
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text('$title'.tr, textAlign: TextAlign.start, style: TextStyle(color: primary, fontSize: 18)),
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
                      topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
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
    var image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    // final bytes = Io.File(image.path).readAsBytesSync();
    Uint8List imagebytes = await image!.readAsBytes();
    // String img64 = base64Encode(bytes);
    // print(img64);

    // setState(() {
    // var a = {
    //   index: image,
    // };
    if (type == ImageType.passport) {
      //convert to bytes
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        ppImagePath = image.path;
        uploadPPImage = base64string;
        // filepdf[index] = '';
      });
    } else if (type == ImageType.rightF) {
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        rightFingerPath = image.path;
        uploadRightF = base64string;
        // filepdf[index] = '';
      });
    } else if (type == ImageType.leftF) {
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        leftFingerPath = image.path;
        uploadLeftF = base64string;
        // filepdf[index] = '';
      });
    } else {
      EasyLoading.show(status: 'Please wait...'.tr);

      fileupload(image, entry_id, index + 1).then((res) => {
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
              {
                EasyLoading.showError('netwok_error_please_try_again'.tr),
              }
          });
    }
    // });
  }

  List<dynamic> imageupload = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];

  Future getImageFromCamera(index, type) async {
    var image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);

    Uint8List imagebytes = await image!.readAsBytes();
    // setState(() {
    if (type == ImageType.passport) {
      //convert to bytes
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        ppImagePath = image.path;
        uploadPPImage = base64string;
        // filepdf[index] = '';
      });
    } else if (type == ImageType.rightF) {
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        rightFingerPath = image.path;
        uploadRightF = base64string;
        // filepdf[index] = '';
      });
    } else if (type == ImageType.leftF) {
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
      setState(() {
        leftFingerPath = image.path;
        uploadLeftF = base64string;
        // filepdf[index] = '';
      });
    } else {
      EasyLoading.show(status: 'Please wait...'.tr);

      fileupload(image, entry_id, index + 1).then((res) => {
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
    // });
  }

  List<dynamic> filepdf = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];

  pdffilechooser(index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      XFile? file = XFile(result.files.single.path!);

      setState(() {
        // filepdf.insert(index, 'file_upload_successful'.tr);
      });
      EasyLoading.show(status: 'Please wait...'.tr);

      fileupload(file, entry_id, index + 1).then((res) => {
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
              {EasyLoading.showError('netwok_error_please_try_again'.tr)}
          });
      // User canceled the picker
    }
  }

  submitbasicformfield() {}

  alertboxcall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('दर्ता सफल', textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text(
                'यो सेवा नि:शुल्क रहेको छ। तपाईले भर्नुभएको ई-सिफारिस काठमाडौँ महानगरपालिका वडा कार्यालयमा दर्ता भएको छ। आवेदन तथा दस्तावेज मान्य भएको खण्डमा सिफारिश प्रतिलिपि यसै एप्स वा ईमेलमार्फत पाउनुहुनेछ। दस्तावेज मान्य नभएमा त्यसको जानकारी पाउनुहुनेछ।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text('ठिक छ'),
                  ),
                  onPressed: () {
                    Get.off(BottomNavBar());
                  },
                ),
              ),
            ],
          );
        });
  }

  alertSucessBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('दर्ता सफल', textAlign: TextAlign.center, style: TextStyle(color: primary)),
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
                    backgroundColor: MaterialStateProperty.all(tertiary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    Navigator.pop(
                      context,
                    );
                    Get.off(BottomNavBar());
                  },
                ),
              ),
            ],
          );
        });
  }

  freealert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('यो सेवा नि:शुल्क रहेको छ।',
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text(
                'यो सेवा नि:शुल्क रहेको छ । कृपया आफ्नो प्रोफाइलमा गएर सिफारिस को बारेमा जानकारी  हेर्नु होला ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tertiary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
}
