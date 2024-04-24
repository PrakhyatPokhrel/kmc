import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kmc/config/colors.dart';

class MappageEmergency extends StatefulWidget {
  @override
  final data;
  MappageEmergency({this.data});

  State<StatefulWidget> createState() {
    return _MappageEmergencyState(data: this.data);
  }
}

class _MappageEmergencyState extends State<MappageEmergency> {
  final data;
  _MappageEmergencyState({this.data});
  dynamic lat = "27.714459";
  dynamic lng = "85.42557";
  String? address;
  String? wordname;
  int? indexvalue = 0;
  dynamic value;
  Completer<GoogleMapController>? _controller = Completer();
  final Set<Marker>? listMarkers = {};
  MapType? currentMapType = MapType.normal;
  BitmapDescriptor? customIcon;
  var allMarkers;

  // static final CameraPosition initCameraPosition;

  List<bool> _buttonsState = List.generate(6, (index) => false);
  @override
  void initState() {
    super.initState();
    setState(() {
      if (this.data.location_lati != null) {
        lat = this.data.location_lati;

        lng = this.data.location_long;
        address = this.data.name;
      }
    });

    _buttonsState[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: primary,
          title: Text(
            address!,
          )),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
          //mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              bearing: 30,
              target: LatLng(double.parse(lat), double.parse(lng)),
              tilt: 45,
              zoom: 12.5),
          markers: placedetail(double.parse(lat), double.parse(lng), address),

          onMapCreated: (GoogleMapController controller) {
            _controller?.complete(controller);
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
    ));
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
