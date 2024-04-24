import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/bibhag/upasakha/upasakhahome.dart';

class UpaSakha extends StatefulWidget {
  const UpaSakha({Key? key, this.data}) : super(key: key);

  final data;

  @override
  _UpaSakhaState createState() => _UpaSakhaState();
}

class _UpaSakhaState extends State<UpaSakha> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: Get.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.data['data'].length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Get.to(Upasakhahome(data: widget.data['data'][i]));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.data['data'][i]
                                            ['icon'],
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 35,
                                          height: 35,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: tertiary,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            'assets/images/Grey_Placeholder.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          backgroundImage: imageProvider,
                                        ),
                                      )

                                      // SvgPicture.asset(
                                      //   'assets/images/icons/newIcons/upasakha.svg',
                                      //   height: 35,
                                      //   width: 35,
                                      //   fit: BoxFit.contain,
                                      // ),
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(widget.data['data'][i]['name'],
                                      maxLines: 2,
                                      style: TextStyle(
                                          height: 1.3,
                                          color: textPrimaryColor,
                                          fontSize: 16)),
                                )),
                          ],
                        ),
                      );
                    }),
              )),
        )
      ],
    );
  }
}
