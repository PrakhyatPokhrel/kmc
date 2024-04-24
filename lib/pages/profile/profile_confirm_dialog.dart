import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class ProfileConfirmDialog extends StatefulWidget {
  const ProfileConfirmDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.requireDigitFillUp = true,
    required this.color,
  }) : super(key: key);

  final String title;
  final String description;
  final void Function() onConfirm;
  final bool requireDigitFillUp;
  final Color color;

  @override
  State<ProfileConfirmDialog> createState() => _ProfileConfirmDialogState();
}

class _ProfileConfirmDialogState extends State<ProfileConfirmDialog> {
  final digitController = TextEditingController();
  late String randomNumber = getRandomNumber();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String getRandomNumber() {
    final r = Random();
    return List<int>.generate(4, (index) => r.nextInt(10))
        .fold<String>("", (prev, i) => prev += i.toString());
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.color;
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          // color: color,
          width: 2,
        ),
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))),
              Text(
                'Are you sure you want to delete your account?'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 22),
              Text(
                "Please enter the following numbers to continue".tr,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              if (widget.requireDigitFillUp)
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Text(
                    randomNumber,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              const SizedBox(
                height: 22,
              ),
              if (widget.requireDigitFillUp)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 22,
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: digitController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(),
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return 'Please enter the digits'.tr;
                      }

                      if (value!.length < 4) {
                        return 'Please type all 4 digits'.tr;
                      }
                      if (value != randomNumber) {
                        return 'Please enter correct digits'.tr;
                      }
                      return null;
                    },
                  ),
                ),
              Container(
                width: Size.infinite.width,
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: new ElevatedButton(
                  child: new Text(widget.title,
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    // primary: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // disabledTextColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.requireDigitFillUp &&
                          digitController.text != randomNumber) {
                        return;
                      }
                      widget.onConfirm();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
