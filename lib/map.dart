import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/replaceable.dart';

class Mappage extends StatefulWidget {
  @override
  final data;

  Mappage({this.data});

  State<StatefulWidget> createState() {
    return _Mappage();
  }
}

class _Mappage extends State<Mappage> {
  dynamic lat;
  dynamic lng;
  String? address;
  String? wordname;
  int indexvalue = 0;
  dynamic value;
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  MapType currentMapType = MapType.normal;
  BitmapDescriptor? customIcon;
  var allMarkers;

  // static final CameraPosition initCameraPosition;

  List<bool> _buttonsState = List.generate(Config.woda_count, (index) => false);
  @override
  void initState() {
    super.initState();
    setState(() {
      if (this.widget.data.sp_pp_location_latitude == "" ||
          this.widget.data.sp_pp_location_longitude == "") {
        lat = "27.714459";
        lng = "85.42557";
      } else {
        lat = this.widget.data.sp_pp_location_latitude;
        lng = this.widget.data.sp_pp_location_longitude;
      }

      address = this.widget.data.sp_pp_name;
    });

    _buttonsState[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
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
              Text('$address', style: TextStyle(color: primary, fontSize: 22)),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: primary, size: 28)),
            ],
          ),
        ),
      ),
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
              zoom: 15),
          markers: placedetail(double.parse(lat), double.parse(lng), address),

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
