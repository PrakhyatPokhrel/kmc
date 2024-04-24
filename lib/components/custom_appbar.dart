import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final String? title;

  CustomAppBar({
    this.child,
    this.onBackPressed,
    this.title,
  });
  final void Function()? onBackPressed;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: child != null
                    ? child!
                    : Text(
                        title ?? "",
                        style: TextStyle(color: primary, fontSize: 22),
                      )),
            InkWell(
              onTap: onBackPressed ??
                  () {
                    Navigator.pop(context);
                  },
              child: Icon(
                Icons.arrow_back,
                color: primary,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
