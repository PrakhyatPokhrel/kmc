import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/bibhag/sewaharu/sewahome.dart';

class Sewaharu extends StatefulWidget {
  const Sewaharu({Key? key, this.data}) : super(key: key);

  final data;

  @override
  _SewaharuState createState() => _SewaharuState();
}

class _SewaharuState extends State<Sewaharu> {
  List bibhag_services = [];
  List organization_services = [];
  List? services;
  @override
  void initState() {
    super.initState();

    setState(() {
      // services = new List.from(bibhag_services)..addAll(organization_services);
      // [bibhag_services, organization_services].expand((x) => x).toList();
      services = widget.data['bibhag_services'];
      bibhag_services.addAll(services!);
    });
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
            child: services!.length == 0
                ? Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 48,
                      ),
                      child: Center(
                        child: Text(
                          'हाललाई कुनै सेवा/सुविधाहरू फेला परेन।',
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
                      height: Get.height * 0.50,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: services!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                Get.to(SewaHome(data: services?[i]));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    services?[i]['icon'] != null
                                        ? Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                elevation: 0,
                                                color: Colors.white,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: CachedNetworkImage(
                                                      imageUrl: services?[i]
                                                          ['icon'],
                                                      width: 35,
                                                      height: 35,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        width: 35,
                                                        height: 35,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                primary,
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        child: Image.asset(
                                                          'assets/images/Grey_Placeholder.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      // imageBuilder:
                                                      //     (context, imageProvider) =>
                                                      //         CircleAvatar(
                                                      //   backgroundImage: imageProvider,
                                                      // ),
                                                    )),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Expanded(
                                        flex: 7,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(services?[i]['name'],
                                              maxLines: 2,
                                              style: TextStyle(
                                                  height: 1.3,
                                                  color: textPrimaryColor,
                                                  fontSize: 16)),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ))
      ],
    );
  }

  grid(data) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        child: Container(
            height: 50,
            child: GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            data.icon,
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${data.title}'.tr,
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
