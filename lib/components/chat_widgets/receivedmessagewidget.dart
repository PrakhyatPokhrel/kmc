import 'package:cached_network_image/cached_network_image.dart';
import 'package:kmc/components/chat_widgets/imageviewer.dart';
import 'package:kmc/config/url.dart';
// import 'package:kmc/pages/hellomayor/chatData.dart';
import 'package:kmc/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mycircleavatar.dart';

class ReceivedMessagesWidget extends StatelessWidget {
  final dynamic data;
  final image = 1;
  const ReceivedMessagesWidget({
    Key? key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          MyCircleAvatar(
            imgUrl: data['userimage'],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${data['sender_name']}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: data['image'] != null
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xfff9f9f9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: data['image'] != null
                    ? Container(
                        height: 150,
                        width: 150,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                ImageViewer("$chatimageurl${data['image']}"));

                            // showDialog(
                            //   context: context,
                            //   builder: (context) => Container(
                            //     height: 500.0,
                            //     width: Get.width,
                            //     color: Colors.grey[100],
                            //     child: CachedNetworkImage(
                            //       imageUrl: "$chatimageurl${data['image']}",

                            //       fit: BoxFit.fill,
                            //       errorWidget: (context, url, error) =>
                            //           ClipRRect(
                            //         borderRadius: BorderRadius.circular(50.0),
                            //         child: Image.asset(
                            //           'assets/images/Grey_Placeholder.png',
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //       // imageBuilder:
                            //       //     (context, imageProvider) =>
                            //       //         CircleAvatar(
                            //       //   backgroundImage: imageProvider,
                            //       // ),
                            //     ),
                            //   ),
                            // );
                          },
                          child: CachedNetworkImage(
                            imageUrl: "$chatimageurl${data['image']}",
                            height: 180,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: CircularProgressIndicator(
                                backgroundColor: primary,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        "${data['message']}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.black87, fontSizeFactor: 1.1),
                      ),
              ),
            ],
          ),
          SizedBox(width: 15),
          // Text(
          //   "${data['nepali_timestamp']}",
          //   style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
          // ),
        ],
      ),
    );
  }
}
