import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galli_map/galli_map.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/toilet_branch_model.dart';
import 'package:kmc/modal/toilet_model.dart';
import 'package:kmc/modal/toilet_single_branch.dart';
import 'package:kmc/pages/toilet/all_organizations.dart';
import 'package:kmc/pages/toilet/all_toilets.dart';
import 'package:kmc/pages/toilet/enroll_page.dart';
import 'package:kmc/pages/toilet/full_toilet_page.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class ToiletPage extends StatefulWidget {
  @override
  State<ToiletPage> createState() => _ToiletPageState();
}

class _ToiletPageState extends State<ToiletPage> {
  int indexvalue = 0;
  @override
  void initState() {
    super.initState();
  }

  bool reload = false;
  void reloadData() {
    setState(() {
      reload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                Text('toilet'.tr, style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              notification.metrics;
            } else if (notification is ScrollUpdateNotification) {
              notification.metrics;

              // _onUpdateScroll(notification.metrics);
            } else if (notification is ScrollEndNotification) {}
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              reloadData();
            },
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    ToiletWidget(
                      reload: reload,
                    )
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

class ToiletWidget extends StatefulWidget {
  const ToiletWidget({Key? key, required this.reload}) : super(key: key);
  final bool reload;
  @override
  ToiletState createState() => ToiletState();
}

class ToiletState extends State<ToiletWidget> {
  Future<ToiletBranchModel> tourism() async {
    var public = await getToiletBranches();
    return public;
  }

  int indexvalue = 0;
  dynamic value;
  dynamic subIndex = 0;
  bool location = false;
  bool ontapped = false;
  Position? position;
  @override
  void initState() {
    super.initState();
    askLocationPermission();
    indexvalue = 0;
  }

  askLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      Position newposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      setState(() {
        location = true;
        position = newposition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleText('nearby_toilet'.tr),
              SizedBox(
                height: 30,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      Get.to(const AllToilets());
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(10, 2, 5, 2),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: primary),
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: Colors.transparent,
                        elevation: 0),
                    icon: Icon(
                      Icons.arrow_forward,
                      color: secondary,
                    ),
                    //iconAlignment: IconAlignment.end,
                    label: Text(
                      "view_all".tr,
                      style: TextStyle(fontSize: 15, color: primary),
                    )),
              )
            ],
          ),
          (toiletWidget()),
          FutureBuilder<OrganizationModel>(
              future: toiletGetOrganization(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleText("all_organizations"),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  Get.to(const AllOrganizationPage());
                                  // Get.to(const EnrollPage());
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.fromLTRB(10, 2, 5, 2),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 2, color: primary),
                                        borderRadius: BorderRadius.circular(50)),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0),
                                //iconAlignment: IconAlignment.end,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: secondary,
                                ),
                                label: Text(
                                  "view_all".tr,
                                  style: TextStyle(fontSize: 15, color: primary),
                                )),
                          )
                        ],
                      ),

                      // SizedBox(
                      //   height: Get.height * 0.12,
                      //   child: GridView.count(
                      //       scrollDirection: Axis.horizontal,
                      //       primary: false,
                      //       childAspectRatio: 1.02,
                      //       crossAxisCount: 1,
                      //       children: List.generate(snapshot.data!.data.length,
                      //           (index) {
                      //         return Padding(
                      //           padding: const EdgeInsets.all(4.0),
                      //           child:
                      organizationWidget(limit: 3),

                      enroll(),
                      const SizedBox(
                        height: 20,
                      ),
                      // wardCard(snapshot.data!.data[index], index),
                      //         );
                      //       })),
                      // ),

                      // viewa
                    ],
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  enroll() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(tertiary),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5, horizontal: 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Text('enroll_now'.tr, style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
          onPressed: () {
            Get.to(EnrollPage());
          },
        ),
      ),
    );
  }

  titleText(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      child: Text('$title'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(color: primary, fontSize: 17, fontWeight: FontWeight.bold, height: 1.5)),
    );
  }

  wardCard(OrganizationModelData data, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            subIndex = data.id;
            // indexvalue = index;
            ontapped = false;
          });
        },
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: subIndex == data.id ? primary : shadowColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                  imageUrl: data.organizationLogo,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => ClipRRect(
                          child: Image.asset(
                        'assets/images/Grey_Placeholder.png',
                        fit: BoxFit.fill,
                      )),
                  placeholder: (context, url) => const SizedBox(
                        width: 19,
                        height: 19,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )),
            )));
  }

  Future<OrganizationModel> data() async {
    var public = await toiletGetOrganization();
    return public;
  }

  organizationWidget({int? limit}) {
    return GetBuilder<Controller>(
        init: Controller(),
        builder: (c) {
          if (c.organizationData.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: FutureBuilder<OrganizationModel>(
                future: data(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildMovieShimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                        heightFactor: 5,
                        child: Column(
                          children: [
                            Icon(
                              Icons.no_sim_outlined,
                              color: primary,
                              size: 80,
                            ),
                            Text("no_data_found".tr,
                                style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16))
                          ],
                        ));
                  } else if (snapshot.data!.data.isEmpty) {
                    return Center(
                        heightFactor: 5,
                        child: Column(
                          children: [
                            Icon(
                              Icons.no_sim_outlined,
                              color: primary,
                              size: 80,
                            ),
                            Text("no_data_found".tr,
                                style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16))
                          ],
                        ));
                  } else {
                    // setState(() {
                    if (c.organizationData.isEmpty) {
                      c.organizationData = snapshot.data!.data.obs;
                      c.next = snapshot.data!.pagination.next.toString().obs;
                    }
                    // });
                    return ListWidget(
                      c: c,
                      limit: limit,
                    );
                  }
                },
              ),
            );
          } else {
            return ListWidget(
              c: c,
              limit: limit,
            );
          }
        });
  }

  toiletWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: FutureBuilder<ToiletBranchModel>(
        future: tourism(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildMovieShimmer();
          } else if (snapshot.hasError) {
            return Center(
                heightFactor: 5,
                child: Column(
                  children: [
                    Icon(
                      Icons.no_sim_outlined,
                      color: primary,
                      size: 80,
                    ),
                    Text("no_data_found".tr,
                        style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16))
                  ],
                ));
          } else if (snapshot.data!.data.isEmpty) {
            return Center(
                heightFactor: 5,
                child: Column(
                  children: [
                    Icon(
                      Icons.no_sim_outlined,
                      color: primary,
                      size: 80,
                    ),
                    Text("no_data_found".tr,
                        style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16))
                  ],
                ));
          } else {
            List<ToiletBranchModelData> filteredData = subIndex != 0
                ? snapshot.data!.data.where((element) => element.organization.id == subIndex).toList()
                : snapshot.data!.data;
            if (position != null) {
              filteredData.sort((a, b) {
                final distanceA = calculateDistance(
                    LatLng(kDebugMode ? 27.69091887630131 : position!.latitude,
                        kDebugMode ? 85.32036235434515 : position!.longitude),
                    LatLng(double.parse(a.geoLocation.latitude), double.parse(a.geoLocation.longitude)));
                final distanceB = calculateDistance(
                    LatLng(kDebugMode ? 27.69091887630131 : position!.latitude,
                        kDebugMode ? 85.32036235434515 : position!.longitude),
                    LatLng(double.parse(b.geoLocation.latitude), double.parse(b.geoLocation.longitude)));

                return distanceA.compareTo(distanceB);
              });
            }
            return Column(
              children: <Widget>[
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredData.length > 2 ? 3 : filteredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            EasyLoading.show();
                            try {
                              ToiletSingleBranchModel data =
                                  await toiletGetSingleBranch(filteredData[index].id);
                              EasyLoading.dismiss();
                              Get.to(FullToiletPage(data: data));
                            } catch (e) {
                              EasyLoading.showError("Something went wrong");
                            }

                            // popUp(context, snapshot.data[index]);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 0,
                            color: Colors.white,
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15.0),
                                            child: CachedNetworkImage(
                                                imageUrl: filteredData[index].organization.organizationLogo,
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url, error) => ClipRRect(
                                                        child: Image.asset(
                                                      'assets/images/Grey_Placeholder.png',
                                                      fit: BoxFit.fill,
                                                    )),
                                                placeholder: (context, url) => const SizedBox(
                                                      width: 19,
                                                      height: 19,
                                                      child: CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<Color>(Colors.white),
                                                      ),
                                                    )),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          rating(context, filteredData[index].averageRating,
                                              ignoreGesture: true)
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 170.0,
                                                      child: Text(filteredData[index].location,
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              height: 1.3,
                                                              color: textPrimaryColor,
                                                              fontSize: 16)),
                                                    ),
                                                    LimitedBox(
                                                      maxWidth: 150.0,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Visibility(
                                                            visible: filteredData[index].disabledStatus,
                                                            child: const Row(
                                                              children: [
                                                                AvailabilityIcon(
                                                                  size: 15,
                                                                  icon: 'disabled.svg',
                                                                  color: Colors.green,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible:
                                                                filteredData[index].toiletType == 'male' ||
                                                                    filteredData[index].toiletType == 'all',
                                                            child: const AvailabilityIcon(
                                                              size: 15,
                                                              icon: 'male.svg',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Visibility(
                                                            visible:
                                                                filteredData[index].toiletType == 'female' ||
                                                                    filteredData[index].toiletType == 'all',
                                                            child: const AvailabilityIcon(
                                                              size: 15,
                                                              icon: 'female.svg',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Visibility(
                                                            replacement: SvgPicture.asset(
                                                              "assets/paid.svg",
                                                              height: 25,
                                                              width: 25,
                                                              color: Colors.red,
                                                            ),
                                                            visible:
                                                                filteredData[index].serviceType == "free",
                                                            child: SvgPicture.asset(
                                                              "assets/free.svg",
                                                              height: 25,
                                                              width: 25,
                                                              color: Colors.green,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        double lat = double.parse(
                                                            filteredData[index].geoLocation.latitude);
                                                        double long = double.parse(
                                                            filteredData[index].geoLocation.longitude);
                                                        var status = await Permission.location.request();
                                                        if (status == PermissionStatus.granted) {
                                                          try {
                                                            Position currentPosition =
                                                                await Geolocator.getCurrentPosition();
                                                            MapLauncher.showDirections(
                                                                origin: Coords(currentPosition.latitude,
                                                                    currentPosition.longitude),
                                                                mapType: Platform.isIOS
                                                                    ? MapType.apple
                                                                    : MapType.google,
                                                                destination: Coords(lat, long));
                                                          } catch (e) {
                                                            throw EasyLoading.showError("server_error".tr);
                                                          }
                                                        } else {
                                                          throw EasyLoading.showError(
                                                              "permission_request".tr);
                                                        }
                                                      },
                                                      child: AvailabilityIcon(
                                                        color: secondary,
                                                        size: 20,
                                                        icon: 'navigate.svg',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                          "${calculateDistance(LatLng(position == null ? 27.69091887630131 : position!.latitude, position == null ? 85.32036235434515 : position!.longitude), LatLng(double.parse(filteredData[index].geoLocation.latitude), double.parse(filteredData[index].geoLocation.longitude))).toStringAsFixed(2)} km",
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              height: 1.3, color: primary, fontSize: 16)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "${"Maintained By".tr}: ${filteredData[index].organization.organizationName}",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    height: 1.3, color: textPrimaryColor, fontSize: 13)),
                                            SizedBox(
                                              child: Text(filteredData[index].category.tr,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      height: 1.3, color: textPrimaryColor, fontSize: 14)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                          ),
                        );
                      }),
                )
              ],
            );
          }
        },
      ),
    );
  }

  rating(context, double initialRating, {bool ignoreGesture = false, int? size}) {
    return RatingBar.builder(
      itemSize: 10,
      initialRating: initialRating,
      minRating: 1,
      ignoreGestures: ignoreGesture,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        //  print(rating);
      },
    );
  }

  Widget buildMovieShimmer() => SizedBox(
        height: Get.height,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return const Column(
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

double calculateDistance(LatLng from, LatLng to) {
  const earthRadius = 6371.0; // in kilometers
  final lat1Rad = from.latitude * pi / 180.0;
  final lng1Rad = from.longitude * pi / 180.0;
  final lat2Rad = to.latitude * pi / 180.0;
  final lng2Rad = to.longitude * pi / 180.0;

  final dLat = lat2Rad - lat1Rad;
  final dLng = lng2Rad - lng1Rad;

  final a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1Rad) * cos(lat2Rad) * sin(dLng / 2) * sin(dLng / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}
