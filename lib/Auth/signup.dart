import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/home/signUpOTP.dart';
import 'package:kmc/utils/image_picker/image_picker_dialog.dart';

import '../constants/constants.dart';
import '../pages/sewa/sifarish_new/static_data/custom_regex_pattern.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  var _currentGender;
  var _currentWard;
  bool? checkboxValue = false;
  // List<ImageInputAdapter> _images;
  XFile? imagefile;
  String? imageUploadURL;

  var name = TextEditingController();
  var set_password = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var address = TextEditingController();
  var re_password = TextEditingController();
  @override
  void initState() {}
  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  // var _gender = [
  //   {"name": "पुरुष", "value": "पुरुष"},
  //   {"name": "महिला", "value": "महिला"},
  //   {"name": "अन्य", "value": "अन्य"}
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

    // {"name": "२०", "value": "20"},
    // {"name": "२१", "value": "21"},

    // {"name": "२२", "value": "22"},
    // {"name": "२३", "value": "23"},
    // {"name": "२४", "value": "24"},
    // {"name": "२५", "value": "25"},
    // {"name": "२६", "value": "26"},
    // {"name": "२७", "value": "27"},
    // {"name": "२८", "value": "28"},
    // {"name": "२९", "value": "29"},

    // {"name": "३०", "value": "30"},
    // {"name": "३१", "value": "31"},
    // {"name": "३२", "value": "32"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},
    // {"name": "९", "value": "9"},

    // {"name": "९", "value": "9"},
  ];

  int? userID;

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
                Text('SIGNUP'.tr, style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              children: [
                FormBuilder(
                  key: _fbKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                        leading: Icon(Icons.person, color: primary),
                        title: new TextFormField(
                          controller: name,
                          validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'NAME (English)'.tr,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(CustomRegexPattern.englishInput),
                          ],
                        ),
                      ),

                      new ListTile(
                        leading: Icon(Icons.home, color: primary),
                        title: new TextFormField(
                          controller: address,
                          validator: FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'address'.tr,
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: Icon(
                          Icons.email,
                          color: primary,
                        ),
                        title: new TextFormField(
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                            FormBuilderValidators.email(context, errorText: 'email_validate'.tr),
                          ]),
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
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                            FormBuilderValidators.minLength(
                              context,
                              10,
                              errorText: 'minLength'.tr,
                            ),
                            FormBuilderValidators.maxLength(
                              context,
                              10,
                              errorText: 'maxLength'.tr,
                            ),
                          ]),
                          decoration: new InputDecoration(
                            hintText: 'MOBILE-NUM'.tr,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      // const Divider(
                      //   height: 1.0,
                      // ),
                      Stack(
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.only(left: 44.0),
                            padding: EdgeInsets.only(left: 30.0),
                            margin: EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),

                            child: DropdownButton(
                              hint: Text('GENDER'.tr),
                              isExpanded: true,
                              iconSize: 30,
                              underline: Container(),
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
                            margin: EdgeInsets.only(top: 42.0, left: 54.0, right: 20.0),
                            child: Divider(
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                            child: Icon(
                              Icons.attribution_outlined,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      new ListTile(
                        leading: Icon(
                          Icons.lock,
                          color: primary,
                        ),
                        title: new TextFormField(
                            controller: set_password,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context, errorText: 'required_field'.tr),
                              FormBuilderValidators.minLength(
                                context,
                                6,
                                errorText: 'minLength6'.tr,
                              ),
                            ]),
                            decoration: new InputDecoration(
                              hintText: 'set_password'.tr,
                            ),
                            obscureText: true),
                      ),
                      new ListTile(
                        leading: Icon(
                          Icons.lock,
                          color: primary,
                        ),
                        title: new TextFormField(
                            controller: re_password,
                            validator: (val) {
                              if (val!.isEmpty) return 'required_field'.tr;
                              if (val != set_password.text) return 'password_match'.tr;
                              return null;
                            },
                            decoration: new InputDecoration(
                              hintText: 're_password'.tr,
                            ),
                            obscureText: true),
                      ),
                      //Checkbox
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 8),
                          child: Checkbox(
                              value: checkboxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue = value!;
                                  if (value == false) {
                                    _currentWard = null;
                                  }
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text('nibaasi'.tr),
                        ),
                      ]),

                      checkboxValue == true
                          ? Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 30.0),
                                  margin: EdgeInsets.only(top: 5.0, left: 28.0, right: 16.0),
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: Colors.black54,
                                  //     width: 1.0,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  // ),
                                  child: DropdownButton(
                                    menuMaxHeight: 400,
                                    hint: Text('Wardno'.tr),
                                    isExpanded: true,
                                    underline: Container(),
                                    iconSize: 30,
                                    items: _wards.map(
                                      (val) {
                                        return DropdownMenuItem(
                                            value: val["value"],
                                            child: Text(
                                              val["name"]!,
                                            ));
                                      },
                                    ).toList(),
                                    value: _currentWard,
                                    onChanged: (value) {
                                      setState(() {
                                        _currentWard = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 42.0,
                                    left: 54.0,
                                    right: 20.0,
                                    bottom: 12,
                                  ),
                                  child: Divider(
                                    color: Colors.black54,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                                  child: Icon(
                                    Icons.location_city,
                                    color: primary,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          ImageHandler(onFilePickSuccess: (file) async {
                            String imageName = await registerProfileImageUpload(file);
                            if (imageName != "") {
                              setState(() {
                                imagefile = file;
                                imageUploadURL = imageName;
                              });
                            }
                          }).getImage(context);
                        },
                        child: imagefile != null
                            ? Container(
                                width: 90.0,
                                height: 90.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.file(
                                    File(imagefile!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/image.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),

                      // ImageFormField<ImageInputAdapter>(
                      //   shouldAllowMultiple: false,
                      //   onSaved: (val) => _images = val,
                      //   // initialValue: this
                      //   //     .existingImages
                      //   //     .map((i) => ImageInputAdapter(url: i.originalUrl))
                      //   //     .toList()
                      //   //     .cast<ImageInputAdapter>(),
                      //   initializeFileAsImage: (file) => ImageInputAdapter(
                      //     file: UploadableImage(
                      //       file,
                      //       storagePath: "appImages",
                      //     ),
                      //   ),
                      //   buttonBuilder: (_, count) => PhotoUploadButton(
                      //       count: count, shouldAllowMultiple: false),
                      //   previewImageBuilder: (_, image) => image.widgetize(),
                      // ),

                      SizedBox(height: 10),

                      signupButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(tertiary),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
        onPressed: () {
          submit();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Otp()));
        },
      ),
    );
    // return Center(
    //     child: new Container(
    //   child: ButtonTheme(
    //       minWidth: 250.0,
    //       height: 40.0,
    //       child: new RaisedButton(
    //           elevation: 1.0,
    //           disabledColor: primary,
    //           disabledTextColor: statusBar,
    //           color: primary,
    //           child: Wrap(children: [
    //             Text(
    //               'SEND'.tr,
    //               style: TextStyle(fontSize: 16, color: textPrimaryLightColor),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    //               child: Icon(Icons.arrow_forward_rounded,
    //                   color: textPrimaryLightColor),
    //             )
    //           ]),
    //           shape: new RoundedRectangleBorder(
    //             side: BorderSide(color: textPrimaryLightColor, width: 2.0),
    //             borderRadius: new BorderRadius.circular(10.0),
    //           ),
    //           onPressed: () {

    //           })),
    // ));
  }

  void submit() {
    if (_fbKey.currentState!.validate() == true) {
      EasyLoading.show(status: 'Please wait...'.tr);

      _fbKey.currentState?.save();
      var data = {
        "name": name.text,
        "address": address.text,
        "mobile": mobile.text,
        "password": set_password.text,
        "gender": _currentGender,
        "woda": _currentWard,
        "user_img": imageUploadURL != null ? imageUploadURL : 'noImg.jpg',
      };
      if (email.text != "") {
        data["email"] = email.text;
      }
      try {
        signUp(data).then((value) => {
              userID = value['data']['id'],
              EasyLoading.dismiss(),
              if (value['status'] == true)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpOTP(
                                user_id: userID,
                                email: email.text,
                                password: re_password.text,
                                mobile: mobile.text,
                              ))),
                }
              else
                {
                  EasyLoading.dismiss(),
                  EasyLoading.showError('Please check all fields !! or try again later')
                }
            });
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError('Please check all fields !! or try again later');
      }
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

  static String get collectionPath => "blogImages";

  create() {}

// static Future<BlogImage> fromUrl(String url) async {}
}
