import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/bibhag/sanstha/sansthahome.dart';

class Sanstha extends StatefulWidget {
  const Sanstha({Key? key, this.data}) : super(key: key);

  final data;

  @override
  _SansthaState createState() => _SansthaState();
}

class _SansthaState extends State<Sanstha> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 0,
            color: Colors.white,
            child: widget.data['data'].length == 0
                ? Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 48,
                      ),
                      child: Center(
                        child: Text(
                          'हाललाई कुनै संस्था फेला परेन।',
                          style: TextStyle(
                            fontSize: 18,
                            color: text,
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: Get.height * 0.15 * widget.data['data'].length,
                      child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          childAspectRatio: 0.68,
                          crossAxisCount: 3,
                          children: List.generate(widget.data['data'].length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: grid(widget.data['data'][index]),
                            );
                          })),
                    ),
                  ),

            // ListView.builder(
            //   itemCount: widget.data['events'].length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(
            //           flex: 3,
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //             child: Card(
            //               shape: RoundedRectangleBorder(
            //                 side: BorderSide(
            //                   color: Colors.grey,
            //                   width: 0.5,
            //                 ),
            //                 borderRadius: BorderRadius.circular(20.0),
            //               ),
            //               elevation: 0,
            //               color: Colors.white,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(16),
            //                 child: SvgPicture.asset(
            //                   'assets/images/icons/newIcons/upasakha.svg',
            //                   height: 35,
            //                   width: 35,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //             flex: 7,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //               child: Text('बाल विकास केन्द्र',
            //                   maxLines: 2,
            //                   style: TextStyle(
            //                       height: 1.3,
            //                       color: textPrimaryColor,
            //                       fontSize: 16)),
            //             )),
            //       ],
            //     ),
            //   );
            //   }),
          ),

// Sanstha ma yo design milyo vane yo uncomment garera future builder halne and mathiko comment garne
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //     height: 270,
          //     child: GridView.count(
          //         physics: NeverScrollableScrollPhysics(),
          //         primary: false,
          //         childAspectRatio: 1,
          //         crossAxisCount: 3,
          //         children: List.generate(gridData.length, (index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: grid(gridData[index]),
          //           );
          //         })),
          //   ),
          // ),
        ],
      ),
    );
  }

  grid(data) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () {
            Get.to(SansthaHome(data: data));
          },
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: Get.width),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: CachedNetworkImage(
                          width: Get.width,
                          height: 50,
                          fit: BoxFit.cover,
                          imageUrl: data['icon'] != null ? data['icon'] : "",
                          placeholder: (context, url) => Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'assets/images/Grey_Placeholder.png',
                              width: Get.width,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // imageBuilder: (context, imageProvider) =>
                          //     CircleAvatar(
                          //   backgroundImage: imageProvider,
                          // ),
                        )

                        // SvgPicture.asset(
                        //   data.icon,
                        //   height: 35,
                        //   width: 35,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(data['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.1,
                          color: textPrimaryColor,
                          fontSize: 12.5)),
                ]),
          ),
        ));
  }
}
