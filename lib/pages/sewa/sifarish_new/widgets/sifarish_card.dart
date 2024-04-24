import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kmc/config/colors.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/sewa/sewadata.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_list_screen.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_cubit.dart';

class SifarishCard extends StatelessWidget {
  const SifarishCard({
    Key? key,
    required this.sifarishData,
  }) : super(key: key);

  final StaticSifarishDataModel sifarishData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          BlocProvider.of<SifarishListCubit>(context)
              .getSifarishByType(sifarishData.sifarishTypeEnum);
          Get.to(
            () => SifarishListScreen(
              sifarishTypeEnum: sifarishData.sifarishTypeEnum,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              sifarishData.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                sifarishData.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.3,
                  color: textPrimaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
