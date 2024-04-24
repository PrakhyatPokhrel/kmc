import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kmc/components/custom_exception.dart';
import 'package:kmc/pages/sewa/api_service/sifarish_api_service.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_form_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_model.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_list_screen.dart';
part 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_state.dart';

class SifarishListCubit extends Cubit<SifarishState> {
  SifarishListCubit() : super(SifarishInitial());
  UnmodifiableListView<SifarishModel>? globalSifarishList;
  bool showEnglish = false;
  late SifarishTypeEnum selectedSifarishTypeEnum;

  FutureOr<void> _fetch() async {
    try {
      globalSifarishList =
          UnmodifiableListView(await SifarishApiService.getSifarishList());
      _filterSifarish();
    } on CustomException catch (e) {
      emit(SifarishFetchFailure(e));
    }
  }

  FutureOr<void> getSifarishByType(SifarishTypeEnum sifarishTypeEnum) async {
    emit(SifarishFetching());
    selectedSifarishTypeEnum = sifarishTypeEnum;
    showEnglish = false;
    _filterSifarish();
  }

  FutureOr<void> refreshSifarish() async {
    emit(SifarishFetching());
    _fetch();
  }

  FutureOr<void> changeLanguage() async {
    emit(SifarishFetching());
    showEnglish = !showEnglish;
    _filterSifarish();
  }

  FutureOr<void> _filterSifarish() async {
    if (globalSifarishList != null) {
      var res =
          _filterByCategory(selectedSifarishTypeEnum, globalSifarishList!);
      bool showLanguageButton =
          res.where((item) => item.isEnglish).isNotEmpty &&
              res.where((item) => !item.isEnglish).isNotEmpty;
      if (showLanguageButton) {
        res =
            res.where((sifarish) => sifarish.isEnglish == showEnglish).toList();
      }

      emit(SifarishFetchSuccess(
        sifarishFormList: res,
        showEnglish: showEnglish,
        showLanguageButton: showLanguageButton,
      ));
      return;
    }
    _fetch();
  }

  List<SifarishFormModel> _filterByCategory(
      SifarishTypeEnum sifarishTypeEnum, List<SifarishModel> sifarishList) {
    try {
      switch (sifarishTypeEnum) {
        case SifarishTypeEnum.nagarikta:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "नागरिकता सम्बन्धि  सिफारिस");
        case SifarishTypeEnum.gharJaggaBato:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "घर/जग्गा /बाटो सम्बन्धि सिफारिस");
        case SifarishTypeEnum.upabhokta:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "उपभोक्ता");
        case SifarishTypeEnum.panjikaran:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "पंञ्जिकरण");
        case SifarishTypeEnum.kar:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "कर सम्बन्धि सिफारिस");
        case SifarishTypeEnum.anya:
          return filterSifarishFormByCategoryName(sifarishList,
              categoryName: "अन्य");
        case SifarishTypeEnum.all:
          List<SifarishFormModel> allsifarishList = [];
          for (var sifarish in sifarishList) {
            for (var sifarishForm in sifarish.forms) {
              allsifarishList.add(sifarishForm);
            }
          }
          return allsifarishList;
        default:
          return [];
      }
    } catch (e) {
      return [];
    }
  }

  static List<SifarishFormModel> filterSifarishFormByCategoryName(
      List<SifarishModel> sifarishModel,
      {required String categoryName}) {
    return sifarishModel
        .firstWhere((sifarish) => sifarish.categoryName == categoryName)
        .forms;
  }
}
