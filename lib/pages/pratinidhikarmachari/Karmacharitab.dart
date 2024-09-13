import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:kmc/components/shimmer.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/nagarkarmacharimodal.dart';
import 'package:kmc/modal/wodapratinidhi.dart';

class KarmachariTab extends StatefulWidget {
  @override
  _KarmachariTabState createState() => _KarmachariTabState();
}

class _KarmachariTabState extends State<KarmachariTab>
    with TickerProviderStateMixin {
  TabController? _kTabController;
  int _kCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    _kTabController =
        new TabController(vsync: this, length: 3, initialIndex: _kCurrentIndex);
  }

  Future<List<Nagarkarmacharidata>> wardsgetpratinidhidata() async {
    List<Nagarkarmacharidata> nagarkarmachari = await nagarKarmachari();
    nagarkarmachari = nagarkarmachari.reversed.toList();
    return nagarkarmachari;
  }

  Future<List<Nagarkarmacharidata>> exkarmachari() async {
    List<Nagarkarmacharidata> nagarkarmachari = await exkarmachariApi();
    return nagarkarmachari;
  }

  Future<List<Wodapratinidhi>> wodakamacharidata() async {
    List<Wodapratinidhi> woda = await wodakarmachariApi();
    return woda;
  }

  @override
  void dispose() {
    super.dispose();
    _kTabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Material(
            color: Colors.transparent,
            child: TabBar(
              onTap: ((index) =>
                  {_kCurrentIndex = index, print(_kCurrentIndex)}),
              controller: _kTabController,
              indicatorColor: primary,
              indicatorWeight: 3.0,
              labelColor: primary,
              unselectedLabelColor: textPrimaryColor,
              // indicator: ShapeDecoration(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //             bottomRight: Radius.circular(10),
              //             bottomLeft: Radius.circular(10))),
              //     color: primary),
              tabs: <Widget>[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text('palika-name-sub'.tr, style: TextStyle(fontSize: 16)),
                  ],
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text('ward'.tr, style: TextStyle(fontSize: 16)),
                  ],
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text('PurbaKarmachari'.tr, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new TabBarView(
              controller: _kTabController,
              children: <Widget>[
                nagarKWidget(),
                wodaKWidget(),
                purbaKarmachari(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  wodaKWidget() {
    return Padding(
      // height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: FutureBuilder<List>(
          future: wodakamacharidata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return ListView.builder(
                  // scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        titletext(snapshot.data[index].wardname),
                        Container(
                          height: Get.height * 0.2,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data[index].wodapratinidhi.length,
                              itemBuilder: (context, i) {
                                if (snapshot
                                    .data[index].wodapratinidhi.isEmpty) {
                                  return Container(
                                    child: Container(),
                                  );
                                } else {
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
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage:
                                                      imageProvider,
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(
                                                  backgroundColor: tertiary,
                                                ),
                                              ),
                                              // CircleAvatar(
                                              //   radius: 30.0,
                                              //   backgroundImage: NetworkImage(
                                              //       "${snapshot?.data[index].wodapratinidhi[i].image}"),
                                              //   backgroundColor:
                                              //       Colors.transparent,
                                              // ),
                                              Text(
                                                snapshot.data[index]
                                                    .wodapratinidhi[i].name,
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
                                                    .data[index]
                                                    .wodapratinidhi[i]
                                                    .designation,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: primary,
                                                    fontFamily: 'Mukta',
                                                    fontSize: 14.0,
                                                    height: 1),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                                .wodapratinidhi[
                                                            i] !=
                                                        null
                                                    ? "${snapshot.data[index].wodapratinidhi[i].mobile}"
                                                    : "",
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
                                  );
                                }
                              }),
                        )
                      ],
                    );
                  });
            }
          }),
    );
  }

  var size;

  nagarKWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: FutureBuilder<List>(
          future: wardsgetpratinidhidata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return ListView.builder(
                  // reverse: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                        // width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                      children: [
                        titletext(snapshot.data[index].head),
                        Container(
                          height: Get.height * 0.2,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data[index].headdata.length,
                              itemBuilder: (context, i) {
                                if (snapshot.data[index].headdata.isEmpty) {
                                  return Container(
                                    child: Container(),
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            modal(
                                                context,
                                                snapshot
                                                    .data[index].headdata[i]);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "${snapshot.data[index].headdata[i].icon}",
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
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage:
                                                      imageProvider,
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(
                                                  backgroundColor: tertiary,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index].headdata[i]
                                                    .name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: textPrimaryDarkColor,
                                                  fontFamily: 'Mukta',
                                                  height: 1.5,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index].headdata[i]
                                                    .designation,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: primary,
                                                    fontFamily: 'Mukta',
                                                    fontSize: 14.0,
                                                    height: 1),
                                              ),
                                              Text(
                                                snapshot.data[index].headdata[i]
                                                            .mobile !=
                                                        null
                                                    ? "${snapshot.data[index].headdata[i].mobile}"
                                                    : "",
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
                                  );
                                }
                              }),
                        )
                      ],
                    ));
                  });
            }
          }),
    );
  }

  purbaKarmachari() {
    return Container(
      // height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height * 8,
      child: FutureBuilder<List>(
          future: exkarmachari(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerWidget().buildMovieShimmer();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container(
                height: size.height,
                child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          // width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                        children: [
                          titletext(snapshot.data[index].head),
                          Container(
                            height: Get.height * 0.2,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data[index].headdata.length,
                                itemBuilder: (context, i) {
                                  if (snapshot.data[index].headdata.isEmpty) {
                                    return Container(
                                      child: Container(),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              modal(
                                                  context,
                                                  snapshot
                                                      .data[index].headdata[i]);
                                            },
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      "${snapshot.data[index].headdata[i].icon}",
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
                                                    radius: 35,
                                                    backgroundImage:
                                                        imageProvider,
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(
                                                    backgroundColor: tertiary,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .headdata[i].name,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: textPrimaryDarkColor,
                                                    fontFamily: 'Mukta',
                                                    height: 1.5,
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .headdata[i].designation,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: primary,
                                                      fontFamily: 'Mukta',
                                                      fontSize: 14.0,
                                                      height: 1),
                                                ),
                                                Text(
                                                  snapshot
                                                              .data[index]
                                                              .headdata[i]
                                                              .mobile !=
                                                          null
                                                      ? "${snapshot.data[index].headdata[i].mobile}"
                                                      : "",
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
                                    );
                                  }
                                }),
                          )
                        ],
                      ));
                    }),
              );
            }
          }),
    );
  }

  Widget titletext(title) {
    return Row(children: <Widget>[
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
                    backgroundColor: tertiary,
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
                        backgroundColor: WidgetStateProperty.all(primary),
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
