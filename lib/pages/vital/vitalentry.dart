// import 'package:flutter/material.dart';
// import 'package:kmc/config/colors.dart';
// import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:get/get.dart';
// import 'package:kmc/pages/vital/birth.dart';
// import 'package:kmc/pages/vital/death.dart';
// import 'package:kmc/pages/vital/divorce.dart';
// import 'package:kmc/pages/vital/migration.dart';

// class VitalEntry extends StatefulWidget {
//   @override
//   _VitalEntryState createState() => _VitalEntryState();
// }

// class VitalList {
//   final String title;
//   final String content;
//   final link;

//   VitalList(this.title, this.content, this.link);
// }

// final List<VitalList> vitalList = [
//   VitalList('BIRTH', 'जन्म दर्ताको लागि', Birth()),
//   VitalList('DEATH', 'मृत्यु दर्ताको लागि', Death()),
//   VitalList('MIGRATION', 'बसाईसराई दर्ताको लागि', Migration()),
//   VitalList('MARRIAGE', 'विवाह दर्ताको लागि', Birth()),
//   VitalList("DIVORCE", 'सम्बन्धविच्छेद दर्ताको लागि', Divorce()),
// ];

// List howToEntry = [
//   'आफूले लिन चाहेको सबै जानकारीहरू नबिराई लेख्नुहोस्। ',
//   'ई- फाराममा दिइएका सबै जानकारीहरू नबिराई लेख्नुहोस्। समस्या भएका अन्य कोही जान्ने व्यक्तीको सहयोग लिन सक्नुहुनेछ। ',
//   'सबै जानकारी भरिसकेपछि तलको बटन दबाएर पठाउन सक्नुहुनेछ। ',
//   'तपाईंंको जानकारी प्राप्त भएपछि हाम्रा प्रतिनिधीले सम्पूर्ण विवरण जाँच गरी यहाँलाई सम्पर्क गर्नुहुनेछ।',
// ];

// class _VitalEntryState extends State<VitalEntry> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: background,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: primary,
//           title: Text('ghatana-darta'.tr, style: TextStyle(fontSize: 22)),
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.info,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   modalBottom(context);
//                 },
//               ),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(children: <Widget>[
//               Stack(children: <Widget>[
//                 Container(
//                   height: 95,
//                   decoration: BoxDecoration(
//                       color: primary,
//                       shape: BoxShape.rectangle,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(30),
//                           bottomRight: Radius.circular(30))),
//                 ),
//                 SizedBox(
//                   height: 70,
//                 ),
//                 Container(
//                   height: Get.height,
//                   child: Container(
//                     child: ListView.builder(
//                         padding: const EdgeInsets.all(8),
//                         itemCount: vitalList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             onTap: () {
//                               // not_available_Alert(context);
//                               // Get.to(vitalList[index].link);
//                             },
//                             child: Container(
//                               alignment: Alignment.topLeft,
//                               width: double.infinity,
//                               margin: new EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 10),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(30))),
//                               child: Expanded(
//                                 flex: 6,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text('${vitalList[index].title}'.tr,
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: primary,
//                                           )),
//                                       SizedBox(height: 10),
//                                       Text(vitalList[index].content,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: text,
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 )
//               ]),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// modalBottom(context) {
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Text('कसरी प्रयोग गर्ने?',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: primary,
//                   )),
//             ),
//             Container(
//                 height: 350,
//                 child: Container(
//                   child: ListView.builder(
//                       padding: const EdgeInsets.all(8),
//                       itemCount: howToEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListTile(
//                           title: new Text((index + 1).toString() +
//                               '.  ' +
//                               howToEntry[index]),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         );
//                       }),
//                 ))
//           ],
//         );
//       });
// }

// not_available_Alert(context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           title: Text('प्रक्रियामा छ !',
//               textAlign: TextAlign.center, style: TextStyle(color: primary)),
//           content: Text('यो सेवा प्रक्रियामा छ !',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, height: 1.5)),
//           actions: [
//             Center(
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(tertiary),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ))),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 10),
//                   child: Text('cancel'.tr),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//               ),
//             ),
//           ],
//         );
//       });
// }
