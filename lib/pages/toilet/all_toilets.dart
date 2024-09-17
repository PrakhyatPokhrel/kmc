import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:galli_map/galli_map.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/toilet_branch_model.dart';
import 'package:kmc/modal/toilet_model.dart';
import 'package:kmc/modal/toilet_single_branch.dart';
import 'package:kmc/pages/toilet/all_organizations.dart';
import 'package:kmc/pages/toilet/full_toilet_page.dart';
import 'package:kmc/pages/toilet/toilet.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class AllToilets extends StatefulWidget {
  const AllToilets({Key? key}) : super(key: key);

  @override
  State<AllToilets> createState() => _AllToiletsState();
}

class _AllToiletsState extends State<AllToilets> {
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
                Text('all_toilets'.tr, style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: primary,
                    size: 28,
                  ),
                ),
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
    // var status = await Permission.location.request();
    // if (status == PermissionStatus.granted) {
    Position newposition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );
    setState(() {
      location = true;
      position = newposition;
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (publicPlaceswidget()),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  viewAll() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(tertiary),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5, horizontal: 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Text('SEND'.tr, style: TextStyle(color: textPrimaryLightColor, fontSize: 20)),
          onPressed: () {
            Get.to(AllOrganizationPage());
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

  publicPlaceswidget() {
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
                      itemCount: filteredData.length,
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
                                            // SizedBox(
                                            //   width: 170.0,
                                            //   child: Text(
                                            //       '${filteredData[index].organization.organizationName},${filteredData[index].location}'
                                            //           .tr,
                                            //       overflow: TextOverflow.ellipsis,
                                            //       softWrap: false,
                                            //       style: TextStyle(
                                            //           height: 1.3,
                                            //           color: textPrimaryColor,
                                            //           fontSize: 16)),
                                            // ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
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

                                                          // Icon(BootstrapIcons.)
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

                                            // SizedBox(
                                            //   width: 170.0,
                                            //   child: Text(
                                            //       "${calculateDistance(LatLng(27.69091887630131, 85.32036235434515), LatLng(double.parse(filteredData[index].geoLocation.latitude), double.parse(filteredData[index].geoLocation.longitude))).toStringAsFixed(2)} km",
                                            //       overflow: TextOverflow.ellipsis,
                                            //       softWrap: false,
                                            //       style: TextStyle(
                                            //           height: 1.3,
                                            //           color: textPrimaryColor,
                                            //           fontSize: 16)),
                                            // ),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
                                            // LimitedBox(
                                            //   maxWidth: 170.0,
                                            //   child: Text("Maintained By:",
                                            //       overflow: TextOverflow.ellipsis,
                                            //       softWrap: false,
                                            //       style: TextStyle(
                                            //           height: 1.3,
                                            //           color: textPrimaryColor,
                                            //           fontSize: 16)),
                                            // ),
                                            // LimitedBox(
                                            //   maxWidth: 170.0,
                                            //   child: Text(
                                            //       filteredData[index]
                                            //           .organization
                                            //           .organizationName,
                                            //       overflow: TextOverflow.ellipsis,
                                            //       softWrap: false,
                                            //       style: TextStyle(
                                            //           height: 1.3,
                                            //           color: textPrimaryColor,
                                            //           fontSize: 16)),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      // Column(children: [
                                      //   GestureDetector(
                                      //     onTap: () async {
                                      //       double lat = double.parse(
                                      //           filteredData[index]
                                      //               .geoLocation
                                      //               .latitude);
                                      //       double long = double.parse(
                                      //           filteredData[index]
                                      //               .geoLocation
                                      //               .longitude);
                                      //       var status = await Permission
                                      //           .location
                                      //           .request();
                                      //       if (status ==
                                      //           PermissionStatus.granted) {
                                      //         try {
                                      //           Position currentPosition =
                                      //               await Geolocator
                                      //                   .getCurrentPosition();
                                      //           MapLauncher.showDirections(
                                      //               origin: Coords(
                                      //                   currentPosition
                                      //                       .latitude,
                                      //                   currentPosition
                                      //                       .longitude),
                                      //               mapType: Platform.isIOS
                                      //                   ? MapType.apple
                                      //                   : MapType.google,
                                      //               destination:
                                      //                   Coords(lat, long));
                                      //         } catch (e) {
                                      //           throw EasyLoading.showError(
                                      //               "server_error".tr);
                                      //         }
                                      //       } else {
                                      //         throw EasyLoading.showError(
                                      //             "permission_request".tr);
                                      //       }
                                      //     },
                                      //     child: Container(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 vertical: 4.0,
                                      //                 horizontal: 1),
                                      //         decoration: BoxDecoration(
                                      //           borderRadius:
                                      //               BorderRadius.circular(10.0),
                                      //           color: white,
                                      //         ),
                                      //         child: SvgPicture.asset(
                                      //           'assets/images/icons/location.svg',
                                      //           height: 40,
                                      //           width: 40,
                                      //           fit: BoxFit.cover,
                                      //         )),
                                      //   ),
                                      //   const SizedBox(width: 10),
                                      // ]),
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
