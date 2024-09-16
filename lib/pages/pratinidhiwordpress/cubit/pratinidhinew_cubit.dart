import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:kmc/pages/pratinidhiwordpress/model.dart';

part 'pratinidhinew_state.dart';

class PratinidhinewCubit extends Cubit<PratinidhinewState> {
  PratinidhinewCubit() : super(PratinidhinewInitial());
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  Dio _dio =
      Dio(); //*dio chai cache ma api lai rakhna use gareko navaye http hunxa
  pratinidhiWordpressApi() async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      emit(PratinidhinewLoading());
      var response = await _dio.get(
          'https://kathmandu.gov.np/api/elected-officials-api',
          options: buildCacheOptions(Duration(days: 30), forceRefresh: true));
      var list = List<PratinidhiModelWordpress>.from(
          response.data.map((x) => PratinidhiModelWordpress.fromMap(x)));
      emit(PratinidhinewLoaded(list));
    } catch (e) {
    var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        emit(PratinidhinewError("no_internet_connection".tr));
      }else{
        emit(PratinidhinewError("server_error".tr));
      }
    } 
  }
}
