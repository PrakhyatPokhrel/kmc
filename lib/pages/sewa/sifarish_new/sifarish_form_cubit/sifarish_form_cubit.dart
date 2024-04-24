import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/custom_exception.dart';
import 'package:kmc/config/replaceable.dart';
import 'package:kmc/pages/sewa/api_service/sifarish_api_service.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_form_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/static_data/sifarish_static_data.dart';
import 'package:kmc/pages/sewa/sifarish_new/static_data/custom_regex_pattern.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_reactive_dropdown.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sifarish_form_state.dart';

class SifarishFormCubit extends Cubit<SifarishFormState> {
  SifarishFormCubit() : super(SifarishFormCubitInitial());
  int? selectedChildCount;
  int? successfulEntryId;
  int? successfulChildEntryId;
  late SifarishFormModel sifarishFormGlobal;
  int currentChildCount = 0;
  int currentStep = 0;
  String title = "sifarish".tr;

  FutureOr<void> selectSifarish(SifarishFormModel tempSifarishForm) async {
    emit(SifarishFormCubitInitial());
    sifarishFormGlobal = tempSifarishForm;
    // For field section of parent only (email, name, phone)
    List<SifarishFieldModel> sifarishFields = []
      ..addAll(
        sifarishFormGlobal.isEnglish
            ? staticSifarishFieldListDataEnglish
            : staticSifarishFieldListData,
      )
      ..addAll(sifarishFormGlobal.fields);
    title = sifarishFormGlobal.formName;
    FormGroup formGroup = _getFormGroup(sifarishFields);
    emit(SifarishBuildFormState(
      isChildSifarish: false,
      currentStep: currentStep,
      sifarishFields: sifarishFields,
      sifarishDocuments: sifarishFormGlobal.documents,
      formGroup: formGroup,
      formId: sifarishFormGlobal.formId,
      title: title,
    ));
  }

  FutureOr<void> selectSifarishChild() async {
    emit(SifarishFormCubitInitial());
    // For field section of parent only (email, name, phone)
    List<SifarishFieldModel> sifarishFields = []
      ..addAll(sifarishFormGlobal.childFields);
    if (sifarishFormGlobal.childLabel != null) {
      title = sifarishFormGlobal.childLabel! +
          '- ${sifarishFormGlobal.isEnglish ? currentChildCount.toString() : NepaliUnicode.convert(currentChildCount.toString())}';
    }
    FormGroup formGroup = _getFormGroup(sifarishFields);
    emit(SifarishBuildFormState(
      isChildSifarish: true,
      currentStep: currentStep,
      sifarishFields: sifarishFields,
      sifarishDocuments: sifarishFormGlobal.childDocuments,
      formGroup: formGroup,
      formId: sifarishFormGlobal.formId,
      title: title,
    ));
  }

  Future<void> submitSifarishFields(
      FormGroup formGroup, SifarishBuildFormState state) async {
    try {
      var datalist = {
        'form_id': sifarishFormGlobal.formId,
      };
      for (var key in formGroup.controls.keys) {
        if (formGroup.control(key).value.runtimeType == CustomDropdownType) {
          datalist[key] = formGroup.control(key).value.value.toString();
          continue;
        }
        if (formGroup.control(key).value != null) {
          datalist[key] = formGroup.control(key).value;
        }
      }
      if (formGroup.contains('count')) {
        selectedChildCount = formGroup.control('count').value.value;
      }
      //  var value = await SifarishApiService.postSifarishFields(datalist);
      // successfulEntryId = value['data']['id']['entry_id'];
      successfulEntryId = await SifarishApiService.postSifarishFields(datalist);
         void setDataID(successfulEntryId1) async {
        var pref = await SharedPreferences.getInstance();
        pref.setInt("successEntryId", successfulEntryId1!);
      }

      setDataID(successfulEntryId);
      currentStep = 1;
      emit(SifarishBuildFormState(
        isChildSifarish: false,
        currentStep: currentStep,
        sifarishFields: state.sifarishFields,
        sifarishDocuments: sifarishFormGlobal.documents,
        formGroup: formGroup,
        formId: sifarishFormGlobal.formId,
        title: sifarishFormGlobal.formName,
      ));
    } on CustomException catch (e) {
      emit(SifarishSubmissionErrorState(message: e.message));
    } catch (e) {
      emit(SifarishSubmissionErrorState(message: "please_try_again_later".tr));
    }
  }

  Future<void> submitChildSifarishFields(
      FormGroup formGroup, SifarishBuildFormState state) async {
    try {
      var datalist = {
        'form_id': sifarishFormGlobal.formId,
        'entry_id': successfulEntryId,
      };
      for (var key in formGroup.controls.keys) {
        if (formGroup.control(key).value.runtimeType == CustomDropdownType) {
          datalist[key] = formGroup.control(key).value.value.toString();
          continue;
        }
        datalist[key] = formGroup.control(key).value;
      }
      // var value = await childinfoFormsubmitApi(datalist);
      // successfulChildEntryId = value['data']['child_id'];
      successfulChildEntryId =
          await SifarishApiService.postChildSifarishFields(datalist);
      currentStep = 1;
      emit(SifarishBuildFormState(
        isChildSifarish: true,
        currentStep: currentStep,
        sifarishFields: state.sifarishFields,
        sifarishDocuments: sifarishFormGlobal.childDocuments,
        formGroup: formGroup,
        formId: sifarishFormGlobal.formId,
        title: sifarishFormGlobal.childLabel! +
            '- ${NepaliUnicode.convert(currentChildCount.toString())}',
      ));
    } on CustomException catch (e) {
      emit(SifarishSubmissionErrorState(message: e.message));
    } catch (e) {
      emit(SifarishSubmissionErrorState(message: "please_try_again_later".tr));
    }
  }

