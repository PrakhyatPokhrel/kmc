// ignore_for_file: unnecessary_statements

import 'package:cached_network_image/cached_network_image.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'dart:io';

class DocuemntreuploadSifarish extends StatefulWidget {
  final reupload;
  DocuemntreuploadSifarish(this.reupload);
  @override
  _DocuemntreuploadSifarishState createState() =>
      _DocuemntreuploadSifarishState();
}

class _DocuemntreuploadSifarishState extends State<DocuemntreuploadSifarish> {
  int currentStep = 0;
  bool complete = false;
  var photolen = 0;
  dynamic checkindex;
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
  dynamic entry_id;
  dynamic datalength;
  dynamic rejection_msg;
  @override
  void initState() {
    super.initState();
    checkasperid();
    getLength();
    getRejection();
    // print(entry_id);
  }

  @override
  void dispose() {
    // Never called
    EasyLoading.dismiss();
    super.dispose();
  }

  checkasperid() {
    entry_id = widget.reupload['entry_id'];

    // if (widget.reupload['type'] == "etax-land") {
    //   setState(() {
    //     entry_id = widget.reupload['id'];
    //   });
    // }
    // if (widget.reupload['type'] == "etax-house") {
    //   setState(() {
    //     entry_id = widget.reupload['id'];
    //   });
    // }
    // if (widget.reupload['type'] == "etax") {
    //   setState(() {
    //     entry_id = widget.reupload['owner_id'];
    //   });
    // }
  }

  getRejection() {
    rejection_msg = widget.reupload['rejection_reason'];
  }

  getLength() {
    datalength = widget.reupload['review_field'].length;
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
                  child: Text("पुन: अपलोड",
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
          child: Container(
            height: photolen == 0 ? Get.height * 2.5 : Get.height * 3.5,
            child: Theme(
                data: ThemeData(
                    shadowColor: Colors.transparent,
                    colorScheme: ColorScheme.light(primary: tertiary)
                        .copyWith(secondary: tertiary)),
                child: imagefields()),
          ),
        ),
      ),
    );
  }

//Step 2 documents upload
  imagefields() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(
                width: 10.0,
              ),
              Text(
                rejection_msg,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: Get.height * 0.1 * datalength + (datalength * 303),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: datalength,
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
                              '${widget.reupload['review_field'][index]['label']}',
                              style: TextStyle(fontSize: 16, color: text),
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  chooseimage(
                                      index,
                                      widget.reupload['review_field'][index]
                                          ['field']);
                                },
                                child: Icon(Icons.camera_alt,
                                    color: primary, size: 27)),
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
                            : Container(
                                width: 500,
                                height: 300,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${widget.reupload['review_field'][index]['document']}',
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Icon(Icons.error)),
                                ),
                              ),
                        filepdf[index] != ''
                            ? Container(
                                width: 500,
                                height: 300,
                                child: Image.asset('assets/images/pdf.jpg',
                                    height: 80, width: 80, fit: BoxFit.contain),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
          ),
          submitButton
        ],
      ),
    );
  }

  get submitButton {
    return ElevatedButton.icon(
        onPressed: () {
          if (photolen < datalength) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                    'कृपया सबै माथिका सबै डॉक्यूमेंट हरु अपलोड गर्नुहोस ।   ')));
          } else {
            Get.off(BottomNavBar());
          }
          // validateSubmitOTP();
        },
        // onPressed: onStepContinue,
        icon: Icon(Icons.send),
        label: Text('SEND'.tr,
            style: TextStyle(color: textPrimaryLightColor, fontSize: 15)),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ))));
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
        EasyLoading.show(status: 'Please wait...'.tr);

        fileuploadSifarishDocument(image, entry_id, field).then((res) => {
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

        fileuploadSifarishDocument(image, entry_id, field).then((res) => {
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

  pdffilechooser(index, field) async {
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

      fileuploadSifarishDocument(file, entry_id, field).then((res) => {
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
              {EasyLoading.showError('netwok_error_please_try_again'.tr)}
          });
      // User canceled the picker
    }
  }
}
