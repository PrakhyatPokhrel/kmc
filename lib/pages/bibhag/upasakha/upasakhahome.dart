import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/pages/bibhag/overview/Overview.dart';
import 'package:kmc/pages/bibhag/html.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kmc/config/colors.dart';

import 'package:get/get.dart';

class Upasakhahome extends StatefulWidget {
  final data;
  Upasakhahome({this.data});
  @override
  _UpasakhahomeState createState() => _UpasakhahomeState(this.data);
}

class _UpasakhahomeState extends State<Upasakhahome> {
  final data;
  dynamic subIndex = 0;
  dynamic navdata;
  List subheading = [];
  var subheadinglist;
  var contentlist;
  var orglist;

  var overview;
  var organization;
  var upashaka;
  var services;
  var subheadinglistdata = [];

  _UpasakhahomeState(this.data);
  @override
  void initState() {
    super.initState();
    setState(() {
      navdata = data;
      overview = {'events': navdata['events'], 'notice': navdata['notice']};
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints:
                              new BoxConstraints(maxWidth: Get.width * 0.7),
                          child: Text('${navdata['name']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: primary, fontSize: 22)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // InkWell(
                            //     onTap: () {},
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(right: 16.0),
                            //       child: Icon(Icons.bar_chart_rounded,
                            //           color: tertiary, size: 28),
                            //     )),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,
                                    color: primary, size: 28)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // topCard(),
                  // scrollDiv(),
                  // Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     ),
                  //     elevation: 0,
                  //     color: Colors.white,
                  //     child:
                  Column(
                    children: [
                      // navdata['static_data'].length != 0
                      //     ? detailsDiv(context, navdata['static_data'])
                      //     : Container(),
                      // navdata['static_data'].length != 0
                      //     ? contentdiv(context, navdata['static_data'])
                      //     : Container(),
                      // navdata['static_data'].length != 0
                      //     ? orgDiv(context, navdata['static_data'])
//Others

                      OverView(data: overview)
                    ],
                    // )
                  ),
                  // SizedBox(height: 10),
                  // graphsection(),
                  // SizedBox(height: 10),
                  // piechart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  topCard() {
    return navdata['bibhag_head'] != null
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 0,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.fromLTRB(22, 4, 22, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${navdata['title']}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                height: 1.2,
                                color: primary,
                                fontSize: 16,
                                fontFamily: 'Mukta'),
                          ),
                          SizedBox(height: 7),
                          new ConstrainedBox(
                            constraints: new BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.05),
                            child: InkWell(
                              onTap: () {
                                popUp(context, navdata, 'more');
                                // Get.to(link);
                              },
                              child: Text(
                                '${navdata['banner_text']}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  // Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${navdata['bibhag_head']['user_img']}",
                                // imageUrl:
                                //     'https://kathmandumetro.smartpalika.io/images/user/20191108024004.png',
                                errorWidget: (context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(
                                        'assets/images/dummyuser.png',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.contain)),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 55,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  backgroundColor: primary,
                                ),
                              )),
                          Text(
                            "${navdata['bibhag_head']['name']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: text,
                              fontFamily: 'Mukta',
                              height: 1.5,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            '${navdata['bibhag_head']['designation']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: text,
                                fontFamily: 'Mukta',
                                fontSize: 12.0,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        : Container();
  }

  scrollDiv() {
    return navdata['static_data'] != null
        ? Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.width * 0.30,
                  child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: subheadinglistdata.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2),
                          child: Column(children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  this.subIndex = i;
                                  // subheading;
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        subIndex == i ? primary : Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CachedNetworkImage(
                                    imageUrl: subheadinglistdata[i]['icon'],
                                    placeholder: (context, url) => Container(
                                      width: 19,
                                      height: 19,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    height: MediaQuery.of(context).size.width *
                                        0.09,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(subheadinglistdata[i]['text'],
                                style: TextStyle(color: text))
                          ]),
                        );
                      }),
                ),
              ],
            ),
          )
        : Container();
  }

  detailsDiv(context, data) {
    return subheadinglist != null
        ? Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: Get.height * 0.165 * subheadinglist.length,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: subheadinglist.length,
                        itemBuilder: (context, i) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: listCard(context, subheadinglist[i]));
                        }),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  contentdiv(context, data) {
    return contentlist != null
        ? Container(
            child: Column(children: [
            SizedBox(height: 10),
            Container(
                height: Get.height * 0.31,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView(
                          children: [Html(data: contentlist['html'])])),
                ))
          ]))
        : Container();
  }

  // contentdiv(context, data) {
  //   return contentlist != null
  //       ? Container(
  //           child: Column(
  //             children: [
  //               SizedBox(height: 10),
  //               Container(
  //                 height: MediaQuery.of(context).size.width * 0.95,
  //                 child: Scrollbar(
  //                   isAlwaysShown: true,
  //                   controller: _scrollController,
  //                   child: ListView.builder(
  //                       scrollDirection: Axis.vertical,
  //                       itemCount: data.length,
  //                       itemBuilder: (context, i) {
  //                         return InkWell(
  //                           onTap: () {
  //                             Get.to(HTML(data: orglist[i]));
  //                           },
  //                           child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: contentCard(context, data[i])),
  //                         );
  //                       }),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }

  orgDiv(context, data) {
    return orglist != null
        ? Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: Get.height * 0.1 * orglist.length,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: orglist.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Get.to(HTML(data: orglist[i]));
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                      imageUrl: orglist[i]['thumb'],
                                      height: 55,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                            width: 19,
                                            height: 19,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )),
                                  title: new Text(orglist[i]['title']),
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: primary,
                                  ),
                                )),
                          );
                        }),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  // orgCard(context, i) {
  //   print(orglist[i]['title']);
  //   return data != null
  //       ? InkWell(
  //           onTap: () {
  //             popUp(context, data, 'bibhag');
  //           },
  //           child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //               child: Row(children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 6.0),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(20.0),
  //                     child: CachedNetworkImage(
  //                         imageUrl:
  //                             'https://kathmandumetro.smartpalika.io/images/event/drinking-water.jpg',
  //                         height: 105,
  //                         width: 100,
  //                         fit: BoxFit.cover,
  //                         placeholder: (context, url) => Container(
  //                               width: 19,
  //                               height: 19,
  //                               child: CircularProgressIndicator(
  //                                 valueColor: AlwaysStoppedAnimation<Color>(
  //                                     Colors.white),
  //                               ),
  //                             )),
  //                   ),
  //                 ),
  //                 Container(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(orglist[i]['title'],
  //                           // data['title'],
  //                           style: TextStyle(
  //                             height: 1.3,
  //                             color: primary,
  //                             fontSize: 16,
  //                           )),
  //                       SizedBox(
  //                         width: 200.0,
  //                         child: Text('heading',
  //                             // data['heading'],
  //                             overflow: TextOverflow.ellipsis,
  //                             softWrap: false,
  //                             style: TextStyle(
  //                                 height: 1.3,
  //                                 color: textPrimaryColor,
  //                                 fontSize: 16)),
  //                       ),
  //                       Row(children: [
  //                         Container(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 4.0, horizontal: 1),
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                               color: white,
  //                             ),
  //                             child: SvgPicture.asset(
  //                               'assets/images/icons/newIcons/location.svg',
  //                               height: 25,
  //                               width: 25,
  //                               fit: BoxFit.cover,
  //                             )),
  //                         SizedBox(width: 10),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 4.0, horizontal: 1),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             color: white,
  //                           ),
  //                           child: SvgPicture.asset(
  //                             'assets/images/icons/newIcons/eye.svg',
  //                             height: 25,
  //                             width: 25,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         )
  //                       ])
  //                     ],
  //                   ),
  //                 ),
  //               ])),
  //         )
  //       : Container();
  // }

  contentCard(context, data) {
    return contentlist != null
        ? InkWell(
            onTap: () {
              // popUp(context, data, 'bibhag');
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://kathmandumetro.smartpalika.io/images/event/drinking-water.jpg',
                          height: 105,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['title'],
                            // data['title'],
                            style: TextStyle(
                              height: 1.3,
                              color: primary,
                              fontSize: 16,
                            )),
                        SizedBox(
                          width: 200.0,
                          child: Text(data['heading'],
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  height: 1.3,
                                  color: textPrimaryColor,
                                  fontSize: 16)),
                        ),
                        Row(children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: white,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/icons/newIcons/location.svg',
                                height: 25,
                                width: 25,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: white,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/icons/newIcons/eye.svg',
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ])),
          )
        : Container();
  }

  listCard(context, data) {
    return data != null
        ? InkWell(
            onTap: () {
              Get.to(HTML(data: data));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://kathmandumetro.smartpalika.io/images/event/drinking-water.jpg',
                          height: 105,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['title'],
                            style: TextStyle(
                              height: 1.3,
                              color: primary,
                              fontSize: 16,
                            )),
                        SizedBox(
                          width: 200.0,
                          child: Text(data['heading'],
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  height: 1.3,
                                  color: textPrimaryColor,
                                  fontSize: 16)),
                        ),
                        Row(children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: white,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/icons/newIcons/location.svg',
                                height: 25,
                                width: 25,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: white,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/icons/newIcons/eye.svg',
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ])),
          )
        : Container();
  }

  popUp(context, data, name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: name == 'bibhag'
                ? contentBox(context, data)
                : readMoreBox(context, data),
          );
        });
  }

  readMoreBox(context, data) {
    return navdata['bibhag_head'] != null
        ? Stack(children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 130),
                child: Container(
                  // padding: EdgeInsets.only(right: 25, left: 25, bottom: 25),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${navdata['bibhag_head']['user_img']}",
                                  // imageUrl:
                                  //     'https://kathmandumetro.smartpalika.io/images/user/20191108024004.png',
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                              'assets/images/dummyuser.png',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.contain)),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 55,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    backgroundColor: primary,
                                  ),
                                )),
                            Text(
                              "${navdata['bibhag_head']['name']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: text,
                                fontFamily: 'Mukta',
                                height: 1.5,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              '${navdata['bibhag_head']['designation']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: primary,
                                  fontFamily: 'Mukta',
                                  fontSize: 16.0,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ConstrainedBox(
                              constraints: new BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.2),
                              child: Html(
                                // defaultTextStyle: TextStyle(
                                //   height: 1.5,
                                //   fontSize: 16.0,
                                //   color: text,
                                // ),
                                data: navdata['banner_text'],
                              ),
                              // Text(
                              //   '${navdata['full_description']}',
                              //   style: TextStyle(
                              //     height: 1.5,
                              //     fontSize: 16.0,
                              //     color: text,
                              //   ),
                              // ),
                            ),
                          ]),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 105),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        Image.asset('assets/images/icons/newIcons/cross.png')),
              ),
            )
          ])
        : Container();
  }

  contentBox(context, data) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 120),
          child: Container(
            // padding: EdgeInsets.only(right: 25, left: 25, bottom: 25),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://kathmandumetro.smartpalika.io/images/event/drinking-water.jpg',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data.title}',
                                style: TextStyle(
                                  height: 1.3,
                                  color: primary,
                                  fontSize: 16,
                                )),
                            SizedBox(
                              width: 200.0,
                              child: Text('palika-name'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: TextStyle(
                                      height: 1.3,
                                      color: textPrimaryColor,
                                      fontSize: 16)),
                            ),
                            Row(children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: white,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/icons/newIcons/location.svg',
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: white,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/icons/newIcons/eye.svg',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: white,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/icons/newIcons/mail.svg',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'कन गर्न मानकीकृत पाठहरूको आवश्यकता छ, दोहोरिने मापनका लागि बहु समतुल्य पाठहरूको लागि, र बहु-भाषा अध्ययनहरूका लागि भाषाहरूमा बराबर पाठहरू। अनुच्छेदहरू सही गति मापनका लागि एकल वाक्यहरूमा प्राथमिक छन्। हामीले पहिले texts भाषाहरूमा त्यस्ता पाठहरू विकास गरेका छौं। कन गर्न मानकीकृत पाठहरूको आवश्यकता छ, दोहोरिने मापनका लागि बहु समतुल्य पाठहरूको लागि, र बहु-भाषा अध्ययनहरूका।',
                  style: TextStyle(
                    fontSize: 14,
                    color: textPrimaryColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 105),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/images/icons/newIcons/cross.png')),
          ),
        ),
        // Positioned(
        //   left: 20,
        //   right: 20,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: 45,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(45)),
        //         child: Image.asset("assets/image.png")),
        //   ),
        // ),
      ],
    );
  }

  graphsection() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(22),
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                series: <ChartSeries>[
                  // Renders spline chart
                  SplineSeries<SalesData, String>(
                    dataSource: [
                      SalesData('2010', 35),
                      SalesData('2011', 28),
                      SalesData('2012', 34),
                      SalesData('2013', 32),
                      SalesData('2014', 40)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                  ),
                  SplineSeries<SalesData, String>(
                    dataSource: [
                      SalesData('2010', 23),
                      SalesData('2011', 50),
                      SalesData('2012', 34),
                      SalesData('2013', 32),
                      SalesData('2014', 60)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                  ),
                  SplineSeries<SalesData, String>(
                    dataSource: [
                      SalesData('2010', 2),
                      SalesData('2011', 50),
                      SalesData('2012', 34),
                      SalesData('2013', 40),
                      SalesData('2014', 90)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                  )
                ])));
  }

  piechart() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(isVisible: true, position: LegendPosition.right),
                series: <CircularSeries>[
              DoughnutSeries<SalesData, String>(
                  dataSource: [
                    SalesData('2010', 2),
                    SalesData('2011', 50),
                    SalesData('2012', 34),
                    SalesData('2013', 40),
                    SalesData('2014', 90)
                  ],
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(color: Colors.white)),
                  xValueMapper: (SalesData data, _) => data.year,
                  yValueMapper: (SalesData data, _) => data.sales,
                  // Explode the segments on tap

                  explode: true,
                  explodeIndex: 1)
            ])));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  String year;
  double sales;
}
