import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class SewaCard extends StatelessWidget {
  const SewaCard({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.width * 0.33,
            // width: MediaQuery.of(context).size.width * 0.6,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  data.icon,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.title}'.tr,
                        style: TextStyle(
                            height: 1.3,
                            color: textPrimaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    Text('${data.details}'.tr,
                        style: TextStyle(
                            height: 1.2,
                            color: textPrimaryColor,
                            fontSize: 12)),
                  ],
                ),
              ),
            ])));
  }
}
