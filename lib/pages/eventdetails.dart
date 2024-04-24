import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class EventDetails extends StatefulWidget {
  final data;
  EventDetails({this.data});
  @override
  _EventDetailsState createState() => _EventDetailsState(this.data);
}

class _EventDetailsState extends State<EventDetails> {
  final data;
  _EventDetailsState(this.data);
  var lat;
  var lng;
  String? address;
  String? wordname;
  int? indexvalue = 0;
  dynamic value;
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  MapType? currentMapType = MapType.normal;
  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
    setState(() {
      lat = "85.4016892";

      lng = "85.4016892";
      address = " काठमाडौँ";
    });
  }

  final _imageUrls = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(backgroundColor: primary, title: Text('event_details'.tr)),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Card(
                    elevation: 0,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    borderOnForeground: true,
                    child: Container(
                        // height: 330,
                        // width: MediaQuery.of(context).size.width,
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(this.data['name'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: primary,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          CachedNetworkImage(
                            imageUrl: '${this.data['cover_image']}',
                            height: 180,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/Grey_Placeholder.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                eventText(Icons.watch_later_outlined, 'time'.tr,
                                    this.data['time']),
                                eventText(Icons.calendar_today_outlined,
                                    'date'.tr, this.data['date']),
                                eventText(Icons.location_on, 'place'.tr,
                                    '${this.data['location_name']}'),
                              ]),
                        ],
                      ),
                    ))),
                googlemap(),
                this.data['eventimages'].length != 0
                    ? Container(
                        child: CarouselSlider.builder(
                        itemCount: this.data['eventimages'].length ?? 0,
                        itemBuilder: (context, index, i) => Container(
                          child: CachedNetworkImage(
                            imageUrl:
                                '${this.data['eventimages'][index]['image_url']}',
                            height: 180,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/Grey_Placeholder.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          height: 150.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                          aspectRatio: 2.0,
                          initialPage: 2,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 2000),
                          scrollDirection: Axis.horizontal,
                        ),
                      ))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  eventText(icon, title, data) {
    return Row(children: [
      Icon(icon, color: text, size: 20),
      SizedBox(width: 10),
      Text(title + ': ',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, height: 1.5)),
      Text(data ?? '',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: primary)),
    ]);
  }

  Widget googlemap() {
    return Container(
      height: 260.0,
      child: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        //mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            bearing: 30,
            target: LatLng(
                double.parse(data['location_latitudes'] != null
                    ? lat
                    : data['location_latitudes']),
                double.parse(data['location_longitude'] != null
                    ? lat
                    : data['location_longitude'])),
            tilt: 45,
            zoom: 12.5),
        markers: placedetail(
            double.parse(data['location_latitudes'] != null
                ? lat
                : data['location_latitudes']),
            double.parse(data['location_longitude'] != null
                ? lat
                : data['location_longitude']),
            data['location_name'] != null ? data['location_name'] : address),

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
    );
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/pin.png');
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
}
