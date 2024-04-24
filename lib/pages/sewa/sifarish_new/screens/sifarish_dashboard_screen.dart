import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/components/custom_appbar.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/all_sifarish_button.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/sifarish_description.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/sifarish_grid_view.dart';

class SifarishDashboardScreen extends StatelessWidget {
  const SifarishDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'sifaris'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SifarishDescription(),
            SizedBox(height: 12),
            Expanded(
              child: SifarishGridView(context: context),
            ),
            AllSifarishButton(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
