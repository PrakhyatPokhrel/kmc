import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kmc/components/custom_appbar.dart';
import 'package:kmc/components/custom_button.dart';
import 'package:kmc/components/custom_empty_card.dart';
import 'package:kmc/components/custom_error_card.dart';
import 'package:kmc/components/custom_spinner.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_form_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_form_cubit/sifarish_form_cubit.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_cubit.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/sifarish_description.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_form_screen.dart';

enum SifarishTypeEnum {
  nagarikta,
  gharJaggaBato,
  upabhokta,
  panjikaran,
  kar,
  anya,
  all
}

class SifarishListScreen extends StatelessWidget {
  const SifarishListScreen({
    Key? key,
    required this.sifarishTypeEnum,
  }) : super(key: key);
  final SifarishTypeEnum sifarishTypeEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'sifaris'.tr),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<SifarishListCubit>(context).refreshSifarish();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: <Widget>[
              SifarishDescription(),
              Expanded(
                child: BlocBuilder<SifarishListCubit, SifarishState>(
                  builder: (context, state) {
                    if (state is SifarishFetching) {
                      return CustomSpinner();
                    } else if (state is SifarishFetchFailure) {
                      return CustomErrorCard(
                        message: state.exception.message,
                      );
                    } else if (state is SifarishFetchSuccess) {
                      List<SifarishFormModel> sifarishFormList =
                          state.sifarishFormList;
                      return Column(
                        children: [
                          if (state.showLanguageButton)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  title: 'nepali'.tr,
                                  onPressed: () {
                                    if (!state.showEnglish) {
                                      return;
                                    }
                                    BlocProvider.of<SifarishListCubit>(context)
                                        .changeLanguage();
                                  },
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CustomButton(
                                  title: "ENGLISH".tr,
                                  onPressed: () {
                                    if (state.showEnglish) {
                                      return;
                                    }
                                    BlocProvider.of<SifarishListCubit>(context)
                                        .changeLanguage();
                                  },
                                ),
                              ],
                            ),
                          sifarishFormList.isEmpty
                              ? CustomEmptyCard()
                              : Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 30),
                                    itemCount: sifarishFormList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var sifarishForm =
                                          sifarishFormList[index];
                                      return Card(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 4),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            BlocProvider.of<SifarishFormCubit>(
                                                    context)
                                                .selectSifarish(sifarishForm);
                                            Get.to(() => SifarishFormScreen());
                                          },
                                          title: Text(
                                            sifarishForm.formName,
                                            style: TextStyle(
                                                fontSize: 18, color: primary),
                                          ),
                                          trailing: Icon(
                                              Icons.chevron_right_rounded,
                                              color: primary),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
