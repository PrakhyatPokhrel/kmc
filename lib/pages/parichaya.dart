import 'package:kmc/components/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:get/get.dart';
import 'package:kmc/modal/palikaintro.dart';

class Parichaya extends StatefulWidget {
  @override
  _ParichayaState createState() => _ParichayaState();
}

Future<List<PalikaIntroData>> palikaintroApis() async {
  List<PalikaIntroData> introlist = await palikaintroApi();

  return introlist;
}

@override
void initState() {
  palikaintroApi();
}

class _ParichayaState extends State<Parichaya> {
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
                Text('GAUPALIKA_INFO'.tr,
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
            decoration: new BoxDecoration(
              color: Colors.grey.shade200,
              // borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset(
                          'assets/images/parichaya.jpg',
                          width: Get.width,
                          height: Get.height * 0.18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: palikaintroApis(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ShimmerWidget().buildMovieShimmer();
                          } else if (snapshot.hasError) {
                            return Container();
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Container(
                                      color: primary,
                                      child: ExpansionTile(
                                        initiallyExpanded:
                                            index == 0 ? true : false,
                                        trailing: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: textPrimaryLightColor,
                                        ),
                                        title: Text(
                                          "${snapshot.data[index].title}",
                                          // a.substring(1, a.length - 1),
                                          style: TextStyle(
                                              color: textPrimaryLightColor,
                                              fontSize: 16.0,
                                              height: 1.2,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey[100],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 2, 16, 2),
                                                child: Html(
                                                  data:
                                                      '<p>${snapshot.data[index]?.data}</p>',
                                                  //     color: text,
                                                  //     height: 1.5,
                                                  //     fontSize: 16)
                                                  style: {
                                                    "p": Style(
                                                      fontSize: FontSize.large,
                                                    ),
                                                  },
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );

                                  // Card(
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(30.0),
                                  //   ),
                                  //   elevation: 1,
                                  //   color: Colors.white,
                                  //   child: Container(
                                  //     child: snapshot.data[index].data != null
                                  //         ? Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.fromLTRB(
                                  //                         16, 20, 10, 0),
                                  //                 child: Text(
                                  //                     snapshot
                                  //                         .data[index].title,
                                  //                     textAlign: TextAlign.left,
                                  //                     style: TextStyle(
                                  //                         color: primary,
                                  //                         fontSize: 18)),

                                  //                 // Container(
                                  //                 // decoration:
                                  //                 //     new BoxDecoration(
                                  //                 //   color: white,
                                  //                 //   borderRadius:
                                  //                 //       BorderRadius.circular(
                                  //                 //           30),
                                  //                 // ),
                                  //                 // width: double.infinity,
                                  //                 // height: 35,
                                  //                 // child: Padding(
                                  //                 //   padding:
                                  //                 //       const EdgeInsets.all(
                                  //                 //           8.0),
                                  //                 //   child:
                                  //                 // )),
                                  //               ),
                                  //               Padding(
                                  //                 padding: const EdgeInsets.all(
                                  //                     16.0),
                                  //                 child: Html(
                                  //                     data:
                                  //                         '${snapshot.data[index]?.data}',
                                  //                     defaultTextStyle:
                                  //                         TextStyle(
                                  //                             color: text,
                                  //                             height: 1.5,
                                  //                             fontSize: 16)),
                                  //               ),
                                  //             ],
                                  //           )
                                  //         : Container(),
                                  //   ),
                                  // );
                                });
                          }
                        }),
                    dharmikplace != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("धार्मिक स्थल / पर्यटकीय स्थल",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: primary, fontSize: 18)),
                          )
                        : Container(),
                    Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: dharmikplace.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  color: primary,
                                  child: ExpansionTile(
                                    initiallyExpanded: false,
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: textPrimaryLightColor,
                                    ),
                                    title: Text(
                                      "${dharmikplace[index]['key']}",
                                      // a.substring(1, a.length - 1),
                                      style: TextStyle(
                                          color: textPrimaryLightColor,
                                          fontSize: 17.0,
                                          height: 1.2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    children: <Widget>[
                                      Container(
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey[100],
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: Get.height *
                                                    0.033 *
                                                    dharmikplace[index]['value']
                                                        .length,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        dharmikplace[index]
                                                                ['value']
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return RichText(
                                                        text: TextSpan(
                                                          text: '• ',
                                                          style: TextStyle(
                                                              color: text,
                                                              height: 1.5,
                                                              fontSize: 16),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text:
                                                                    '${dharmikplace[index]['value'][i]}',
                                                                style: TextStyle(
                                                                    color: text,
                                                                    height: 1.5,
                                                                    fontSize:
                                                                        16)),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              )))
                                    ],
                                  ),
                                ),
                              );
                              //  Card(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //   ),
                              //   elevation: 1,
                              //   color: Colors.white,
                              //   child: Container(
                              //     child: dharmikplace != null
                              //         ? Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.fromLTRB(
                              //                     16, 20, 10, 0),
                              //                 child: Text(
                              //                     "${dharmikplace[index]['key']}",
                              //                     textAlign: TextAlign.left,
                              //                     style: TextStyle(
                              //                         color: primary,
                              //                         fontSize: 18)),
                              //               ),
                              //               Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(8.0),
                              //                   child: Container(
                              //                     height: Get.height *
                              //                         0.033 *
                              //                         dharmikplace[index]['value']
                              //                             .length,
                              //                     child: ListView.builder(
                              //                         physics:
                              //                             NeverScrollableScrollPhysics(),
                              //                         itemCount:
                              //                             dharmikplace[index]
                              //                                     ['value']
                              //                                 .length,
                              //                         itemBuilder: (context, i) {
                              //                           return RichText(
                              //                             text: TextSpan(
                              //                               text: '• ',
                              //                               style: TextStyle(
                              //                                   color: text,
                              //                                   height: 1.5,
                              //                                   fontSize: 16),
                              //                               children: <TextSpan>[
                              //                                 TextSpan(
                              //                                     text:
                              //                                         '${dharmikplace[index]['value'][i]}',
                              //                                     style: TextStyle(
                              //                                         color: text,
                              //                                         height: 1.5,
                              //                                         fontSize:
                              //                                             16)),
                              //                               ],
                              //                             ),
                              //                           );
                              //                         }),
                              //                   ))
                              //             ],
                              //           )
                              //         : Container(),
                              //   ),
                            }))
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
