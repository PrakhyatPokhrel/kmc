import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';

import '../constants/constants.dart';

class GetGhardhuri extends StatefulWidget {
  @override
  _GetGhardhuriState createState() => _GetGhardhuriState();
}

class _GetGhardhuriState extends State<GetGhardhuri> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  var _currentGender;
  var _currentWard;
  bool checkboxValue = false;
  // List<ImageInputAdapter> _images;
  _GetGhardhuriState({this.existingImages});
  dynamic imageupload1;
  dynamic imageupload2;
  final List<BlogImage>? existingImages;
  var name = TextEditingController();
  var address = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var citizenship_number = TextEditingController();
  var muli_mobile = TextEditingController();
  var muli_name = TextEditingController();

  @override
  void initState() {}
  void deactivate() {
    EasyLoading.dismiss();
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

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
                Text('household-details'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
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
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'NAME'.tr,
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: Icon(Icons.map, color: primary),
                        title: new TextFormField(
                          controller: address,
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'address'.tr,
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: Icon(Icons.phone, color: primary),
                        title: new TextFormField(
                          controller: mobile,
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'MOBILE-NUM'.tr,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 44.0),
                            margin: EdgeInsets.only(
                                top: 5.0, left: 28.0, right: 16.0),
                            child: DropdownButton(
                              hint: Text('GENDER'.tr),
                              isExpanded: true,
                              items: Constants.gender.map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val["value"],
                                    child: Text(val["name"]!),
                                  );
                                },
                              ).toList(),
                              value: _currentGender != null
                                  ? _currentGender
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _currentGender = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: Icon(
                              Icons.attribution_outlined,
                              color: primary,
                            ),
                          ),
                        ],
                      ),

                      new ListTile(
                        leading: Icon(
                          Icons.email,
                          color: primary,
                        ),
                        title: new TextFormField(
                          validator: FormBuilderValidators.email(context),
                          controller: email,
                          decoration: new InputDecoration(
                            hintText: 'EMAIL'.tr,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      new ListTile(
                        leading: Icon(Icons.document_scanner, color: primary),
                        title: new TextFormField(
                          controller: citizenship_number,
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'CITIZENSHIP'.tr,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),

                      const Divider(
                        height: 1.0,
                      ),
                      new ListTile(
                        leading: Icon(Icons.home, color: primary),
                        title: new TextFormField(
                          controller: muli_name,
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'house_owner'.tr,
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: Icon(Icons.phone, color: primary),
                        title: new TextFormField(
                          controller: muli_mobile,
                          validator: FormBuilderValidators.required(context,
                              errorText: 'required_field'.tr),
                          decoration: new InputDecoration(
                            hintText: 'house_owner_number'.tr,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),

                      //Checkbox

                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 44.0),
                            margin: EdgeInsets.only(
                                top: 5.0, left: 28.0, right: 16.0),
                            child: DropdownButton(
                              hint: Text('Wardno'.tr),
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
                            margin: EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: Icon(
                              Icons.location_city,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('CITIZENSHIP_photo_front'.tr,
                                      style:
                                          TextStyle(color: text, fontSize: 16)),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      chooseimage(1);
                                    },
                                    child: imageupload1 == null
                                        ? Container(
                                            width: 120.0,
                                            height: 120.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    'assets/image.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        : Container(
                                            width: 120.0,
                                            height: 120.0,
                                            child: Image.file(
                                              File(imageupload1),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('CITIZENSHIP_photo_back'.tr,
                                      style:
                                          TextStyle(color: text, fontSize: 16)),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      chooseimage(2);
                                    },
                                    child: imageupload2 == null
                                        ? Container(
                                            width: 120.0,
                                            height: 120.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    'assets/image.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        : Container(
                                            width: 120.0,
                                            height: 120.0,
                                            child: Image.file(
                                              File(imageupload2),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                              ],
                            ),
                          ],
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

                      ghardhuriButton()
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

  ghardhuriButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(tertiary),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        child: Text('SEND'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
        onPressed: () {
          submit(); // Get.back();
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
      "gender": _currentGender,
      "citizenship_number": citizenship_number.text,
      "muli_mobile": muli_mobile.text,
      "muli_name": muli_name.text,
      "woda": _currentWard,
      "nagarikta_front": nagarikata[0] != null
          ? nagarikata[0]['nagarikta_front']
          : 'noImg.jpg',
      "nagarikta_back":
          nagarikata[1] != null ? nagarikata[1]['nagarikta_back'] : 'noImg.jpg',
    };

    if (_fbKey.currentState?.validate() == true) {
      householdVerify(data).then((value) => {
            EasyLoading.dismiss(),
            if (value['status'] == true)
              {EasyLoading.showSuccess(value['message']), Get.back()}
            else
              {EasyLoading.showError(value['message'])}
          });
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Please check all fields !!'.tr);
    }
  }

  chooseimage(data) {
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
                      getImageFromGallery(data);
                      Navigator.pop(context);
                    },
                    child: new ListTile(
                      leading: new Icon(Icons.image, color: primary),
                      title: Text('load_gallery'.tr),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      getImageFromCamera(data);
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

  Future getImageFromGallery(val) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        if (val == 1) {
          imageupload1 = image.path;
          citizenshipupload(image, 'nagarikta_front');
        } else {
          imageupload2 = image.path;
          citizenshipupload(image, 'nagarikta_back');
        }
      }
    });
  }

  Future getImageFromCamera(val) async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        if (val == 1) {
          imageupload1 = image.path;
          citizenshipupload(image, 'nagarikta_front');
        } else {
          imageupload2 = image.path;
          citizenshipupload(image, 'nagarikta_back');
        }
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

  static String get collectionPath => "blogImages";

  create() {}

  // static Future<BlogImage> fromUrl(String url) async {}
}
