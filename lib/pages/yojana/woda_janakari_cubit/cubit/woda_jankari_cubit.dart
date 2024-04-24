import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../config/Apiconnectservices.dart';
import '../../../../config/url.dart';
import '../../../../modal/wodajanakari.dart';

part 'woda_jankari_state.dart';

class WodaJankariCubit extends Cubit<WodaJankariState> {
  WodaJankariCubit() : super(WodaJankariInitial());
  fetch() async {
    try{
       emit(WodaJankariLoading());
    var wodajanakari = await wodaJanakariApi();
    emit(WodaJankariFetched(wodajanakari));
    }catch(e){
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        emit(WodaJankariFailure(error: "no_internet_connection".tr));
      }else{
        emit(WodaJankariFailure(error: "server_error".tr));
      }
      
    }
   
  }
}
