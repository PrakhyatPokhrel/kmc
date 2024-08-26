import 'dart:convert';

import 'package:badges/badges.dart' as badge;
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/Drawer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/newsnoticemodal.dart';
import 'package:kmc/modal/newsnoticemodalwordpress.dart';
import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:kmc/pages/bibhag/allbibhag.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasolist.dart';
import 'package:kmc/pages/hellomayor/mayorList.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayiklist.dart';
import 'package:kmc/pages/home/bibhagCard.dart';
import 'package:kmc/pages/home/homedata.dart';
import 'package:kmc/pages/home/sewaCard.dart';
import 'package:kmc/pages/home/sp_grid.dart';
import 'package:kmc/pages/news/newslist.dart';
import 'package:kmc/pages/profile/secondprofile.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexvalue = 0;
  NavDrawer? navdrawer;
  List bibagh = [];
  List specificbibagh = [];
  dynamic bibaghspecificdata;
  bool loginstatus = false;
  Channel? channel;
  String abc = "\$\$";
  dynamic ismayor;
  dynamic isvicemayor;
  dynamic issuchana;
  dynamic role;
  dynamic role_desig;
  dynamic thisweekdata;
  String? taxPayerId;

  dynamic getsharedpreference() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    setState(() {
      dynamic s = pref.getBool('login');
      ismayor = pref.getString('ismayor');
      if (s == null) {
        loginstatus = false;
        loginlout = false;
      }
      if (s != null) {
        getToken();
        loginstatus = s;
        loginlout = s;
        ismayor = pref.getString('ismayor');
        isvicemayor = pref.getString('isvicemayor');
        issuchana = pref.getString('issuchana');
        role = jsonDecode(pref.getString('role_desig')!);
        if (pref.getString('role_desig') != null) {
          role_desig = jsonDecode(pref.getString('role_desig')!);
        }
      } else {
        loginlout = false;
      }
      var b = pref.getInt('langindex');
      if (b != null) {
        indexvalue = pref.getInt('langindex')!;
      }
      String? a = pref.getString('lang');
      if (a != null) {
        setState(() {
          if (a == 'hi') {
            var locale = Locale(
                'hi', 'IN'); // translations will be displayed in that local
            Get.updateLocale(locale);
          } else {
            var locale = Locale(
                'en', 'US'); // translations will be displayed in that local
            Get.updateLocale(locale);
          }
        });
      } else {
        var locale =
            Locale('hi', 'IN'); // translations will be displayed in that local
        Get.updateLocale(locale);
      }
    });
  }

  Future<NewsNoticeModal> thisweek() async {
    var walingweek = await walingthisweek();
    return walingweek;
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //may cause problem
  _register() async {
    final prefs = await SharedPreferences.getInstance();
    //!Register Api Hit Here
    deviceregisterApi(prefs.getString('devicetoken')!);
  }

  Future<TaxPayerDetailModel> getTaxPayer() async {
    TaxPayerDetailModel detail = await getTaxPayerDetail();
    return detail;
  }

  @override
  void initState() {
    super.initState();

    getsharedpreference();
    _register();
    getBibagh();
    navdrawer = NavDrawer(this.callback, indexvalue);

    // getTaxPayer().then((value) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   setState(() {
    //     prefs.setString("sptaxID", "${value.data!.taxdata!.taxPayerId}");
    //     taxPayerId = prefs.getString("sptaxID");
    //   });
    //   print("Tax payer id:" + "$taxPayerId");
    // });
  }

  fetchapis() {
    getBibagh().then((value) => {
          setState(() {
            bibagh = value;
          })
        });
  }

  callback(language, index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // AppLocalizations.of(context).load(Locale(language));
    if (language == 'hi') {
      var locale =
          Locale('hi', 'IN'); // translations will be displayed in that local
      Get.updateLocale(locale);
    } else {
      var locale =
          Locale('en', 'US'); // translations will be displayed in that local
      Get.updateLocale(locale);
    }

    setState(() {
      pref.setString('lang', language);
      pref.setInt('langindex', index);
      indexvalue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        elevation: 0,
        actions: [],
        toolbarHeight: 0,
      ),
      backgroundColor: background,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: NavDrawer(this.callback, indexvalue),
      body: DoubleBack(
        background: background,
        textStyle: TextStyle(color: Colors.black),
        message: "Press back again to close",
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: CustomPaint(
                      painter: CurvePainter(true),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //First Row - Icon, Burgeer Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/kmcappicon.png',
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      // SvgPicture.asset(
                                      //   'icons/sp-icon/adsl.svg',
                                      //   color: Colors.green.shade500,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2.0,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 8.0),
                                    //   child: FittedBox(
                                    //     child: Text(
                                    //       "palika_name".tr,
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 20,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    //Beta, Parichyadh Kaal
                                    SizedBox(
                                      width: 8,
                                    ),

                                    // ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //     backgroundColor: Colors.red.shade700,
                                    //     padding: EdgeInsets.symmetric(
                                    //       vertical: 4,
                                    //       horizontal: 10,
                                    //     ),
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(16),
                                    //     ),
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: <Widget>[
                                    //       Text(
                                    //         'TestingPhase'.tr,
                                    //         style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontSize: 16,
                                    //         ),
                                    //       ),
                                    //       SizedBox(width: 3),
                                    //       Icon(
                                    //         Icons.info_outlined,
                                    //         size: 20.0,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   onPressed: () {
                                    //     Get.to(TestingPhaseScreen());
                                    //   },
                                    // ),
                                    // kDebugMode
                                    //     ? SizedBox(
                                    //         child: Text('    Staging',
                                    //             style: TextStyle(
                                    //                 color: Colors.white)),
                                    //       )
                                    //     : SizedBox(),
                                  ],
                                ),
                                //!Right Side
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceBetween,
                                  children: [
                                    loginstatus == true
                                        ? badge.Badge(
                                            // toAnimate: true,
                                            badgeStyle: badge.BadgeStyle(
                                              padding: EdgeInsets.zero,
                                            ),
                                            badgeContent: FutureBuilder(
                                              future: applicationCountApi(),
                                              builder: (
                                                context,
                                                AsyncSnapshot<int> snapshot,
                                              ) {
                                                if (snapshot.hasError) {
                                                  return Container();
                                                } else if (snapshot.hasData) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: snapshot.data != 0
                                                        ? Text(
                                                            'application'.tr ==
                                                                    'Applications'
                                                                ? snapshot.data
                                                                    .toString()
                                                                : NepaliUnicode
                                                                    .convert(
                                                                    snapshot
                                                                        .data
                                                                        .toString(),
                                                                  ),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          )
                                                        : Text(
                                                            "0",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                  );
                                                } else {
                                                  return SizedBox.shrink();
                                                }
                                              },
                                            ),
                                            position:
                                                badge.BadgePosition.topEnd(
                                              top: -3,
                                              end: -3,
                                            ),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.only(
                                                top: 8,
                                                left: 8,
                                                right: 8,
                                                bottom: 8,
                                              )),
                                              onPressed: () {
                                                Get.to(SecondProfile());
                                              },
                                              child: Text(
                                                'application'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    // VerticalDivider(),
                                    Builder(
                                      builder: (context) => IconButton(
                                        iconSize: 30,
                                        alignment: Alignment.topLeft,
                                        icon: new Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => {
                                          Scaffold.of(context).openEndDrawer(),
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            //YO Hapta/ This week!! News Section
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "in_palika_today".tr,
                                          // "palika_name".tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        FutureBuilder<
                                                List<NewsNoticeModelWordpress>>(
                                            future: wordpressApi(),
                                            builder: ((context, snapshot) {
                                              if (snapshot.hasData) {
                                                var news = snapshot.data!;
                                                if (news.isNotEmpty) {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          news.first.title,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }
                                              return SizedBox();
                                            })),
                                      ],
                                    ),
                                  ),

                                  // Expanded(
                                  //     flex: 9,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(left: 8.0),
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //             'Welcome_Message'.tr,
                                  //             textAlign: TextAlign.start,
                                  //             maxLines: 2,
                                  //             overflow: TextOverflow.ellipsis,
                                  //             style: TextStyle(
                                  //               color: white,
                                  //               fontSize: 18,
                                  //               height: 1.5,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     )),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'view'.tr,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: secondary,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Icon(
                                                Icons.info_outlined,
                                                size: 20.0,
                                                color: secondary,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            // var a = {
                                            //   'name': 'NEWS'.tr,
                                            //   'title': thisweekdata.title,
                                            //   'news_date': thisweekdata.news_date,
                                            //   'feature_img':
                                            //       thisweekdata.feature_img,
                                            //   'link': thisweekdata.link,
                                            //   'detail': thisweekdata.detail,
                                            //   'news_file': thisweekdata.news_file,
                                            // };
                                            //G
                                            Get.to(NewsList(
                                              isBackRequired: true,
                                            ));
                                            // Get.to(Emeeting());
                                          },
                                        ),
                                        // SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Bibhag paxiko
              Container(
                  margin: EdgeInsets.only(top: 155),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        //Sewa section [includes: Sanchar, Jankari aka PraKarmachari, Sifarish]
                        Container(
                          // height: MediaQuery.of(context).size.width * 1.44,
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12);
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sewa.length,
                            itemBuilder: (context, index) {
                              // print(sewa[index].title);
                              return Container(
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    titleText(
                                        '${sewa[index].title}'.tr,
                                        index == 0 ? white : primary,
                                        sewa[index].link
                                        // != null
                                        //     ? sewa[index].link
                                        //     : null
                                        ),
                                    SizedBox(height: 6),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.32,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(width: 12);
                                        },
                                        padding: EdgeInsets.zero,
                                        // reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sewa[index].sewadata.length,
                                        itemBuilder: (context, i) {
                                          return InkWell(
                                            onTap: () {
                                              if (sewa[index]
                                                      .sewadata[i]
                                                      .details ==
                                                  '') {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      title: Text(
                                                          'service_not_available'
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: primary)),
                                                      // content: Text('login_alert'.tr,
                                                      //     textAlign: TextAlign.center,
                                                      //     style: TextStyle(fontSize: 16, height: 1.5)),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                          tertiary),
                                                              shape: WidgetStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    16.0,
                                                                vertical: 10,
                                                              ),
                                                              child: Text(
                                                                  'cancel'.tr),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              Get.back();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                if (sewa[index]
                                                            .sewadata[i]
                                                            .title !=
                                                        "" &&
                                                    sewa[index]
                                                            .sewadata[i]
                                                            .title !=
                                                        "" &&
                                                    sewa[index]
                                                            .sewadata[i]
                                                            .title !=
                                                        "" &&
                                                    sewa[index]
                                                            .sewadata[i]
                                                            .title !=
                                                        "digital_profile") {
                                                  navigation(context, i,
                                                      sewa[index].sewadata[i]);
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        title: Text(
                                                            'service_not_available'
                                                                .tr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    primary)),
                                                        // content: Text('login_alert'.tr,
                                                        //     textAlign: TextAlign.center,
                                                        //     style: TextStyle(fontSize: 16, height: 1.5)),
                                                        actions: [
                                                          Center(
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty
                                                                        .all(
                                                                            tertiary),
                                                                shape: WidgetStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                  vertical: 10,
                                                                ),
                                                                child: Text(
                                                                    'cancel'
                                                                        .tr),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                            child: SewaCard(
                                              data: sewa[index].sewadata[i],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
//Ward Section
                        // Container(
                        //     child: Padding(
                        //         padding: const EdgeInsets.only(bottom: 16),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             titleText('ward-info'.tr, primary, null),
                        //             WodaPart(),
                        //           ],
                        //         ))),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                              bottom: 24,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                titleText('other_sewa'.tr, primary, null),
                                SizedBox(height: 6),

                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      if (constraints.maxWidth >= 500.0) {
                                        return Container(
                                          height: Get.height * 0.50,
                                          child: GridView.count(
                                              // scrollDirection: Axis.vertical,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              primary: false,
                                              childAspectRatio: 1,
                                              crossAxisCount: 3,
                                              children: List.generate(
                                                  gridData.length, (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SpGrid(
                                                      data: gridData[index]),
                                                );
                                              })),
                                        );
                                      } else {
                                        return Container(
                                          height: Get.height * 0.3,
                                          child: GridView.count(
                                            // scrollDirection: Axis.vertical,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            primary: false,
                                            childAspectRatio: 1,
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 18,
                                            mainAxisSpacing: 18,
                                            children: List.generate(
                                              gridData.length,
                                              (index) {
                                                return SpGrid(
                                                  data: gridData[index],
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                //Department/ Bibhag
                                titleText(
                                    'departmnt'.tr, primary, BibaghList()),
                                SizedBox(height: 6),
                                Container(
                                  height: MediaQuery.of(context).size.width *
                                      0.3 *
                                      2.15,
                                  child: GridView.count(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    primary: false,
                                    childAspectRatio: 0.9,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    children: List.generate(
                                      homeData.length,
                                      (index) {
                                        return BibhagCard(
                                            data: homeData[index]);
                                      },
                                    ),
                                  ),
                                ),

                                // MediaQuery.of(context).size.width >= 720.0
                                //     ? Container(
                                //         height: Get.height * 0.60,
                                //         child: GridView.count(
                                //             // scrollDirection: Axis.vertical,
                                //             physics:
                                //                 NeverScrollableScrollPhysics(),
                                //             primary: false,
                                //             childAspectRatio: 1,
                                //             crossAxisCount: 3,
                                //             children: List.generate(
                                //                 gridData.length, (index) {
                                //               return Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(8.0),
                                //                 child: SpGrid(
                                //                     data: gridData[index]),
                                //               );
                                //             })),
                                //       )
                                //     : Container(
                                //         height: Get.height * 0.40,
                                //         child: GridView.count(
                                //             // scrollDirection: Axis.vertical,
                                //             physics:
                                //                 NeverScrollableScrollPhysics(),
                                //             primary: false,
                                //             childAspectRatio: 1,
                                //             crossAxisCount: 3,
                                //             children: List.generate(
                                //                 gridData.length, (index) {
                                //               return Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(8.0),
                                //                 child: SpGrid(
                                //                     data: gridData[index]),
                                //               );
                                //             })),
                                //       )
                              ],
                            )),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  titleText(title, _color, link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: _color, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Icon(Icons.chevron_left, color: _color),
        Icon(Icons.chevron_right, color: _color),
        Spacer(flex: 2),
        link != null
            ? InkWell(
                onTap: () {
                  if (loginstatus == false) {
                    checklogin();
                  } else
                    Get.to(link);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.visibility, color: _color),
                ))
            : Container(),
      ]),
    );
  }

  navigation(context, index, data) {
    // if (loginstatus == false && data.permit == true) {
    //   checklogin();
    // } else {
    //   Get.to(data.link);
    // }

    if (data.permit == true) {
      if (loginstatus == true) {
        if (data.title == 'hello_mayor') {
          if (ismayor == "TRUE") {
            Get.to(MayorList());
          } else {
            Get.to(data.link);
          }
        } else if (data.title == 'Judicial_committee') {
          if (isvicemayor == "TRUE") {
            Get.to(NyayikList());
          } else {
            Get.to(data.link);
          }
        } else if (data.title == 'janagunaso') {
          if (issuchana == "TRUE") {
            Get.to(GunasoList());
          } else {
            Get.to(data.link);
          }
        } else {
          Get.to(data.link);
        }
      }
      if (loginstatus == false) {
        checklogin();
      }
    } else {
      Get.to(data.link);
    }
  }

  checklogin() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('LOGIN'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('login_alert'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(tertiary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('LOGIN'.tr),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(Login());
                  },
                ),
              ),
            ],
          );
        });
  }

  rolealert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('not_available'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            content: Text('role_check'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(tertiary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('cancel'.tr),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          );
        });
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var rect = Offset.zero & size;
    paint.shader = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        primary,
        secondary,
      ],
    ).createShader(rect);
    // paint.color = primary;
    // paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
