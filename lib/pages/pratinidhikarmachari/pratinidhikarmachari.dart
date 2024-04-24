import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/pratinidhikarmachari.dart';
import 'package:kmc/modal/wodapratinidhi.dart';
import 'package:kmc/pages/pratinidhikarmachari/Karmacharitab.dart';

class PraKarmachari extends StatefulWidget {
  @override
  _PraKarmachariState createState() => _PraKarmachariState();
}

class _PraKarmachariState extends State<PraKarmachari> {
  TabController? _tabController;
  int _currentIndex = 0;

  Future<List<Pratinidhikarmacharidata>> getpratinidhidata() async {
    List<Pratinidhikarmacharidata> pratinidhikarmacharilist =
        await getpratinidhi();
    return pratinidhikarmacharilist;
  }

  Future<List<Wodapratinidhi>> wardsgetpratinidhidata() async {
    List<Wodapratinidhi> wodapratinidhi = await getpratinidhiwoda();
    return wodapratinidhi;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
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
                  Text('prati_karma'.tr,
                      style: TextStyle(color: primary, fontSize: 22)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: primary, size: 28)),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: primary,
              labelColor: primary,
              unselectedLabelColor: textPrimaryColor,
              tabs: [
                Tab(text: 'representative'.tr),
                Tab(text: 'karmachari'.tr),
                // Tab(text: 'PurbaKarmachari'.tr)
              ],
            ),
          ),
          body: TabBarView(
            children: [pratinidhiTab(), KarmachariTab()],
          ),
        ),
      )),
    );
  }

  pratinidhiTab() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getpratinidhidata(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return ShimmerWidget().buildMovieShimmer();
                } else {
                  return Container(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data[0].headdata.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: GestureDetector(
                              onTap: () {
                                modal(
                                    context, snapshot.data[0].headdata[index]);
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${snapshot.data[0].headdata[index].icon}",
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        child: Image.asset(
                                          'assets/images/dummyuser.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 30,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                      backgroundColor: tertiary,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    snapshot.data[0].headdata[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textPrimaryDarkColor,
                                      fontFamily: 'Mukta',
                                      height: 1.5,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Text(
                                    snapshot
                                        .data[0].headdata[index]?.designation,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: primary,
                                        fontFamily: 'Mukta',
                                        fontSize: 14.0,
                                        height: 1),
                                  ),
                                  snapshot.data[0].headdata[index]?.mobile !=
                                          null
                                      ? Text(
                                          snapshot
                                              .data[0].headdata[index]?.mobile,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: primary,
                                              fontFamily: 'Mukta',
                                              fontSize: 14.0,
                                              height: 1),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
        ),

        karyapalikawid(),
        wodapratinidhi(),
        //*karyapalika
      ],
    ));
  }

  Widget titletext(title) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
      Text(title, style: TextStyle(color: primary, fontSize: 14)),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
    ]);
  }

//*karyapalika widget
  Widget karyapalikawid() {
    return FutureBuilder<List>(
        future: getpratinidhidata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerWidget().buildMovieShimmer();
          } else if (snapshot.data[1].headdata.length == 0) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Column(
              children: [
                titletext("कार्यपलिका"),
                Container(
                  height: 160,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data[1].headdata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: GestureDetector(
                            onTap: () {
                              modal(context, snapshot.data[1].headdata[index]);
                            },
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      "${snapshot.data[1].headdata[index].icon}",
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        'assets/images/dummyuser.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 30,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    backgroundColor: tertiary,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data[1].headdata[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: textPrimaryDarkColor,
                                    fontFamily: 'Mukta',
                                    height: 1.5,
                                    fontSize: 13.0,
                                  ),
                                ),
                                Text(
                                  snapshot.data[1].headdata[index]?.designation,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primary,
                                      fontFamily: 'Mukta',
                                      fontSize: 14.0,
                                      height: 1),
                                ),
                                snapshot.data[1].headdata[index]?.mobile != null
                                    ? Text(
                                        snapshot
                                            .data[1].headdata[index]?.mobile,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primary,
                                            fontFamily: 'Mukta',
                                            fontSize: 14.0,
                                            height: 1),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        });
  }

  Widget wodapratinidhi() {
    return Container(
      // height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      // height: MediaQuery.of(context).size.height * 3,
      child: FutureBuilder<List>(
          future: wardsgetpratinidhidata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container(
                // height: Get.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titletext(snapshot.data[index].wardname),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data[index].wodapratinidhi.length,
                                  itemBuilder: (context, i) {
                                    if (snapshot
                                        .data[index].wodapratinidhi.isEmpty) {
                                      return Container(
                                        child: Container(),
                                      );
                                    } else {
                                      snapshot.data[index].wodapratinidhi.sort(
                                          (b, a) => (a.designation ==
                                                      "वडा अध्यक्ष" ||
                                                  a.designation == "वडा अधयक्ष")
                                              ? 1
                                              : 0);
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                modal(
                                                    context,
                                                    snapshot.data[index]
                                                        .wodapratinidhi[i]);
                                              },
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        "${snapshot.data[index].wodapratinidhi[i].icon}",
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        child: Image.asset(
                                                          'assets/images/dummyuser.png',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          imageProvider,
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(
                                                      backgroundColor: tertiary,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data[index]
                                                        .wodapratinidhi[i].name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color:
                                                          textPrimaryDarkColor,
                                                      fontFamily: 'Mukta',
                                                      height: 1.5,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].wodapratinidhi[i].designation}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: primary,
                                                        fontFamily: 'Mukta',
                                                        fontSize: 14.0,
                                                        height: 1),
                                                  ),
                                                  snapshot
                                                              .data[index]
                                                              .wodapratinidhi[i]
                                                              .mobile !=
                                                          null
                                                      ? Text(
                                                          "${snapshot.data[index].wodapratinidhi[i].mobile}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: primary,
                                                              fontFamily:
                                                                  'Mukta',
                                                              fontSize: 14.0,
                                                              height: 1),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }
          }),
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
                  imageUrl: data.icon,
                  errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        'assets/images/dummyuser.png',
                        fit: BoxFit.contain,
                      ),
                    ),
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

  // Container loading() {
  //   return Container(
  //       child: Loading(
  //           indicator: BallPulseIndicator(), size: 100.0, color: primary));
  // }
}
