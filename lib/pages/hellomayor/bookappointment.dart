// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'package:kmc/modal/addressmodal.dart';
import 'package:kmc/modal/appointmentmodal.dart';

import '../../config/Apiconnectservices.dart';
import '../../config/colors.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool _isButtonDisabled = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final TextEditingController appointment_purpose_controller =
      TextEditingController();
  final TextEditingController message_controller = TextEditingController();
  final TextEditingController organization_controller = TextEditingController();
  final TextEditingController designation_controller = TextEditingController();
  final TextEditingController mobile_controller = TextEditingController();
  final TextEditingController ward_controller = TextEditingController();
  final TextEditingController tole_controller = TextEditingController();
  static List<String> appointment = <String>[
    "बालेन्द्र शाह",
    "सुनिता डंगोल",
    "भूपदेव शाह - स्वकीय सचिव",
    "नविन भण्डारी - सहायक स्वकीय सचिव",
    "नुरनिधि न्यौपाने - निजी सचिव",
    "तपेन्द्र खड्का - सिपिसि उपाध्यक्ष",
    "सुनिल लम्साल - पूर्वाधार सल्लाहकार",
    "रेशु अर्याल ढुंगाना - शिक्षा सल्लाहकार",
    "जगदीश अग्रवाल - स्वास्थ्य सल्लाहकार",
    "सुदीप ढकाल - सूचना प्रविधि सल्लाहकार",
    "जगत्मान श्रेष्ठ - यातायात सल्लाहकार",
    "सुरेन्द्र बजगाईं - प्रेस सल्लाहकार"
  ];
  // void getAppointmentList() {
  //   setState(() async{
  //     appointmentList = await dropdownData();
  //   });
  // }
  final TextEditingController date = TextEditingController();
  Province? selectedProvince;
  final TextEditingController province_controller = TextEditingController();
  District? selectedDistrict;
  LocalLevel? selectedLocalLevel;
  AddressModal? address;
  static const List<String> appointment_purpose = <String>[
    'भेटघाट मात्रै / शिष्टचार',
    'संस्थागत भेटघाट',
    'संस्थागत / व्यापार प्रपोसल',
    'कानुनी मुद्दाको विषय',
    "शिक्षा सम्बन्धि",
    "स्वास्थ्य सम्बन्धि",
    "ट्राफिक / यातायात सम्बन्धि",
    "फोहोर व्यवस्थापन सम्बन्धि",
    'ढल / पूर्वाधार / पार्क सम्बन्धि',
    'आर्थिक सहयोग सम्बन्धि',
    'खानेपानी बिधुत सम्बन्धि',
    'भ्रष्टाचार गुनासो',
    'सल्लाह / सुझाव दिन',
    'अन्य',
  ];
  static List<String> priority = <String>[
    'low',
    'medium',
    'high',
  ];
  static const List<String> _wards = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32'
  ];
  // static List<String> appointment = <String>[
  //   'नगर प्रमुख',
  //   'नगर उपप्रमुख',
  //   'स्वकीय सचिव भूपदेव शाह',
  //   'सहायक स्वकीय सचिव नविन भण्डारी',
  //   'निजी सचिव नुरनिधि न्यौपाने',
  //   'सिपिसि उपाध्यक्ष तपेन्द्र खड्का',
  //   'पूर्वाधार सल्लाहकार सुनिल लम्साल',
  //   'शिक्षा सल्लाहकार रेशु अर्याल ढुंगाना',
  //   'स्वास्थ्य सल्लाहकार जगदीश अग्रवाल',
  //   'सूचना प्रविधि सल्लाहकार सुदीप ढकाल',
  //   'यातायात सल्लाहकार जगत्मान श्रेष्ठ',
  //   'प्रेस सल्लाहकार सुरेन्द्र बजगाईं',
  // ];
  SingingCharacter? _character = SingingCharacter.none;
  var _currentWard;
  String dropdownValue = _wards.first;
  int dropdownValue2 = 1;
  String dropdownValue3 = appointment_purpose.first;
  String dropdownValue4 = priority.first;
  List<dynamic> items = [];
  @override
  void initState() {
    super.initState();
    getAddress();
    dropdownData().then((data) {
      setState(() {
        items = data
            .map((item) => {
                  'id': item['id'],
                  'name': item['name'],
                  'designation': item['designation'] == null
                      ? ""
                      : " - " + item['designation'],
                })
            .toList();
        print(items.toString());
      });
    });
  }

  getAddress() async {
    var res = await getAddressFromJson();
    setState(() {
      address = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text('book_appointment'.tr,
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
      body: Theme(
        data: ThemeData(
          shadowColor: Colors.transparent,
          colorScheme: ColorScheme.light(primary: tertiary)
              .copyWith(secondary: tertiary),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFeild(
                      labeltext: "NAME".tr,
                      text: 'NAME'.tr,
                      required: true,
                      controller: name_controller,
                      icons: Icons.edit_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // labelText('mobile'.tr),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required_field'.tr;
                          }
                          return null;
                        },
                        controller: mobile_controller,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow((RegExp(r'[0-9]'))),
                        ],
                        decoration: inputTheme(
                            Icons.phone_outlined, "mobilenumber".tr)),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFeild(
                      labeltext: "organization".tr,
                      text: 'organization'.tr,
                      required: false,
                      controller: organization_controller,
                      icons: Icons.business,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFeild(
                      labeltext: "Designation".tr,
                      text: 'Designation'.tr,
                      required: false,
                      controller: designation_controller,
                      icons: Icons.engineering,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // labelText('date'.tr),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                      controller: date,
                      decoration:
                          _decoration(Icons.date_range_outlined, 'date'.tr),
                      onTap: () async {
                        DateTime? pickedDate = await showMaterialDatePicker(
                          context: context,
                          initialDate: NepaliDateTime.now(),
                          firstDate: NepaliDateTime
                              .now(), //DateTime.now() - not to allow to choose before today.
                          lastDate: NepaliDateTime(2090),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            date.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // labelText('appointment_purpose'.tr),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == null || value.isBlank!) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                      decoration: _decoration(
                          Icons.subject_outlined, 'appointment_purpose'.tr),
                      isExpanded: true,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue3 = value!;
                        });
                      },
                      items: appointment_purpose
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    if (dropdownValue3 == 'अन्य')
                      CustomTextFeild(
                          controller: appointment_purpose_controller,
                          text: 'appointment_purpose'.tr,
                          labeltext: "appointment_purpose".tr,
                          required: true),
                    // labelText('Priority'.tr),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == null || value.isBlank!) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                      decoration: _decoration(
                          Icons.align_vertical_bottom_rounded, 'Priority'.tr),
                      isExpanded: true,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue4 = value!;
                        });
                      },
                      items: priority
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.tr),
                        );
                      }).toList(),
                    ),
                    // labelText('report_to'.tr),
                    SizedBox(
                      height: 10,
                    ),

                    DropdownButtonFormField(
                      validator: (dynamic value) {
                        if (value == null) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                      decoration: _decoration(
                          Icons.perm_phone_msg_rounded, 'report_to'.tr),
                      isExpanded: true,
                      onChanged: (dynamic newValue) {
                        setState(() {
                           dropdownValue2 = newValue;
                          print(dropdownValue2);
                        });
                      },
                      items: items.map((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value['id'],
                          child: Text(value['name'].toString() +
                              value['designation'].toString()),
                        );
                      }).toList(),
                      // onChanged: (String? value) {
                      //   // This is called when the user selects an item.
                      //   if(kDebugMode ==true){
                      //        if(value == "बालेन्द्र शाह")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 273 ;
                      //   });
                      //   }
                      //   else if(value == "सुनिता डंगोल")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 274;
                      //   });
                      //   }
                      //  else if(value == "भूपदेव शाह - स्वकीय सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 522;
                      //   });
                      //   }
                      //   else if(value ==   "नविन भण्डारी - सहायक स्वकीय सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 523;
                      //   });
                      //   }
                      //  else if(value == "नुरनिधि न्यौपाने - निजी सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 524;
                      //   });
                      //   }
                      // else if(value == "तपेन्द्र खड्का - सिपिसि उपाध्यक्ष")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 525;
                      //   });
                      //   }
                      //   else if(value == "सुनिल लम्साल - पूर्वाधार सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 526;
                      //   });
                      //   }
                      //   else if(value == "रेशु अर्याल ढुंगाना - शिक्षा सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 527;
                      //   });
                      //   }
                      //   else if(value == "जगदीश अग्रवाल - स्वास्थ्य सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 528;
                      //   });
                      //   }
                      //   else if(value ==  "सुदीप ढकाल - सूचना प्रविधि सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 529;
                      //   });
                      //   }
                      //   else if(value ==  "जगत्मान श्रेष्ठ - यातायात सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 530;
                      //   });
                      //   }
                      //   else if(value == "सुरेन्द्र बजगाईं - प्रेस सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 531;
                      //   });
                      //   }
                      //   else{
                      //     return null;
                      //   }
                      //   }
                      //   //for production purposes
                      //   else
                      //   {
                      //      if(value == "बालेन्द्र शाह")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 273 ;
                      //   });
                      //   }
                      //   else if(value == "सुनिता डंगोल")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 274;
                      //   });
                      //   }
                      //  else if(value == "भूपदेव शाह - स्वकीय सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1555;
                      //   });
                      //   }
                      //   else if(value ==   "नविन भण्डारी - सहायक स्वकीय सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1556;
                      //   });
                      //   }
                      //  else if(value == "नुरनिधि न्यौपाने - निजी सचिव")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1557;
                      //   });
                      //   }
                      // else if(value == "तपेन्द्र खड्का - सिपिसि उपाध्यक्ष")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1558;
                      //   });
                      //   }
                      //   else if(value == "सुनिल लम्साल - पूर्वाधार सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1559;
                      //   });
                      //   }
                      //   else if(value == "रेशु अर्याल ढुंगाना - शिक्षा सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1560;
                      //   });
                      //   }
                      //   else if(value == "जगदीश अग्रवाल - स्वास्थ्य सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1561;
                      //   });
                      //   }
                      //   else if(value ==  "सुदीप ढकाल - सूचना प्रविधि सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1562;
                      //   });
                      //   }
                      //   else if(value ==  "जगत्मान श्रेष्ठ - यातायात सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1563;
                      //   });
                      //   }
                      //   else if(value == "सुरेन्द्र बजगाईं - प्रेस सल्लाहकार")
                      //   {
                      //          setState(() {
                      //     dropdownValue2 = 1565;
                      //   });
                      //   }
                      //   else{
                      //     return null;
                      //   }
                      //   }

                      // },
                      // items: appointment
                      //     .map<DropdownMenuItem<String>>((String value) {
                      //   return DropdownMenuItem<String>(
                      //     value: value,
                      //     child: Text(value),
                      //   );
                      // }).toList(),
                    ),
                    labelText(
                      'के तपाई काठमाडौं महानगरपालिकाको निवासी हो?',
                    ),
                    (address != null)
                        ? Row(
                            children: [
                              Radio<SingingCharacter>(
                                activeColor: tertiary,
                                value: SingingCharacter.KathmanduMetro,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              labelText('Yes'.tr),
                              Radio<SingingCharacter>(
                                activeColor: tertiary,
                                value: SingingCharacter.OutsideKathmanduMetro,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              labelText('No'.tr),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                    if (_character == SingingCharacter.KathmanduMetro)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // labelText('ward'.tr),
                          DropdownButtonFormField(
                            decoration:
                                _decoration(Icons.apartment_sharp, 'ward'.tr),
                            isExpanded: true,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                ward_controller.text = value;
                              });
                            },
                            items: _wards
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFeild(
                            labeltext: "tole",
                            text: 'tole'.tr,
                            required: true,
                            controller: tole_controller,
                            icons: Icons.home_outlined,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    if (_character == SingingCharacter.OutsideKathmanduMetro)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // labelText('select_province'.tr),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              content: Container(
                                                color: Colors.white,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  //         // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "select_province".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: GridView.count(
                                                        shrinkWrap: true,
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 0.8,
                                                        mainAxisSpacing: 12,
                                                        crossAxisSpacing: 20,
                                                        children: [
                                                          for (Province province
                                                              in address!
                                                                  .province)
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {
                                                                  selectedProvince =
                                                                      province;
                                                                  province_controller
                                                                          .text =
                                                                      province
                                                                          .textNP;
                                                                  selectedDistrict =
                                                                      null;
                                                                  selectedLocalLevel =
                                                                      null;
                                                                });
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      constraints:
                                                                          const BoxConstraints(
                                                                              maxHeight: 50),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/provinces/${province.id}.png',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child: Text(
                                                                      province
                                                                          .textNP,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color:
                                                                              primary),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        });
                                  },
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty && required == true) {
                                        return 'required_field'.tr;
                                      }
                                      return null;
                                    },
                                    controller: province_controller,
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          (RegExp(r'[0-9]'))),
                                    ],
                                    decoration: inputTheme(
                                            Icons.ac_unit, 'select_province'.tr)
                                        .copyWith(
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (selectedProvince != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // labelText('district'.tr),
                                DropdownButtonFormField<District>(
                                  decoration: _decoration(
                                      Icons.alt_route_sharp, 'district'.tr),
                                  value: selectedDistrict,
                                  isExpanded: true,
                                  onChanged: (District? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      selectedDistrict = value!;
                                      selectedLocalLevel = null;
                                    });
                                  },
                                  items: address!.district
                                      .where((item) =>
                                          item.stateid == selectedProvince?.id)
                                      .map<DropdownMenuItem<District>>(
                                          (District value) {
                                    return DropdownMenuItem<District>(
                                      value: value,
                                      child: Text(value.textNP),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                          if (selectedDistrict != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // labelText('local_level'.tr),
                                DropdownButtonFormField<LocalLevel>(
                                  decoration: _decoration(
                                      Icons.local_library_outlined,
                                      'local_level'.tr),
                                  value: selectedLocalLevel,
                                  isExpanded: true,
                                  onChanged: (LocalLevel? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      selectedLocalLevel = value!;
                                    });
                                  },
                                  items: address!.localLevel
                                      .where((item) =>
                                          item.districtid ==
                                          selectedDistrict?.id)
                                      .map<DropdownMenuItem<LocalLevel>>(
                                          (LocalLevel value) {
                                    return DropdownMenuItem<LocalLevel>(
                                      value: value,
                                      child: Text(value.textNP),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                          if (selectedLocalLevel != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // labelText('ward'.tr),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty && required == true) {
                                      return 'required_field'.tr;
                                    }
                                    return null;
                                  },
                                  controller: ward_controller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        (RegExp(r'[0-9]'))),
                                  ],
                                  decoration: inputTheme(
                                      Icons.apartment_sharp, "ward".tr),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextFeild(
                                  labeltext: "tole",
                                  text: "tole".tr,
                                  required: true,
                                  controller: tole_controller,
                                  icons: Icons.home_outlined,
                                ),
                              ],
                            ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),

                    labelText("MESSAGES".tr),
                    CustomTextFeild(
                      labeltext: "MESSAGES",
                      maxLines: 8,
                      required: true,
                      controller: message_controller,
                      icons: Icons.message_outlined,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            backgroundColor: tertiary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          child: Text('Submit'.tr,
                              style: TextStyle(color: textPrimaryLightColor)),
                          onPressed: _isButtonDisabled
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (!_isButtonDisabled) {
                                      setState(() {
                                        _isButtonDisabled = true;
                                      });
                                      //actual logic here
                                      AppointmentModal appointmentModal =
                                          AppointmentModal(
                                        priority: dropdownValue4,
                                        date: date.text,
                                        name: name_controller.text,
                                        province: selectedProvince?.textNP ??
                                            "बागमति",
                                        district: selectedDistrict?.textNP ??
                                            "काठमाडौँ",
                                        lg: selectedLocalLevel?.textNP ??
                                            "काठमाण्डौं महानगरपालिका",
                                        tole: tole_controller.text,
                                        ward: ward_controller.text,
                                        requestTo: dropdownValue2,
                                        appointmentPurpose: dropdownValue3,
                                        appointmentPurposeOther:
                                            appointment_purpose_controller.text,
                                        message: message_controller.text,
                                        mobile: mobile_controller.text,
                                        designation:
                                            designation_controller.text,
                                        organization:
                                            organization_controller.text,
                                        is_ktm: _character ==
                                                SingingCharacter.KathmanduMetro
                                            ? '1'
                                            : '0',
                                      );

                                      bool isSuccessfullySent =
                                          await createAppointment(
                                              appointmentModal);
                                      if (isSuccessfullySent == true) {
                                        EasyLoading.showInfo(
                                            "अपोइन्टमेन्ट सफलतापूर्वक पठाइयो");
                                      } else {
                                        EasyLoading.showError(
                                            "अपोइन्टमेन्ट पठाउन सकेन कृपया आवश्यक फिल्ड प्रविष्ट गर्नुहोस्");
                                      }
                                      Navigator.pop(context);

                                      setState(() {
                                        _isButtonDisabled = false;
                                      });
                                    }
                                  }
                                },
                        ),
                      ),
                    ),
                    // SizedBox(height: 30,),
                    // GestureDetector(
                    //   onTap: (){
                    //     var listdata=dropdownData();
                    //     print(listdata.toString()+'end');
                    //   },
                    //   child: Text("Check")),
                    // SizedBox(
                    //   height: 50,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final bool required;
  final int? maxLines;
  final IconData? icons;
  final String? text;
  const CustomTextFeild({
    Key? key,
    required this.controller,
    required this.labeltext,
    required this.required,
    this.maxLines,
    this.icons,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // labelText(labeltext.tr),
        TextFormField(
          maxLines: maxLines,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp("[\u0900-\u097F-/ ]+")),
          // ],
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            prefixIcon: Icon(
              icons,
              color: primary,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(30.0)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty && required == true) {
              return 'required_field'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}

InputDecoration inputTheme(icon, text) {
  return InputDecoration(
    hintText: text,
    counterText: "",
    prefixIcon: Icon(
      icon,
      color: primary,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 0),
        borderRadius: BorderRadius.circular(30.0)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
  );
}

labelText(text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16, color: primary)),
  );
}

enum SingingCharacter { KathmanduMetro, OutsideKathmanduMetro, none }

_decoration(icon, text) {
  return InputDecoration(
    hintText: text,
    // labelStyle: TextStyle(color: primary, fontFamily: 'Mukta'),
    prefixIcon: Icon(
      icon,
      color: primary,
    ),
    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
    fillColor: Colors.white, filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
    ),
    // prefixIcon: Icon(Icons.lock, color: primary),
  );
}
