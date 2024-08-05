import 'package:flutter/material.dart';
import 'package:galli_map/galli_map.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/modal/nearby_places_model.dart';

class AllToiletMapPage extends StatelessWidget {
  const AllToiletMapPage({Key? key, required this.latLng, required this.getToilet}) : super(key: key);
  final LatLng latLng;
  final List<NearbyToiletsModel> getToilet;

  @override
  Widget build(BuildContext context) {
    final GalliController controller = GalliController(zoom: 15.8,authKey: 'c9c7a4c0-2834-4282-94f7-f4c79c40ab0a',initialPosition: latLng);
    return  SafeArea(
      child: Stack(
        children: [
         
          GalliMap(
            showSearch: false,
            show360Button: false,
            controller: controller,
          circles: [
            GalliCircle(center: latLng, radius: 400,color: primary.withOpacity(0.2),borderColor: primary),
          ],
          markers: [
            for(var i=0;i<getToilet.length;i++)...[
              GalliMarker(latlng: LatLng(double.parse(getToilet[i].latitude), double.parse(getToilet[i].longitude)),markerWidget: InkWell(
                onTap: (){
                  
                },
                child: Icon(Icons.location_on,size: 30,color: primary,)))
            ]
          ],
          ),
           Positioned(
                    right:10,
                    top: 10,
                    child: InkWell(
              onTap: 
                  () {
                    Navigator.pop(context);
                  },
              child: Icon(
                Icons.arrow_back,
                color: primary,
                size: 28,
              ),
            ),
                  ),
        ],
      ),
    );
  }
}