import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';

class DigitalData {
  final String icon;
  final String title;
  final link;
  DigitalData(this.title, this.icon, this.link);
}

final List<DigitalData> digitalData = [
  // DigitalData('TOILETUSE', 'toilet.svg', ToiletgraphPage()),
  // DigitalData('RELIGION', 'prayer.svg', ReligiongraphPage()),
  // DigitalData('HOUSEHOLD', 'home.svg', ToiletgraphPage()),
  // DigitalData('POPULATION', 'population.svg', ToiletgraphPage()),
  // DigitalData('M_LANGUAGE', 'translator.svg', ToiletgraphPage()),
  // DigitalData('LITERACY', 'literacy.svg', ToiletgraphPage()),
  // DigitalData('ELECTRICITY', 'electricity.svg', ToiletgraphPage()),
  // DigitalData('WATERUSE', 'tap.svg', ToiletgraphPage()),
  // DigitalData('FUELUSE', 'fire.svg', ToiletgraphPage()),
  // DigitalData('ROAD', 'road.svg', ToiletgraphPage()),
  // DigitalData('AGE', 'age),
  // DigitalData('FAMILY_MEMBERS', 'family),
];

// class SpGrid extends StatelessWidget {
//   const SpGrid({Key key, this.homeData}) : super(key: key);

//   final HomeData homeData;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         elevation: 0,
//         margin: EdgeInsets.all(0),
//         color: Colors.white,
//         child: Container(
//             height: 50,
//             child: SingleChildScrollView(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       homeData.icon,
//                       size: 35.0,
//                       color: primary,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text( homeData.title),
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             height: 1.3,
//                             color: textPrimaryColor,
//                             fontSize: 12.5)),
//                   ]),
//             )));
//   }
// }

// class SpGridJankari extends StatelessWidget {
//   const SpGridJankari({Key key, this.jankariData}) : super(key: key);

//   final JankariData jankariData;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         elevation: 0,
//         margin: EdgeInsets.all(0),
//         color: Colors.white,
//         child: Container(
//             height: 50,
//             child: SingleChildScrollView(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       jankariData.icon,
//                       size: 35.0,
//                       color: primary,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text( jankariData.title),
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             height: 1.3,
//                             color: textPrimaryColor,
//                             fontSize: 12.5)),
//                   ]),
//             )));
//   }
// }

class SpGridDigital extends StatelessWidget {
  const SpGridDigital({Key? key, this.digitalData}) : super(key: key);

  final DigitalData? digitalData;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: Container(
            height: 50,
            child: GestureDetector(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: SvgPicture.asset(
                          digitalData!.icon,
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Icon(
                      //   digitalData.icon,
                      //   size: 35.0,
                      //   color: primary,
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${digitalData?.title}'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.3,
                              color: textPrimaryColor,
                              fontSize: 12.5)),
                    ]),
              ),
            )));
  }
}
