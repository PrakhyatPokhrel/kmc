import 'package:flutter/material.dart';
import 'package:kmc/pages/sewa/sewadata.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/sifarish_card.dart';

class SifarishGridView extends StatelessWidget {
  const SifarishGridView({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // childAspectRatio: constraints.maxHeight / constraints.maxWidth,
            // childAspectRatio: constraints.maxWidth >= 500 ? 3 / 2 : 1.05,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 12,
            mainAxisExtent: 150,
          ),
          itemCount: sifarishInsideDataModel.length,
          itemBuilder: (context, index) => SifarishCard(
            sifarishData: sifarishInsideDataModel[index],
          ),
        );
      },
    );
  }
}
