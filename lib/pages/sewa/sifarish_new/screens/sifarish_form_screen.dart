import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kmc/components/custom_appbar.dart';
import 'package:kmc/components/custom_button.dart';
import 'package:kmc/components/custom_dialog.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_form_cubit/sifarish_form_cubit.dart';
import 'package:kmc/pages/sewa/sifarish_new/widgets/sifarish_form_list.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/sifarish_failure_dialog.dart';
import '../widgets/sifarish_success_dialog.dart';

class StepData {
  StepData({
    required this.title,
    required this.content,
  });
  final String title;
  final Widget content;
}

class SifarishFormScreen extends StatefulWidget {
  const SifarishFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SifarishFormScreen> createState() => _SifarishFormScreenState();
}

bool isLoading = false;

class _SifarishFormScreenState extends State<SifarishFormScreen> {
  dynamic token;
  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    // //print(token);
  }

  getDataID() async {
    setState(() {
      isLoading = true;
    });
    var pref = await SharedPreferences.getInstance();
    var successIds = await pref.getInt("successEntryId");
    print("successIds: $successIds");

    sifarishCompleteapi(successIds) async {
      print("insidefunction: $successIds");
      _dio.options.headers = _setHeaders();
      try {
        var data = await _dio.post(
            '${BASE_URL}/sifarish/api/submit-sifarish/${successIds}',
            options: _cacheOptions);
        setState(() {
          isLoading = false;
        });
        if (data.statusCode == 200) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SifarishSuccessDialog(),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SifarishFailureDialog(),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SifarishFailureDialog(),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    sifarishCompleteapi(successIds);
  }

  Map<String, String> _setHeaders() => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getToken();
  }

  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  Options _cacheOptions =
      buildCacheOptions(Duration(days: 30), forceRefresh: true);
  Dio _dio = Dio();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popMethod,
      child: Scaffold(
        appBar: CustomAppBar(
          child: BlocBuilder<SifarishFormCubit, SifarishFormState>(
              buildWhen: (previous, current) =>
                  current is SifarishBuildFormState,
              builder: (context, state) {
                if (state is SifarishBuildFormState) {
                  return Text(
                    state.title,
                    style: TextStyle(color: primary, fontSize: 22),
                  );
                } else {
                  return SizedBox();
                }
              }),
          onBackPressed: popMethod,
        ),
        body: BlocConsumer<SifarishFormCubit, SifarishFormState>(
          listenWhen: (previous, current) =>
              (current is SifarishSubmissionErrorState ||
                  current is SifarishFormCompletedState),
          listener: ((context, state) {
            if (state is SifarishSubmissionErrorState) {
              EasyLoading.showError(
                state.message,
                duration: Duration(seconds: 2),
              );
            } else if (state is SifarishFormCompletedState) {
              getDataID();
            }
          }),
          buildWhen: (previous, current) => current is SifarishBuildFormState,
          builder: (context, state) {
            if (state is SifarishBuildFormState) {
              FormGroup formGroup = state.formGroup;
              int currentStep = state.currentStep;
              List<StepData> stepDataList = [
                StepData(
                  title: 'व्यक्तिगत विवरण',
                  content: state.currentStep == 0
                      ? SifarishFormList(
                          formGroup: formGroup,
                          sifarishFields: state.sifarishFields,
                        )
                      : SizedBox(),
                ),
                StepData(
                  title: 'कागजात',
                  content: state.currentStep == 1
                      ? SifarishFormList(
                          formGroup: formGroup,
                          sifarishFields: state.sifarishDocuments,
                        )
                      : SizedBox(),
                ),
              ];
              return Theme(
                data: ThemeData(
                  shadowColor: Colors.transparent,
                  colorScheme: ColorScheme.light(primary: tertiary).copyWith(
                    secondary: tertiary,
                  ),
                ),
                child: Stepper(
                    physics: ClampingScrollPhysics(),
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    steps: <Step>[
                      for (int stepIndex = 0;
                          stepIndex < stepDataList.length;
                          stepIndex++)
                        Step(
                          title: Text(
                            stepDataList[stepIndex].title,
                            style: TextStyle(
                              color: (currentStep >= stepIndex)
                                  ? tertiary
                                  : Colors.grey,
                            ),
                          ),
                          isActive: (currentStep >= stepIndex) ? true : false,
                          state: (currentStep > stepIndex)
                              ? StepState.complete
                              : (currentStep == stepIndex)
                                  ? StepState.editing
                                  : StepState.disabled,
                          content: stepDataList[stepIndex].content,
                        ),
                    ],
                    type: StepperType.horizontal,
                    currentStep: currentStep,
                    // onStepTapped: (step) {
                    //   setState(() {
                    //     currentStep = step;
                    //   });
                    // },
                    onStepContinue: () async {
                      {
                        // Byatigat Bibaran section
                        if (currentStep == 0) {
                          if (formGroup.valid) {
                            EasyLoading.show(status: 'Please wait...'.tr);
                            if (state.isChildSifarish) {
                              await BlocProvider.of<SifarishFormCubit>(context)
                                  .submitChildSifarishFields(formGroup, state);
                            } else {
                              await BlocProvider.of<SifarishFormCubit>(context)
                                  .submitSifarishFields(formGroup, state);
                            }

                            EasyLoading.dismiss();
                          } else {
                            EasyLoading.showInfo(
                              'required_fields'.tr,
                              duration: Duration(
                                milliseconds: 2000,
                              ),
                            );
                          }
                          return;
                        }
                        // Doc Section
                        if (currentStep == 1) {
                          BlocProvider.of<SifarishFormCubit>(context)
                              .submitSifarishDocuments(
                                  formGroup, state.sifarishDocuments);

                          return;
                        }
                      }
                    },
                    controlsBuilder: (context, controlBuilders) {
                      return isLoading == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 60),
                              child: SizedBox(
                                width: Get.width * 0.86,
                                child: ElevatedButton.icon(
                                  onPressed: controlBuilders.onStepContinue,
                                  icon: Icon(Icons.upload),
                                  label: Text('SEND'.tr),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(child: CircularProgressIndicator());
                    }),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Future<bool> popMethod() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomAlertDialog(
        title: 'दर्ता रद्द',
        description:
            "तपाईंका सबै भरिएका फिल्ड मानहरू हटाइनेछन्। तपाईं जारी राख्न निश्चित हुनुहुन्छ",
        actions: [
          CustomButton(
            title: 'ठिक छ',
            onPressed: () {
              BlocProvider.of<SifarishFormCubit>(context).refreshFields();
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}
