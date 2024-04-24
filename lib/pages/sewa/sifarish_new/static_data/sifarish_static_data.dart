import 'dart:math';

import 'package:flutter/services.dart';
import 'package:kmc/config/replaceable.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/sewa/sifarish_new/static_data/custom_regex_pattern.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_dropdown.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

final staticSifarishFieldListData = [
  SifarishFieldModel(
    fieldName: "name",
    label: "तपाईंको पुरा नाम (नेपालीमा)",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    dummyValue: "नगरपालिका",
    inputFormatter: FilteringTextInputFormatter.allow(
      CustomRegexPattern.nepaliInputWithoutSlash,
    ),
  ),
  SifarishFieldModel(
    fieldName: "citizenship_no",
    label: "नागरिकता नं (नेपालीमा)",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    dummyValue: NepaliUnicode.convert("${Random().nextInt(1000)}"),
  ),
  SifarishFieldModel(
    fieldName: "gender",
    label: "GENDER".tr,
    fieldTypeEnum: SifarishFieldTypeEnum.select,
    dummyValue: "पुरुष",
    selectFieldValues: [
      CustomDropdownType(displayName: "पुरुष", value: "पुरुष"),
      CustomDropdownType(displayName: "महिला", value: "महिला"),
      CustomDropdownType(displayName: "अन्य", value: "अन्य"),
    ],
  ),
  SifarishFieldModel(
      fieldName: "phone",
      label: "मोबाईल नं. (कृपया सही जानकारी प्रदान गर्नुहोला)",
      fieldTypeEnum: SifarishFieldTypeEnum.number,
      dummyValue: "9801138187",
      textInputType: TextInputType.number,
      validators: [
        // Validators.required,
        Validators.maxLength(10),
        Validators.minLength(10)
      ]),
  SifarishFieldModel(
    fieldName: "email",
    label: "ईमेल (भए सम्म प्रदान गर्नुहोला)",
    dummyValue: "saurab.ghimire@cellapp.co",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    textInputType: TextInputType.emailAddress,
    inputFormatter: FilteringTextInputFormatter.allow(
      CustomRegexPattern.englishInput,
    ),
    validators: [
      Validators.email,
    ],
  ),
  SifarishFieldModel(
    fieldName: "address",
    label: "टोल (नेपालीमा)",
    dummyValue: "टोल",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
  ),
  SifarishFieldModel(
    fieldName: "woda_id",
    label: "वडा नं.",
    dummyValue: "1",
    fieldTypeEnum: SifarishFieldTypeEnum.select,
    selectFieldValues: List.generate(
      Config.woda_count,
      (index) => CustomDropdownType(
        displayName: NepaliUnicode.convert((index + 1).toString()),
        value: index + 1,
      ),
    ),
  ),
];

final staticSifarishFieldListDataEnglish = [
  SifarishFieldModel(
    fieldName: "name",
    label: "Name",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    dummyValue: "Municipality",
    inputFormatter: FilteringTextInputFormatter.allow(
      CustomRegexPattern.englishInput,
    ),
  ),
  SifarishFieldModel(
    fieldName: "citizenship_no",
    label: "Citizenship No.",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    dummyValue: "${Random().nextInt(1000)}",
    inputFormatter: FilteringTextInputFormatter.allow(
      CustomRegexPattern.englishInput,
    ),
  ),
  SifarishFieldModel(
    fieldName: "gender",
    label: "Gender",
    fieldTypeEnum: SifarishFieldTypeEnum.select,
    dummyValue: "Male",
    selectFieldValues: [
      CustomDropdownType(displayName: "Male", value: "Male"),
      CustomDropdownType(displayName: "Female", value: "Female"),
      CustomDropdownType(displayName: "Others", value: "Others"),
    ],
  ),
  SifarishFieldModel(
      fieldName: "phone",
      label: "Mobile No.",
      fieldTypeEnum: SifarishFieldTypeEnum.number,
      dummyValue: "9801138187",
      textInputType: TextInputType.number,
      validators: [
        Validators.number,
        Validators.maxLength(10),
        Validators.minLength(10)
      ]),
  SifarishFieldModel(
    fieldName: "email",
    label: "Email",
    dummyValue: "saurab.ghimire@cellapp.co",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
    textInputType: TextInputType.emailAddress,
    inputFormatter: FilteringTextInputFormatter.allow(
      CustomRegexPattern.englishInput,
    ),
    validators: [
      Validators.email,
    ],
  ),
  SifarishFieldModel(
    fieldName: "address",
    label: "Address",
    dummyValue: "tole",
    fieldTypeEnum: SifarishFieldTypeEnum.text,
  ),
  SifarishFieldModel(
    fieldName: "woda_id",
    label: "Ward No.",
    dummyValue: "1",
    fieldTypeEnum: SifarishFieldTypeEnum.select,
    selectFieldValues: List.generate(
      Config.woda_count,
      (index) => CustomDropdownType(
        displayName: (index + 1).toString(),
        value: index + 1,
      ),
    ),
  ),
];
