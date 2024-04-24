import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final String? imgUrl;
  const MyCircleAvatar({
    Key? key,
    @required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.3),
                offset: Offset(0, 2),
                blurRadius: 5)
          ],
        ),
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                "$imgUrl",
              ),
            ),
          ),
        )

        // CircleAvatar(
        //   backgroundImage: CachedNetworkImage(imageUrl: "$imgUrl"),
        // ),
        );
  }
}
