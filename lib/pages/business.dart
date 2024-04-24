import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/config/url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:get/get.dart';
import 'package:kmc/map.dart';
import 'package:kmc/modal/business.dart';

import '../config/replaceable.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  Future<List<Publicplacess>> tourism() async {
    var data = {"data_type": "पसल /ब्यापार  ब्यबसाय"};
    List<Publicplacess> public = await villagedatasearchApi(data, subIndex);
    return public;
  }

  int indexvalue = 0;
  dynamic value;
  dynamic subIndex = 1;

  @override
  void initState() {
    super.initState();
    this.indexvalue = 0;
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
                Text('business'.tr,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: Get.height * 0.12,
                    child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        childAspectRatio: 1.02,
                        crossAxisCount: 1,
                        children: List.generate(Config.woda_count, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: wardCard(index + 1),
                          );
                        })),
                  ),
                  titleText(
                      'Wardno'.tr + ' ' + '$subIndex'.tr + ' ' + 'business'.tr),
                  publicPlaceswidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: primary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.5)),
    );
  }

  wardCard(index) {
    return InkWell(
        onTap: () {
          setState(() {
            this.subIndex = index;
            indexvalue = index - 1;
          });
        },
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: subIndex == index ? primary : shadowColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Wardno'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: subIndex == index ? primary : text)),
                  Text('$index'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: subIndex == index ? primary : text)),
                ],
              ),
            )));
  }

  publicPlaceswidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: FutureBuilder(
          future: tourism(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else if (snapshot.data.isEmpty) {
              return Container(
                child: Center(
                    heightFactor: 5,
                    child: Column(
                      children: [
                        Icon(
                          Icons.no_sim_outlined,
                          size: 80,
                          color: primary,
                        ),
                        Text("no_data_found".tr,
                            style: TextStyle(
                                height: 1.3,
                                color: textPrimaryColor,
                                fontSize: 16))
                      ],
                    )),
              );
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    height: Get.height * .9,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 0,
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.all(16),
                                child: Row(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '$BASE_URL${snapshot.data[index].sp_pp_img1}',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                                child: Image.asset(
                                              'assets/images/Grey_Placeholder.png',
                                              fit: BoxFit.fill,
                                            )),
                                        placeholder: (context, url) =>
                                            Container(
                                              width: 19,
                                              height: 19,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200.0,
                                          child: Text(
                                              '${snapshot.data[index].sp_pp_name}'
                                                  .tr,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  height: 1.3,
                                                  color: textPrimaryColor,
                                                  fontSize: 16)),
                                        ),
                                        SizedBox(
                                          width: 200.0,
                                          child: Text(
                                              'palika-name'.tr +
                                                  ', ' +
                                                  'ward'.tr +
                                                  ' ' +
                                                  '${snapshot.data[index].sp_pp_ward}',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  height: 1.3,
                                                  color: textPrimaryColor,
                                                  fontSize: 16)),
                                        ),
                                        Row(children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 1),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: white,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(Mappage(
                                                      data: snapshot
                                                          .data[index]));
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/images/icons/newIcons/location.svg',
                                                  height: 25,
                                                  width: 25,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: white,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                popUp(context,
                                                    snapshot.data[index]);
                                              },
                                              child: SvgPicture.asset(
                                                'assets/images/icons/newIcons/eye.svg',
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ])
                                      ],
                                    ),
                                  ),
                                ])),
                          );
                        }),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  popUp(context, data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context, data));
        });
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
                          imageUrl: BASE_URL + data.sp_pp_img1,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/Grey_Placeholder.png',
                                fit: BoxFit.fill,
                              )),
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
                            Text('${data.sp_pp_name}',
                                style: TextStyle(
                                  height: 1.3,
                                  color: primary,
                                  fontSize: 16,
                                )),
                            SizedBox(
                              width: 200.0,
                              child: Text(
                                  'palika-name'.tr +
                                      ', ' +
                                      'ward'.tr +
                                      ' ' +
                                      '${data.sp_pp_ward}',
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: TextStyle(
                                      height: 1.3,
                                      color: textPrimaryColor,
                                      fontSize: 16)),
                            ),
                            // Row(children: [
                            //   Container(
                            //       padding: const EdgeInsets.symmetric(
                            //           vertical: 4.0, horizontal: 1),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         color: white,
                            //       ),
                            //       child: SvgPicture.asset(
                            //         'assets/images/icons/newIcons/location.svg',
                            //         height: 25,
                            //         width: 25,
                            //         fit: BoxFit.cover,
                            //       )),
                            //   SizedBox(width: 10),
                            //   Container(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 4.0, horizontal: 1),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       color: white,
                            //     ),
                            //     child: SvgPicture.asset(
                            //       'assets/images/icons/newIcons/eye.svg',
                            //       height: 25,
                            //       width: 25,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            //   SizedBox(width: 10),
                            //   Container(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 4.0, horizontal: 1),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       color: white,
                            //     ),
                            //     child: SvgPicture.asset(
                            //       'assets/images/icons/newIcons/mail.svg',
                            //       height: 25,
                            //       width: 25,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   )
                            // ])
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
                  data.sp_pp_type,
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
      ],
    );
  }

  Widget buildMovieShimmer() => Container(
        height: Get.height,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                CustomWidget.rectangular(height: 25),
                SizedBox(
                  height: 24,
                ),
              ],
            );
          },
        ),
      );
}
