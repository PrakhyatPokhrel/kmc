import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_list_screen.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_cubit.dart';

class AllSifarishButton extends StatelessWidget {
  const AllSifarishButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(Get.width - 64, 60)),
        backgroundColor: MaterialStateProperty.all(tertiary),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'Viewall_sifarish'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, color: textPrimaryLightColor),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.arrow_forward_rounded, color: textPrimaryLightColor)
        ],
      ),
      onPressed: () {
        BlocProvider.of<SifarishListCubit>(context).getSifarishByType(SifarishTypeEnum.all);
        Get.to(
          SifarishListScreen(
            sifarishTypeEnum: SifarishTypeEnum.all,
          ),
        );
      },
    );
  }
}
