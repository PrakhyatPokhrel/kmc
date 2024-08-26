import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/toilet_single_branch.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:galli_map/galli_map.dart';

class FullToiletPage extends StatefulWidget {
  const FullToiletPage({Key? key, required this.data}) : super(key: key);
  final ToiletSingleBranchModel data;

  @override
  State<FullToiletPage> createState() => _FullToiletPageState();
}

class _FullToiletPageState extends State<FullToiletPage> {
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  // final Set<Marker> listMarkers = {};
  @override
  Widget build(BuildContext context) {
    Map<String, AbstractControl<dynamic>> formMap = {};
    final FormGroup formGroup = FormGroup(formMap);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(color: primary)),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '${widget.data.data.branches.organizationImage}',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  rating(context, 15, 1, (value) {}, 0)
                                ],
                              ),
                              SizedBox(width: 10),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   width: 150.0,
                                    //   child: Text(
                                    //       '${widget.data.data.bra}'
                                    //           .tr,
                                    //       overflow:
                                    //           TextOverflow.ellipsis,
                                    //       softWrap: false,
                                    //       style: TextStyle(
                                    //           height: 1.3,
                                    //           color:
                                    //               textPrimaryColor,
                                    //           fontSize: 16)),
                                    // ),
                                    SizedBox(
                                      width: 150.0,
                                      child: Text(
                                          '${widget.data.data.branches.organizationName},${widget.data.data.branches.location}',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              height: 1.3,
                                              color: textPrimaryColor,
                                              fontSize: 16)),
                                    ),
                                    SizedBox(
                                      width: 150.0,
                                      child: Text(
                                          "Price: ${widget.data.data.branches.serviceType}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              height: 1.3,
                                              color: textPrimaryColor,
                                              fontSize: 16)),
                                    ),
                                    SizedBox(
                                      width: 150.0,
                                      child: Text(
                                          "Type: ${widget.data.data.branches.category}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              height: 1.3,
                                              color: textPrimaryColor,
                                              fontSize: 16)),
                                    ),
                                    SizedBox(
                                      width: 150.0,
                                      child: Text(
                                          "Location: ${widget.data.data.branches.location}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              height: 1.3,
                                              color: textPrimaryColor,
                                              fontSize: 16)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // LimitedBox(
                                    //   maxWidth: 150.0,
                                    //   child: Text(
                                    //       "Availability:",
                                    //       overflow:
                                    //           TextOverflow.ellipsis,
                                    //       softWrap: false,
                                    //       style: TextStyle(
                                    //           height: 1.3,
                                    //           color:
                                    //               textPrimaryColor,
                                    //           fontSize: 16)),
                                    // ),
                                    //        SizedBox(height: 10,),

                                    LimitedBox(
                                      maxWidth: 150.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: widget.data.data.branches
                                                .disabledStatus,
                                            child: Row(
                                              children: [
                                                AvailabilityIcon(
                                                  icon: 'disabled.svg',
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.data.data.branches
                                                        .toiletType ==
                                                    'male' ||
                                                widget.data.data.branches
                                                        .toiletType ==
                                                    'all',
                                            child: AvailabilityIcon(
                                              icon: 'male.svg',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Visibility(
                                            visible: widget.data.data.branches
                                                        .toiletType ==
                                                    'female' ||
                                                widget.data.data.branches
                                                        .toiletType ==
                                                    'all',
                                            child: AvailabilityIcon(
                                              icon: 'female.svg',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.network(
                            '${widget.data.data.branches.branchQr}',
                            height: 80,
                            width: 80,
                            fit: BoxFit.fill,
                            // errorWidget:
                            //     (context, url, error) =>
                            //         ClipRRect(
                            //             child: Image.asset(
                            //           'assets/images/Grey_Placeholder.png',
                            //           fit: BoxFit.fill,
                            //         )),
                            // placeholder: (context, url) =>
                            //     Container(
                            //       width: 19,
                            //       height: 19,
                            //       child:
                            //           CircularProgressIndicator(
                            //         valueColor:
                            //             AlwaysStoppedAnimation<
                            //                     Color>(
                            //                 Colors.white),
                            //       ),
                            //     )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                mapSection(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Maintained By",
                  style: TextStyle(fontSize: 18, color: primary),
                ),
                SizedBox(
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${widget.data.data.branches.organizationImage}",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.data.data.branches.organizationName}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      height: 1.3,
                                      color: textPrimaryColor,
                                      fontSize: 16),
                                ),
                                CompanyDetailsText(
                                  text: '${widget.data.data.branches.category}',
                                ),
                                CompanyDetailsText(
                                  text: '${widget.data.data.branches.location}',
                                ),
                                CompanyDetailsText(
                                  text:
                                      '${widget.data.data.branches.organizationEmail}',
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
                SizedBox(
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
                    child: Container(
                      width: double.infinity,
                      child: Text(
                          "${widget.data.data.branches.organizationDescription}",
                          style:
                              TextStyle(color: textPrimaryColor, fontSize: 14)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (var i = 0;
                        i < widget.data.data.branches.branchImages.length;
                        i++) ...[
                      InkWell(
                        onTap: () {
                          // reviewController.dispose();
                          // complaintController.dispose();
                          SingleImageProvider multiImageProvider =
                              SingleImageProvider(CachedNetworkImageProvider(
                                  '${widget.data.data.branches.branchImages[i]['branch_photos']}'));

                          showImageViewerPager(context, multiImageProvider,
                              onPageChanged: (page) {
                            print("page changed to $page");
                          }, onViewerDismissed: (page) {
                            print("dismissed while on page $page");
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            // border: Border.all(color: primary)
                          ),
                          child: CachedNetworkImage(
                              imageUrl:
                                  '${widget.data.data.branches.branchImages[i]['branch_photos']}',
                              height:
                                  MediaQuery.of(context).size.width / 3 - 11,
                              width: MediaQuery.of(context).size.width / 3 - 11,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => ClipRRect(
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
                      ),
                    ]
                  ],
                ),

                // SizedBox(height: 20,),
//  Text("Images",style: TextStyle(fontSize: 18,color: primary),),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "Rate this toilet",
                  style: TextStyle(fontSize: 18, color: primary),
                ),
                Text(
                  "tell others what you think",
                  style: TextStyle(fontSize: 10, color: textPrimaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                rating(context, 35, 10, (value) {
                  reviewPopup(context, value, widget.data.data.branches.id);
                }, 0),
                SizedBox(
                  height: 20,
                ),

                // ReviewField(hintText: "Review",controller: reviewController,),
//                                             ExpansionTile(title:
//  Text("Complaint",style: TextStyle(fontSize: 18,color: primary),
//  ),children: [
//                                             ReviewField(hintText: "Please enter any complaint",controller: complaintController,),
//  ],
//                                             )
                // ReactiveTextField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  rating(context, double size, double spacing,
      void Function(double) onRatingUpdate, double initialRating) {
    return RatingBar.builder(
      itemSize: size,
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: spacing),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }

  mapSection() {
    double lat = double.parse(widget.data.data.branches.geoLocation.latitude);
    double long = double.parse(widget.data.data.branches.geoLocation.longitude);
    final GalliController controller = GalliController(
        zoom: 18,
        authKey: 'c9c7a4c0-2834-4282-94f7-f4c79c40ab0a',
        initialPosition: LatLng(lat, long));
    return Container(
      height: 300.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Stack(
          children: [
            GalliMap(
              showSearch: false,
              show360Button: false,
              showLocationButton: true,
              //  authKey: "authToken",
              controller: controller,
              //  zoom: 16,
              //  onTap: (tap) {},
              //  circles: [
              //    GalliCircle(
              //        center: LatLng(27.12441, 67.12412),
              //        radius: 32,
              //        color: Colors.white,
              //        borderStroke: 3,
              //        borderColor: Colors.black)
              //  ],
              //  lines: [
              //    GalliLine(
              //        line: [
              //          LatLng(27.12441, 67.12412),
              //          LatLng(27.12441, 67.12412),
              //          LatLng(27.12441, 67.12412),
              //          LatLng(27.12441, 67.12412)
              //        ],
              //        borderColor: Colors.blue,
              //        borderStroke: 1,
              //        lineColor: Colors.white,
              //        lineStroke: 2)
              //  ],
              //  polygons: [
              //    GalliPolygon(polygon: [
              //      LatLng(27.12441, 67.12412),
              //      LatLng(27.12441, 67.12412),
              //      LatLng(27.12441, 67.12412),
              //      LatLng(27.12441, 67.12412)
              //    ], borderColor: Colors.red, borderStroke: 2, color: Colors.green),
              //  ],
              markers: [
                GalliMarker(
                    latlng: LatLng(lat, long),
                    markerWidget: const Icon(
                      Icons.location_on_sharp,
                      color: Colors.red,
                    ))
              ],
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Column(children: [
                GestureDetector(
                  onTap: () async {
                    double lat = double.parse(
                        widget.data.data.branches.geoLocation.latitude);
                    double long = double.parse(
                        widget.data.data.branches.geoLocation.longitude);
                    Position currentPosition =
                        await Geolocator.getCurrentPosition();
                    mapLauncher.MapLauncher.showDirections(
                        origin: mapLauncher.Coords(currentPosition.latitude,
                            currentPosition.longitude),
                        mapType: mapLauncher.MapType.google,
                        destination: mapLauncher.Coords(lat, long));
                    // Get.to(
                    //   Mappage(
                    //         data: snapshot
                    //             .data)
                    //             );
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: white,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/icons/newIcons/location.svg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(width: 10),
                // GestureDetector(
                //   onTap: (){
                //         popUp(context,
                //             data[index]);
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 4.0, horizontal: 1),
                //     decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.circular(10.0),
                //       color: white,
                //     ),
                //     child: SvgPicture.asset(
                //       'assets/images/icons/newIcons/eye.svg',
                //       height: 40,
                //       width: 40,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  reviewPopup(context, double initialRating, int branchId) {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              "Rate this toilet",
              style: TextStyle(fontSize: 18, color: primary),
            )),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                // Positioned(
                //   right: -22.0,
                //   top: -22.0,
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: CircleAvatar(
                //       radius: 10,
                //       child: InkWell(
                //           onTap: () {

                //             Navigator.pop(context);
                //           },
                //           child: Icon(Icons.close,size: 10,)),
                //       backgroundColor: primary,
                //     ),
                //   ),
                // ),
                // Size
                Align(
                  alignment: Alignment.center,
                  heightFactor: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${widget.data.data.branches.organizationImage}",
                            width: 120,
                            height: 120,
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${widget.data.data.branches.organizationName}",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            height: 1.3, color: textPrimaryColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      rating(context, 30, 1, (value) {}, initialRating),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(primary),
                          ),
                          child: Text('SEND'.tr,
                              style: TextStyle(color: textPrimaryLightColor)),
                          onPressed: () {
                            postReview({
                              'branch_id': branchId.toString(),
                              'rating': initialRating.toString(),
                              // 'description':''
                            });
                            EasyLoading.show(status: 'Please wait...'.tr);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  // Set<Marker> placedetail(lat, lng, placename) {
  //   var tmp = Set<Marker>();

  //   tmp.add(
  //     Marker(
  //       markerId: MarkerId(placename),
  //       position: LatLng(lat, lng),
  //       infoWindow: InfoWindow(title: placename),
  //     ),
  //   );

  //   return tmp;
  // }
}

class AvailabilityIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  const AvailabilityIcon({
    Key? key,
    required this.icon,
    this.size = 25,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: white,
            border: Border.all(color: primary)),
        child: SvgPicture.asset(
          "assets/images/icons/$icon",
          color: color ?? primary,
          height: size,
          width: size,
        ));
  }
}

class ReviewField extends StatelessWidget {
  const ReviewField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
        hintText: hintText,
      ),
    );
  }
}

class CompanyDetailsText extends StatelessWidget {
  final String text;
  const CompanyDetailsText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: TextStyle(height: 1.3, color: textPrimaryColor, fontSize: 16),
    );
  }
}
