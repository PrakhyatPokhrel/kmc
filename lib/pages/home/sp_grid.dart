import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class SpGrid extends StatelessWidget {
  const SpGrid({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            if (data.title == "yojana") {
              notAvailable(context);
            } else if (data.title == "") {
              //prayatak_sthal disable
              notAvailable(context);
            } else if (data.title == "byapar") {
              notAvailable(context);
            } else {
              Get.to(data.link);
            }
          },
          child: Container(
              alignment: Alignment.center,
              height: 50,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        data.icon,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '${data.title}'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.5,
                          color: textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              )),
        ));
  }

  Future<dynamic> notAvailable(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('service_not_available'.tr,
                textAlign: TextAlign.center, style: TextStyle(color: primary)),
            // content: Text('login_alert'.tr,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 16, height: 1.5)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(tertiary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text('cancel'.tr),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.back();
                  },
                ),
              ),
            ],
          );
        });
  }
}
