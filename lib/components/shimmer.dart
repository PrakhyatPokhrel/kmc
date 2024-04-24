import 'package:kmc/components/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget();

  buildMovieShimmer() => this;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              CustomWidget.rectangular(height: 25),
              SizedBox(
                height: 24,
              ),
            ],
          );
        },
      ),
    );
  }
}
