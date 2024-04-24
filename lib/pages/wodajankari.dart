import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/wodajanakari.dart';
import 'package:kmc/pages/yojana/woda_janakari_cubit/cubit/woda_jankari_cubit.dart';

import '../config/replaceable.dart';

class Wodajankari extends StatefulWidget {
  @override
  _WodajankariState createState() => _WodajankariState();
}

class _WodajankariState extends State<Wodajankari> {
  Future<List<WodaJanakaridata>> getpratinidhidata() async {
    List<WodaJanakaridata> wodajankari = await wodaJanakariApi();
    return wodajankari;
  }

  int count = 1;
  @override
  void initState() {
    super.initState();

    wodaJanakariApi().then((value) => {
          setState(() {
            this.value = value;
            this.indexvalue = 0;
          })
        });
  }

  int indexvalue = 0;
  dynamic value;

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  dynamic subIndex = 1;
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
                Text('ward-info'.tr,
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
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<WodaJankariCubit>(context).fetch();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
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
                    value != null
                        ? titleText('Wardno'.tr +
                            ' ' +
                            '$subIndex'.tr +
                            ', ' +
                            'palika-name'.tr +
                            ' ' +
                            'palika-name-sub'.tr)
                        : titleText('Wardno'.tr +
                            ' ' +
                            '$subIndex'.tr +
                            ', ' +
                            'palika-name'.tr +
                            ' ' +
                            'palika-name-sub'.tr),
                    upperPart(),
                    mapSection(subIndex),
                    employeeSection(subIndex),
                    employeeSection1(subIndex),
                    employeeSection2(subIndex),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
                          fontSize: 18,
                          color: subIndex == index ? primary : text)),
                  Text(('$index'.tr),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: subIndex == index ? primary : text)),
                ],
              ),
            )));
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

  upperPart() {
    return Container(
      // color: Colors.white,
      // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Wardno'.tr + ' ' + '$subIndex'.tr + ' ' + 'digitalprofile'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primary,
                  fontFamily: 'Mukta',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: Get.height * 0.11,
                alignment: Alignment.center,
                child: dataText('डिजिटल प्रोफाइल सेवा प्रकृया मा छ ।'),

                //!UNCOMMENT TO GET DIGITAL PROFILE OR NUMBERS
                // FutureBuilder(
                //     future: getpratinidhidata(),
                //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return ShimmerWidget().buildMovieShimmer();
                //       } else if (snapshot.hasError) {
                //         return Container();
                //       } else {
                //         return Padding(
                //             padding: const EdgeInsets.all(8),
                //             child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: <Widget>[
                //                   Expanded(
                //                       flex: 6,
                //                       child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.start,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           dataText('literacy'.tr +
                //                               ' : ' +
                //                               '${snapshot.data[indexvalue].stats.literacy}'),
                //                           dataText('total_house'.tr +
                //                               ' : ' +
                //                               '${snapshot.data[indexvalue].stats.total_house}'),
                //                           dataText('total_family'.tr +
                //                               ' : ' +
                //                               '${snapshot.data[indexvalue].stats.family_total}'),
                //                         ],
                //                       )),
                //                   Expanded(
                //                       flex: 6,
                //                       child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.start,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           dataText('total_household'.tr +
                //                               ' : ' +
                //                               '${snapshot.data[indexvalue].stats.household_total}'),
                //                           dataText('total_population'.tr +
                //                               ' : ' +
                //                               '${snapshot.data[indexvalue].stats.total_population}'),
                //                           snapshot.data[indexvalue].stats
                //                                       .no_lalpurja !=
                //                                   null
                //                               ? dataText('no_lalpurja'.tr +
                //                                   ' : ' +
                //                                   '${snapshot.data[indexvalue].stats.no_lalpurja}')
                //                               : Container(),
                //                         ],
                //                       )),

                //                   //                                               "total_population": 45608,
                //                   // "total_house": 11366,
                //                   // "male_population": 21108,
                //                   // "female_population": 24500,
                //                   // "others_population": 0
                //                 ]));
                //       }
                //     }),
              )),
        ],
      ),
    );
  }

  mapSection(index) {
    return Container(
      height: 300.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
          // mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              bearing: 0,
              target: LatLng(
                  double.parse(
                      value == null ? '27.76481' : value[indexvalue].wodalati),
                  double.parse(
                      value == null ? '85.30078' : value[indexvalue].wodalong)),
              tilt: 0,
              zoom: 11.5),
          markers: placedetail(
              double.parse(
                  value == null ? '85.30078' : value[indexvalue].wodalati),
              double.parse(
                  value == null ? '27.76481' : value[indexvalue].wodalong),
              value == null
                  ? 'काठमाडौँ महानगरपालिका'
                  : value[indexvalue].address),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              // add marker
              // allMarkers.add(Marker(
              //     markerId: MarkerId('Google'),
              //     draggable: false,
              //     position: LatLng(27.700769, 85.300140)));
            });
          },
        ),
      ),
    );
  }

  Set<Marker> placedetail(lat, lng, placename) {
    var tmp = Set<Marker>();

    tmp.add(
      Marker(
        markerId: MarkerId(placename),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: placename),
      ),
    );

    return tmp;
  }

  void error() {
    EasyLoading.show(status: 'Please wait...'.tr);
  }

  employeeSection(index) {
    return BlocBuilder<WodaJankariCubit, WodaJankariState>(
        builder: (context, state) {
      if (state is WodaJankariInitial || state is WodaJankariLoading) {
        return Container();
      } else if (state is WodaJankariFetched) {
        var wodajankari = state.wodajankaridata;
        return SingleChildScrollView(
          child: Column(
            children: [
              wodajankari[indexvalue].pratinidhi!.length > 0
                  ? titleText('pratinidhi'.tr)
                  : titleText(''),
              Container(
                height: Get.height *
                    0.12 *
                    wodajankari[indexvalue].pratinidhi!.length,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GridView.count(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    primary: false,
                    scrollDirection: Axis.vertical,
                    childAspectRatio: 3 / 2,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      wodajankari[indexvalue].pratinidhi!.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: GestureDetector(
                                  onTap: () {
                                    modal(
                                        context,
                                        wodajankari[indexvalue]
                                            .pratinidhi![index]);
                                  },
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "${wodajankari[indexvalue].pratinidhi![index].user_img_url}",
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                              'assets/images/dummyuser.png',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.contain),
                                        ),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          radius: 25,
                                          backgroundImage: imageProvider,
                                        ),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                          backgroundColor: primary,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        wodajankari[indexvalue]
                                            .pratinidhi![index]
                                            .name!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: textPrimaryDarkColor,
                                          fontFamily: 'Mukta',
                                          height: 1.5,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      Text(
                                        wodajankari[indexvalue]
                                                .pratinidhi![index]
                                                .designation ??
                                            '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primary,
                                            fontFamily: 'Mukta',
                                            fontSize: 14.0,
                                            height: 1),
                                      ),
                                      Text(
                                        wodajankari[indexvalue]
                                                .pratinidhi![index]
                                                .mobile ??
                                            '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primary,
                                            fontFamily: 'Mukta',
                                            fontSize: 14.0,
                                            height: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (state is WodaJankariFailure) {
        BlocProvider.of<WodaJankariCubit>(context).fetch();
        if (count < 2) EasyLoading.showError(state.error);
        count++;
        return Container();
        // return Center(child: Text(state.error,style: TextStyle(fontSize: 18,color: primary),));
      } else {
        return Container();
      }
    });
    // return FutureBuilder(
    //   future: getpratinidhidata(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       error();
    //       return SizedBox();
    //     } else {
    //       EasyLoading.dismiss();
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             snapshot.data[indexvalue].pratinidhi.length > 0
    //                 ? titleText('pratinidhi'.tr)
    //                 : titleText(''),
    //             Container(
    //               height: Get.height *
    //                   0.12 *
    //                   snapshot.data[indexvalue].pratinidhi.length,
    //               child: Card(
    //                 elevation: 0,
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(20.0)),
    //                 child: GridView.count(
    //                   padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    //                   primary: false,
    //                   scrollDirection: Axis.vertical,
    //                   childAspectRatio: 3 / 2,
    //                   crossAxisCount: 2,
    //                   mainAxisSpacing: 10,
    //                   children: List.generate(
    //                     snapshot.data[indexvalue].pratinidhi.length,
    //                     (index) {
    //                       return Padding(
    //                         padding: const EdgeInsets.all(0.0),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Padding(
    //                               padding: const EdgeInsets.all(0.0),
    //                               child: GestureDetector(
    //                                 onTap: () {
    //                                   modal(
    //                                       context,
    //                                       snapshot.data[indexvalue]
    //                                           .pratinidhi[index]);
    //                                 },
    //                                 child: Column(
    //                                   children: [
    //                                     CachedNetworkImage(
    //                                       imageUrl:
    //                                           "${snapshot.data[indexvalue].pratinidhi[index].user_img_url}",
    //                                       errorWidget: (context, url, error) =>
    //                                           ClipRRect(
    //                                         borderRadius:
    //                                             BorderRadius.circular(50.0),
    //                                         child: Image.asset(
    //                                             'assets/images/dummyuser.png',
    //                                             height: 80,
    //                                             width: 80,
    //                                             fit: BoxFit.contain),
    //                                       ),
    //                                       imageBuilder:
    //                                           (context, imageProvider) =>
    //                                               CircleAvatar(
    //                                         radius: 25,
    //                                         backgroundImage: imageProvider,
    //                                       ),
    //                                       placeholder: (context, url) =>
    //                                           CircularProgressIndicator(
    //                                         backgroundColor: primary,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     Text(
    //                                       snapshot.data[indexvalue]
    //                                           .pratinidhi[index].name,
    //                                       textAlign: TextAlign.center,
    //                                       style: TextStyle(
    //                                         color: textPrimaryDarkColor,
    //                                         fontFamily: 'Mukta',
    //                                         height: 1.5,
    //                                         fontSize: 13.0,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       snapshot
    //                                               .data[indexvalue]
    //                                               .pratinidhi[index]
    //                                               .designation ??
    //                                           '',
    //                                       textAlign: TextAlign.center,
    //                                       style: TextStyle(
    //                                           color: primary,
    //                                           fontFamily: 'Mukta',
    //                                           fontSize: 14.0,
    //                                           height: 1),
    //                                     ),
    //                                     Text(
    //                                       snapshot.data[indexvalue]
    //                                               .pratinidhi[index].mobile ??
    //                                           '',
    //                                       textAlign: TextAlign.center,
    //                                       style: TextStyle(
    //                                           color: primary,
    //                                           fontFamily: 'Mukta',
    //                                           fontSize: 14.0,
    //                                           height: 1),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  employeeSection1(index) {
    return BlocBuilder<WodaJankariCubit, WodaJankariState>(
        builder: (context, state) {
      if (state is WodaJankariInitial || state is WodaJankariLoading) {
        return Container();
      } else if (state is WodaJankariFetched) {
        var wodajankari = state.wodajankaridata;
        return SingleChildScrollView(
          child: Column(
            children: [
              wodajankari[indexvalue].karmachari!.length > 0
                  ? titleText('karmachari'.tr)
                  : titleText(''),
              Container(
                  height: Get.height *
                      0.16 *
                      wodajankari[indexvalue].karmachari!.length,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: GridView.count(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        primary: false,
                        scrollDirection: Axis.vertical,
                        childAspectRatio: 3 / 2,
                        crossAxisCount: 2,
                        children: List.generate(
                            wodajankari[indexvalue].karmachari!.length,
                            (index) {
                          return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "${wodajankari[indexvalue].karmachari![index].user_img}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                  'assets/images/dummyuser.png',
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.contain),
                                            ),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                              radius: 25,
                                              backgroundImage: imageProvider,
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              backgroundColor: tertiary,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            wodajankari[indexvalue]
                                                .karmachari![index]
                                                .name!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: textPrimaryDarkColor,
                                              fontFamily: 'Mukta',
                                              height: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Text(
                                            wodajankari[indexvalue]
                                                    .karmachari![index]
                                                    .mobile ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: primary,
                                                fontFamily: 'Mukta',
                                                fontSize: 14.0,
                                                height: 1),
                                          ),
                                          Text(
                                            wodajankari[indexvalue]
                                                    .karmachari![index]
                                                    .designation ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: primary,
                                                fontFamily: 'Mukta',
                                                fontSize: 14.0,
                                                height: 1),
                                          )
                                        ],
                                      ),
                                    ),
                                  ]));
                        })),
                  )),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
    // return FutureBuilder(
    //   future: getpratinidhidata(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return LinearProgressIndicator(color: primary,);
    //     }
    //     else if(snapshot.data == null){
    //       return Container();
    //     }
    //      else {
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             snapshot.data[indexvalue].karmachari.length > 0
    //                 ? titleText('karmachari'.tr)
    //                 : titleText(''),
    //             Container(
    //                 height: Get.height *
    //                     0.16 *
    //                     snapshot.data[indexvalue].karmachari.length,
    //                 child: Card(
    //                   elevation: 0,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20.0)),
    //                   child: GridView.count(
    //                       padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    //                       primary: false,
    //                       scrollDirection: Axis.vertical,
    //                       childAspectRatio: 3 / 2,
    //                       crossAxisCount: 2,
    //                       children: List.generate(
    //                           snapshot.data[indexvalue].karmachari.length,
    //                           (index) {
    //                         return Padding(
    //                             padding: const EdgeInsets.all(0.0),
    //                             child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.center,
    //                                 children: [
    //                                   Padding(
    //                                     padding: const EdgeInsets.all(0.0),
    //                                     child: Column(
    //                                       children: [
    //                                         CachedNetworkImage(
    //                                           imageUrl:
    //                                               "${snapshot.data[indexvalue].karmachari[index].user_img}",
    //                                           errorWidget:
    //                                               (context, url, error) =>
    //                                                   ClipRRect(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(50.0),
    //                                             child: Image.asset(
    //                                                 'assets/images/dummyuser.png',
    //                                                 height: 80,
    //                                                 width: 80,
    //                                                 fit: BoxFit.contain),
    //                                           ),
    //                                           imageBuilder:
    //                                               (context, imageProvider) =>
    //                                                   CircleAvatar(
    //                                             radius: 25,
    //                                             backgroundImage: imageProvider,
    //                                           ),
    //                                           placeholder: (context, url) =>
    //                                               CircularProgressIndicator(
    //                                             backgroundColor: tertiary,
    //                                           ),
    //                                         ),
    //                                         SizedBox(height: 5),
    //                                         Text(
    //                                           snapshot.data[indexvalue]
    //                                               .karmachari[index].name,
    //                                           textAlign: TextAlign.center,
    //                                           style: TextStyle(
    //                                             color: textPrimaryDarkColor,
    //                                             fontFamily: 'Mukta',
    //                                             height: 1.5,
    //                                             fontSize: 13.0,
    //                                           ),
    //                                         ),
    //                                         Text(
    //                                           snapshot
    //                                                   .data[indexvalue]
    //                                                   .karmachari[index]
    //                                                   .mobile ??
    //                                               '',
    //                                           textAlign: TextAlign.center,
    //                                           style: TextStyle(
    //                                               color: primary,
    //                                               fontFamily: 'Mukta',
    //                                               fontSize: 14.0,
    //                                               height: 1),
    //                                         ),
    //                                         Text(
    //                                           snapshot
    //                                                   .data[indexvalue]
    //                                                   .karmachari[index]
    //                                                   .designation ??
    //                                               '',
    //                                           textAlign: TextAlign.center,
    //                                           style: TextStyle(
    //                                               color: primary,
    //                                               fontFamily: 'Mukta',
    //                                               fontSize: 14.0,
    //                                               height: 1),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ]));
    //                       })),
    //                 )),
    //           ],
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  employeeSection2(index) {
    return FutureBuilder(
      future: getpratinidhidata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
            color: primary,
          );
        } else if (snapshot.data == null) {
          return Container();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                snapshot.data[indexvalue].users.length > 0
                    ? titleText('karyapalika'.tr)
                    : titleText(''),
                Container(
                    height: Get.height *
                        0.12 *
                        snapshot.data[indexvalue].users.length,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: GridView.count(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          primary: false,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: 3 / 2,
                          crossAxisCount: 2,
                          children: List.generate(
                              snapshot.data[indexvalue].users.length, (index) {
                            return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  "${snapshot.data[indexvalue].users[index].user_img_url}",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: Image.asset(
                                                    'assets/images/dummyuser.png',
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.contain),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 25,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(
                                                backgroundColor: tertiary,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              snapshot.data[indexvalue]
                                                  .users[index].name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: textPrimaryDarkColor,
                                                fontFamily: 'Mukta',
                                                height: 1.5,
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[indexvalue]
                                                      .users[index].mobile ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: primary,
                                                  fontFamily: 'Mukta',
                                                  fontSize: 14.0,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]));
                          })),
                    )),
              ],
            ),
          );
        }
      },
    );
  }

  Text dataText(a) {
    return Text(
      a,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: textPrimaryColor, fontFamily: 'Mukta', fontSize: 14.0),
    );
  }

  modal(context, data) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: data.user_img,
                  errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset('assets/images/dummyuser.png',
                        height: 80, width: 80, fit: BoxFit.contain),
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 35,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: primary,
                  ),
                ),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textPrimaryDarkColor,
                    fontFamily: 'Mukta',
                    height: 1.5,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  data.designation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primary,
                      fontFamily: 'Mukta',
                      fontSize: 14.0,
                      height: 1),
                ),
                new ButtonBar(
                  mainAxisSize: MainAxisSize
                      .min, // this will take space as minimum as posible(to center)
                  children: <Widget>[
                    // new RaisedButton(
                    //   child: new Text(translate(context, 'chat')),
                    //   color: primary,
                    //   onPressed: () {
                    //   },
                    // ),
                    new ElevatedButton(
                      child: new Text('call'.tr),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary),
                      ),
                      onPressed: () {
                        _callNumber(data.mobile);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  _callNumber(contact) async {
    var number = contact; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
