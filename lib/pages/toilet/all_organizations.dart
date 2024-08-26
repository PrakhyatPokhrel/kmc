import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:galli_map/galli_map.dart';
import 'package:kmc/components/custom_widget.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/toilet_model.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/toilet/full_organizations.dart';
class AllOrganizationPage extends StatefulWidget {
  const AllOrganizationPage({Key? key}) : super(key: key);

  @override
  AllOrganizationPageState createState() => AllOrganizationPageState();
}

class AllOrganizationPageState extends State<AllOrganizationPage> {
  Future<OrganizationModel> data() async {
    var public = await toiletGetOrganization();
    return public;
  }

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

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
                Text('all_organizations'.tr,
                    style: TextStyle(color: primary, fontSize: 22)),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  // print(notification.metrics);
                } else if (notification is ScrollUpdateNotification) {
                  notification.metrics;
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    if (c.next != null) {
                      c.addOrganization();
                      c.update();
                    }
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                  onRefresh: () async {
                    c.organizationData = <OrganizationModelData>[].obs;
                    c.update();
                  },
                  child: SingleChildScrollView(child: organizationWidget()))),
        ),
      ),
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

  headerText(text) {
    return Text(text,
        textAlign: TextAlign.left, style: TextStyle(fontSize: 18, height: 2));
  }

  organizationWidget() {
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
                                style: TextStyle(
                                    height: 1.3,
                                    color: textPrimaryColor,
                                    fontSize: 16))
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
                                style: TextStyle(
                                    height: 1.3,
                                    color: textPrimaryColor,
                                    fontSize: 16))
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
                    );
                  }
                },
              ),
            );
          } else {
            return ListWidget(
              c: c,
              
            );
          }
        });
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    required this.c,
    this.limit,
  });
  final Controller c;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: limit == null
                  ? c.organizationData.length
                  : c.organizationData.length > limit!
                      ? limit
                      : c.organizationData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    Position position= await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high,
                          timeLimit: const Duration(seconds: 10),
                        );
                    Get.to(
                        FullOrganizationPage(data: c.organizationData[index],position: position,));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                        imageUrl: c.organizationData[index]
                                            .organizationLogo,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                                child: Image.asset(
                                              'assets/images/Grey_Placeholder.png',
                                              fit: BoxFit.fill,
                                            )),
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                              width: 19,
                                              height: 19,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // rating(context, 0,
                                  //     ignoreGesture: true)
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LimitedBox(
                                    maxWidth: 260,
                                    child: Text(
                                        c.organizationData[index]
                                            .organizationName.tr,
                                        overflow: TextOverflow.ellipsis,
                                        // softWrap: false,
                                        style: TextStyle(
                                            height: 1.3,
                                            color: textPrimaryColor,
                                            fontSize: 16)),
                                  ),
                                  LimitedBox(
                                    child: Text(
                                        c.organizationData[index]
                                            .organizationAddress,
                                        overflow: TextOverflow.ellipsis,
                                        // softWrap: false,
                                        style: TextStyle(
                                            height: 1.3,
                                            color: textPrimaryColor,
                                            fontSize: 16)),
                                  ),
                                  // SizedBox(
                                  //   width: 170.0,
                                  //   child: Text(
                                  //       "${c.organizationData[index].organizationContact}",
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
                                  //       c.organizationData[index]
                                  //           .organizationEmail,
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
                                  //       snapshot.data!.data[index]
                                  //           .organizationWebsiteUrl,
                                  //       overflow: TextOverflow.ellipsis,
                                  //       softWrap: false,
                                  //       style: TextStyle(
                                  //           height: 1.3,
                                  //           color: textPrimaryColor,
                                  //           fontSize: 16)),
                                  // ),
                                ],
                              ),
                            ])),
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: c.showLoading.value,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator(),
              ),
            ))
      ],
    );
  }
}

class Controller extends GetxController {
  RxList<OrganizationModelData> organizationData =
      <OrganizationModelData>[].obs;
  RxString? next;
  RxBool showLoading = false.obs;
  addOrganization() async {
    showLoading = true.obs;
    if (next!.value != '') {
      var public = await toiletGetOrganization(url: next?.string);
      organizationData.addAll(public.data);
      if (public.pagination.next is String) {
        next = (public.pagination.next as String).obs;
      } else {
        next = ''.obs;
      }
    }
    showLoading = false.obs;
    update();
  }
}