  FutureOr<void> submitSifarishDocuments(
      FormGroup formGroup, List<SifarishFieldModel> sifarishDocuments) async {
    try {
      // Uncomment if all fields should be required
      // for (var field in sifarishDocuments) {
      //   if (field.file == null) {
      //     emit(SifarishSubmissionErrorState(
      //       message: 'required_docs'.tr,
      //     ));
      //     return;
      //   }
      // }
      // for (var field in sifarishDocuments) {
      //   if (field.file != null) {
      //     field.file = null;
      //   }
      // }
      if (selectedChildCount != null) {
        currentChildCount++;
        if (currentChildCount <= selectedChildCount!) {
          currentStep = 0;
          selectSifarishChild();
          refreshImageFields(sifarishFormGlobal.childFields);
        } else {
          refreshFields();
          emit(SifarishFormCompletedState());
        }
      } else {
        refreshFields();
        emit(SifarishFormCompletedState());
      }
    } catch (e) {
      emit(SifarishSubmissionErrorState(message: "please_try_again_later".tr));
    }
  }

  FormGroup _getFormGroup(List<SifarishFieldModel> sifarishFields) {
    final Map<String, AbstractControl<dynamic>> map = {};
    for (var field in sifarishFields) {
      if (field.fieldTypeEnum == SifarishFieldTypeEnum.select) {
        map[field.fieldName] = FormControl<CustomDropdownType>(
          validators: field.validators ?? getValidators(field),
          // TODO: dummy-data
          value: Config.fillDummySifarishValue
              ? field.selectFieldValues?.first
              : null,
        );
        continue;
      }
      map[field.fieldName] = FormControl<String>(
        validators: field.validators ?? getValidators(field),
        // TODO: dummy-data
        value: Config.fillDummySifarishValue ? field.dummyValue : null,
      );
    }
    FormGroup formGroup = FormGroup(map);
    // Appends time to recognize dummy data
    if (Config.fillDummySifarishValue) {
      // TODO: dummy-data
      if (formGroup.contains("name")) {
        formGroup.controls["name"]?.value = sifarishFormGlobal.isEnglish
            ? "${formGroup.controls["name"]?.value} ${'${NepaliDateTime.now().hour}'} ${'${NepaliDateTime.now().minute}'}"
            : "${formGroup.controls["name"]?.value} ${NepaliUnicode.convert('${NepaliDateTime.now().hour}')} ${NepaliUnicode.convert('${NepaliDateTime.now().minute}')}";
      }
    }
    ;
    return formGroup;
  }

  Future<bool> uploadFile(
      XFile file, SifarishFieldModel field, FormGroup formGroup) async {
    try {
      EasyLoading.show(status: 'Please wait...'.tr);
      if (field.fieldName.contains("field")) {
        Uint8List imagebytes = await file.readAsBytes();
        String base64string = base64.encode(imagebytes);
        formGroup.controls[field.fieldName]?.value = '-';
        if (field.label == "व्यक्तिको तस्बिर" ||
            field.label == "Passport photo") {
          formGroup
              .addAll({"pp_photo": FormControl<String>(value: base64string)});
          formGroup.controls["pp_photo"]?.value = base64string;
        } else if (field.label == "औंला छाप बायाँ" ||
            field.label == "Left fingerprint") {
          formGroup
              .addAll({"l_finger": FormControl<String>(value: base64string)});
          formGroup.controls["l_finger"]?.value = base64string;
        } else if (field.label == "औंला छाप दायाँ" ||
            field.label == "Right fingerprint") {
          formGroup
              .addAll({"r_finger": FormControl<String>(value: base64string)});
          formGroup.controls["r_finger"]?.value = base64string;
        }
      } else if (successfulChildEntryId != null) {
        // await childsifarishdocsupload(
        //     file, successfulChildEntryId, field.fieldName.split("").last);
        await SifarishApiService.uploadChildSifarishDocument(
          imageFile: file,
          childId: successfulChildEntryId!,
          docIndex: field.fieldName.split("").last,
        );
      } else if (successfulEntryId != null) {
        // var res = await fileupload(file, entryId, field.fieldName.split("").last);
        await SifarishApiService.uploadSifarishDocument(
          imageFile: file,
          entryId: successfulEntryId!,
          docIndex: field.fieldName.split("").last,
        );
      }
      EasyLoading.dismiss();
      return true;
    } on CustomException catch (e) {
      emit(SifarishSubmissionErrorState(message: e.message));
    } catch (e) {
      emit(SifarishSubmissionErrorState(message: "please_try_again_later".tr));
    }
    return false;
  }

  refreshFields() {
    selectedChildCount = null;
    successfulEntryId = null;
    successfulChildEntryId = null;
    currentChildCount = 0;
    currentStep = 0;
    title = "sifarish".tr;
    refreshImageFields(sifarishFormGlobal.fields);
    refreshImageFields(sifarishFormGlobal.childFields);
    refreshImageFields(sifarishFormGlobal.documents);
    refreshImageFields(sifarishFormGlobal.childDocuments);
  }

  refreshImageFields(List<SifarishFieldModel> fields) {
    for (var field in fields) {
      if (field.fieldTypeEnum == SifarishFieldTypeEnum.fingerPrint ||
          field.fieldTypeEnum == SifarishFieldTypeEnum.photo) {
        field.file = null;
      }
    }
  }

  static List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
      getValidators(SifarishFieldModel field) {
    switch (field.fieldTypeEnum) {
      case SifarishFieldTypeEnum.date:
        return [
          Validators.required,
        ];
      case SifarishFieldTypeEnum.number:
        return [
          Validators.required,
          Validators.pattern(CustomRegexPattern.number),
        ];
      default:
        return [
          Validators.required,
        ];
    }
  }
}
