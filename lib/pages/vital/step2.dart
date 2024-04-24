// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:kmc/config/colors.dart';
// import 'package:kmc/pages/vital/vitalphotostaticdata.dart';

// class Step2 extends StatefulWidget {
//   int entry_id;
//   String form_name;
//   Function imageCountIncrementor;
//   Step2({this.entry_id, this.form_name, this.imageCountIncrementor});
//   @override
//   _Step2State createState() => _Step2State();
// }

// class _Step2State extends State<Step2> {
//   List array = [];
//   int photolen;
//   int entry_id;
//   String form_name;

//   @override
//   void initState() {
//     super.initState();
//     entry_id = widget.entry_id;
//     form_name = widget.form_name;
//     photolen = 0;

//     VITAL_PHOTO_LIST[0]['fields'].forEach((key, value) {
//       var requiredfiledlist;
//       print(key);
//      
//       if (value != null) {
//         requiredfiledlist = {'key': "${key}", 'value': "${value}"};
//         array.add(requiredfiledlist);
//       }
//     });
//   }

//   chooseimage(index, BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return new Container(
//             color: Colors.transparent,
//             //could change this to Color(0xFF737373),
//             //so you don't have to change MaterialApp canvasColor
//             child: new Container(
//               decoration: new BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: new BorderRadius.only(
//                       topLeft: const Radius.circular(10.0),
//                       topRight: const Radius.circular(10.0))),
//               child: new Wrap(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       getImageFromGallery(index);
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.image, color: primary),
//                       title: Text('load_gallery'.tr),
//                     ),
//                   ),
//                   new GestureDetector(
//                     onTap: () {
//                       getImageFromCamera(index);
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.camera, color: primary),
//                       title: Text('open_camera'.tr),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: new ListTile(
//                       leading: new Icon(Icons.cancel_outlined, color: primary),
//                       title: Text('cancel'.tr),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Future getImageFromGallery(index) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     // final bytes = Io.File(image.path).readAsBytesSync();

//     // String img64 = base64Encode(bytes);
//     // print(img64);

//     setState(() {
//       if (image != null) {
//         var a = {
//           index: image,
//         };
//         fileuploadvitalko(image, entry_id, index + 1).then((res) => {
//               print('res$res'),
//               if (res == 200)
//                 {
//                   imageupload.insert(index, image),
//                   // imgfilecount++,
//                   widget.imageCountIncrementor,
//                   setState(() {
//                     photolen++;
//                   }),
//                 }
//               else
//                 {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//             });
//       }
//     });
//   }

//   List<dynamic> imageupload = [
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     ''
//   ];

//   Future getImageFromCamera(index) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (image != null) {
//         var a = {
//           index: image,
//         };
//         setState(() {
//           imageupload.insert(index, image);
//         });
//         fileuploadvitalko(image, entry_id, index + 1).then((res) => {
//               print('res$res'),
//               if (res == 200)
//                 {
//                   imageupload.insert(index, image),
//                   // imgfilecount++,
//                   widget.imageCountIncrementor,
//                   setState(() {
//                     photolen++;
//                   }),
//                 }
//               else
//                 {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//             });
//       }
//     });
//   }

//   List<dynamic> filepdf = [
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     '',
//     ''
//   ];

//   pdffilechooser(index) async {
//     FilePickerResult result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path);
//       
//       setState(() {
//         filepdf.insert(index, 'फाइल अपलोड भयो।  ');
//       });

//       fileuploadvitalko(file, entry_id, index + 1).then((res) => {
//             print('res$res'),
//             if (res == 200)
//               {
//                 filepdf.insert(index, 'फाइल अपलोड भयो।  '),
//                 // imgfilecount++,
//                 widget.imageCountIncrementor,
//                 setState(() {
//                   photolen++;
//                 }),
//               }
//             else
//               {EasyLoading.showError('netwok_error_please_try_again'.tr)}
//           });
//       // User canceled the picker
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         // shrinkWrap: true,
//         children: <Widget>[
//           // mainAxisAlignment: MainAxisAlignment.start,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           Container(
//             height: photolen == 0
//                 ? Get.height * 0.09 * array.length
//                 : Get.height * 0.1 * array.length + (photolen * 303),
//             child: ListView.builder(
//                 itemCount: array.length,
//                 itemBuilder: (BuildContext ctxt, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                               '${array[index]['value']}',
//                               style: TextStyle(fontSize: 16, color: text),
//                             ),
//                             trailing: Container(
//                               width: 70,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         chooseimage(index, context);
//                                       },
//                                       child: Icon(Icons.camera_alt,
//                                           color: primary, size: 27)),
//                                   GestureDetector(
//                                       onTap: () {
//                                         pdffilechooser(index);
//                                       },
//                                       child: Icon(Icons.attach_file,
//                                           color: primary, size: 27))
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         imageupload[index] != ''
//                             ? Container(
//                                 width: 500,
//                                 height: 300,
//                                 child: Image.file(
//                                   imageupload[index],
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : Container(),
//                         filepdf[index] != ''
//                             ? Container(height: 20, child: Text(filepdf[index]))
//                             : Container(),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//           // titleText('form_sample'.tr),
//           // Container(
//           //     height: Get.height * 0.09 * dhacha.length,
//           //     child: ListView.builder(
//           //         itemCount: dhacha.length,
//           //         itemBuilder: (BuildContext ctxt, int index) {
//           //           return ListTile(
//           //             title: Text(
//           //               '${dhacha[index].dhacha_name}',
//           //               style: TextStyle(fontSize: 16, color: text),
//           //             ),
//           //             leading:
//           //                 Icon(Icons.file_present, color: primary, size: 27),
//           //           );
//           //         })),
//         ],
//       ),
//     );
//   }
// }
