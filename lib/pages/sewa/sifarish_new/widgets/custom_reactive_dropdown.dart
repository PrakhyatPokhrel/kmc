import 'package:flutter/material.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_field_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/custom_sifarish_label_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:get/get.dart';

class CustomDropdownType {
  CustomDropdownType({
    required this.displayName,
    required this.value,
  });
  final String displayName;
  final Object value;
}

class CustomReactiveDropdown<T extends CustomDropdownType>
    extends StatefulWidget {
  const CustomReactiveDropdown({
    Key? key,
    required this.field,
    this.isDropdownTypeString = false,
    this.itemList,
  }) : super(key: key);

  final SifarishFieldModel field;
  final bool isDropdownTypeString;
  final List<T>? itemList;

  @override
  State<CustomReactiveDropdown<T>> createState() =>
      _CustomReactiveDropdownState();
}

class _CustomReactiveDropdownState<T extends CustomDropdownType>
    extends State<CustomReactiveDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSifarishLabelText(text: widget.field.label),
          ReactiveDropdownField<CustomDropdownType>(
            formControlName: widget.field.fieldName,
            key: UniqueKey(),
            menuMaxHeight: 400,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(30.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            isExpanded: true,
            validationMessages: (control) => {
              'required': "validation_field".tr,
              'email': "email_validate".tr,
              'maxLength': "maxLength".tr,
              'minLength': "minLength".tr,
              'pattern': "pattern".tr,
            },
            items: widget.field.selectFieldValues!
                .map<DropdownMenuItem<CustomDropdownType>>(
              (CustomDropdownType val) {
                return DropdownMenuItem<CustomDropdownType>(
                  value: val,
                  child: Text(
                    val.displayName,
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
