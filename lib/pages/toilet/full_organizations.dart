import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:galli_map/galli_map.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/toilet_model.dart';
import 'package:kmc/modal/toilet_single_branch.dart';
import 'package:kmc/pages/toilet/full_toilet_page.dart';
import 'package:kmc/pages/toilet/toilet.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class FullOrganizationPage extends StatelessWidget {
  const FullOrganizationPage(
      { required this.data, required this.position});
  final OrganizationModelData data;
  final Position position;

  @override
  Widget build(BuildContext context) {
    rating(context, double initialRating,
        {bool ignoreGesture = false, int? size}) {
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

    return Scaffold(
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
              LimitedBox(
                maxWidth: Get.width / 1.5,
                child: Text(data.organizationName,
                    style: TextStyle(color: primary, fontSize: 22)),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: primary, size: 28)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data.organizationLogo,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimitedBox(
                                  maxWidth: Get.width / 1.8,
                                  child: Text(
                                    data.organizationName,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        height: 1.3,
                                        color: textPrimaryColor,
                                        fontSize: 16),
                                  ),
                                ),
                                CompanyDetailsText(
                                  text: data.organizationAddress,
                                ),
                                // CompanyDetailsText(
                                //   text: data.organizationContact,
                                // ),
                                // CompanyDetailsText(
                                //   text: data.organizationEmail,
                                // ),
                                CompanyDetailsText(
                                  text: data.focalPerson,
                                ),
                                CompanyDetailsText(
                                  text: data.organizationType.tr,
                                ),
                                // CompanyDetailsText(text: 'siddartha@bank.com',),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(data.organizationDescription,
                          style:
                              TextStyle(color: textPrimaryColor, fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      launchUrl(
                          Uri.parse('tel:+977${data.organizationContact}'));
                    },
                    leading: Icon(
                      Icons.call,
                      color: primary,
                    ),
                    title: Text(
                      "phone".tr,
                      style: TextStyle(
                          height: 1.3, color: textPrimaryColor, fontSize: 14),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: data.organizationEmail != "N/A",
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: ListTile(
                      // contentPadding: EdgeInsets.zero,
                      onTap: () {
                        launchUrl(
                            Uri.parse('mailto:${data.organizationEmail}'));
                      },
                      leading: Icon(
                        // size: 14,

                        Icons.mail,
                        color: primary,
                      ),
                      title: Text(
                        "email".tr,
                        style: TextStyle(
                            height: 1.3, color: textPrimaryColor, fontSize: 14),
                      ),
                      trailing: Icon(
                        // size: 14,
                        Icons.chevron_right,
                        color: primary,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: data.organizationQr != null,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.network(
                        '${data.organizationQr}',
                        height: Get.width / 2,
                        width: Get.width / 2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: data.branches.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleText('organization_toilet'.tr),
                      SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.branches.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  EasyLoading.show();
                                  try {
                                    ToiletSingleBranchModel newdata =
                                        await toiletGetSingleBranch(
                                            data.branches[index].id);
                                    EasyLoading.dismiss();
                                    Get.to(FullToiletPage(data: newdata));
                                  } catch (e) {
                                    EasyLoading.showError(
                                        "Something went wrong");
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          data.organizationLogo,
                                                      // imageUrl: data
                                                      //     .branches[index]
                                                      //     .organizationImage,
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                              child:
                                                                  Image.asset(
                                                            'assets/image.png',
                                                            fit: BoxFit.fill,
                                                          )),
                                                      placeholder:
                                                          (context, url) =>
                                                              const SizedBox(
                                                                width: 19,
                                                                height: 19,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                                ),
                                                              )),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                rating(
                                                    context,
                                                    data.branches[index]
                                                        .averageRating,
                                                    ignoreGesture: true)
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // SizedBox(
                                                  //   width: 170.0,
                                                  //   child: Text(
                                                  //       '${data.branches[index].organization.organizationName},${data.branches[index].location}'
                                                  //           .tr,
                                                  //       overflow: TextOverflow.ellipsis,
                                                  //       softWrap: false,
                                                  //       style: TextStyle(
                                                  //           height: 1.3,
                                                  //           color: textPrimaryColor,
                                                  //           fontSize: 16)),
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 170.0,
                                                            child: Text(
                                                                data
                                                                    .branches[
                                                                        index]
                                                                    .location,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    height: 1.3,
                                                                    color:
                                                                        textPrimaryColor,
                                                                    fontSize:
                                                                        16)),
                                                          ),
                                                          LimitedBox(
                                                            maxWidth: 150.0,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Visibility(
                                                                  visible: data
                                                                      .branches[
                                                                          index]
                                                                      .disabledStatus,
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      AvailabilityIcon(
                                                                        size:
                                                                            15,
                                                                        icon:
                                                                            'disabled.svg',
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: data
                                                                              .branches[
                                                                                  index]
                                                                              .toiletType ==
                                                                          'male' ||
                                                                      data.branches[index]
                                                                              .toiletType ==
                                                                          'all',
                                                                  child:
                                                                      const AvailabilityIcon(
                                                                    size: 15,
                                                                    icon:
                                                                        'male.svg',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Visibility(
                                                                  visible: data
                                                                              .branches[
                                                                                  index]
                                                                              .toiletType ==
                                                                          'female' ||
                                                                      data.branches[index]
                                                                              .toiletType ==
                                                                          'all',
                                                                  child:
                                                                      const AvailabilityIcon(
                                                                    size: 15,
                                                                    icon:
                                                                        'female.svg',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Visibility(
                                                                  replacement:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/paid.svg",
                                                                    height: 25,
                                                                    width: 25,
                                                                    color:
                                                                        primary,
                                                                  ),
                                                                  visible: data
                                                                          .branches[
                                                                              index]
                                                                          .serviceType ==
                                                                      "free",
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/free.svg",
                                                                    height: 25,
                                                                    width: 25,
                                                                    color:
                                                                        primary,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              double lat = double
                                                                  .parse(data
                                                                      .branches[
                                                                          index]
                                                                      .geoLocation
                                                                      .latitude);
                                                              double long = double
                                                                  .parse(data
                                                                      .branches[
                                                                          index]
                                                                      .geoLocation
                                                                      .longitude);
                                                              var status =
                                                                  await Permission
                                                                      .location
                                                                      .request();
                                                              if (status ==
                                                                  PermissionStatus
                                                                      .granted) {
                                                                try {
                                                                  Position
                                                                      currentPosition =
                                                                      await Geolocator
                                                                          .getCurrentPosition();
                                                                  MapLauncher.showDirections(
                                                                      origin: Coords(
                                                                          currentPosition
                                                                              .latitude,
                                                                          currentPosition
                                                                              .longitude),
                                                                      mapType: Platform.isIOS
                                                                          ? MapType
                                                                              .apple
                                                                          : MapType
                                                                              .google,
                                                                      destination:
                                                                          Coords(
                                                                              lat,
                                                                              long));
                                                                } catch (e) {
                                                                  throw EasyLoading
                                                                      .showError(
                                                                          "server_error"
                                                                              .tr);
                                                                }
                                                              } else {
                                                                throw EasyLoading
                                                                    .showError(
                                                                        "permission_request"
                                                                            .tr);
                                                              }
                                                            },
                                                            child:
                                                                AvailabilityIcon(
                                                              color: secondary,
                                                              size: 20,
                                                              icon:
                                                                  'navigate.svg',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          SizedBox(
                                                            child: Text(
                                                                "${calculateDistance(LatLng(position.latitude, position.longitude), LatLng(double.parse(data.branches[index].geoLocation.latitude), double.parse(data.branches[index].geoLocation.longitude))).toStringAsFixed(2)} km",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    height: 1.3,
                                                                    color:
                                                                        primary,
                                                                    fontSize:
                                                                        16)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "${"Maintained By".tr}: ${data.organizationName}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          height: 1.3,
                                                          color:
                                                              textPrimaryColor,
                                                          fontSize: 13)),
                                                  SizedBox(
                                                    child: Text(
                                                        data.branches[index]
                                                            .category.tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            height: 1.3,
                                                            color:
                                                                textPrimaryColor,
                                                            fontSize: 14)),
                                                  ),

                                                  // SizedBox(
                                                  //   width: 170.0,
                                                  //   child: Text(
                                                  //       "${calculateDistance(LatLng(27.69091887630131, 85.32036235434515), LatLng(double.parse(data.branches[index].geoLocation.latitude), double.parse(data.branches[index].geoLocation.longitude))).toStringAsFixed(2)} km",
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
                                                  //       data.branches[index]
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
                                          ])),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
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
}
