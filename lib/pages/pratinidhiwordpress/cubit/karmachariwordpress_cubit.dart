import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:equatable/equatable.dart';
import 'package:kmc/pages/pratinidhiwordpress/model.dart';

part 'karmachariwordpress_state.dart';

class KarmachariwordpressCubit extends Cubit<KarmachariwordpressState> {
  KarmachariwordpressCubit() : super(KarmachariwordpressInitial());
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  Dio _dio =
      Dio(); //*dio chai cache ma api lai rakhna use gareko navaye http hunxa
  karmachariWordpressApi() async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      emit(KarmachariwordpressLoading());
      var response = await _dio.get('https://kathmandu.gov.np/api/staff-api',
          options: buildCacheOptions(Duration(days: 30), forceRefresh: true));
      // var a = response.data['data'];
      // print(a);
      // var newMap = groupBy(response.data, (Map obj) => obj['Designation']);

      // print(newMap);
      var list = List<PratinidhiModelWordpress>.from(
          response.data.map((x) => PratinidhiModelWordpress.fromMap(x)));
      emit(KarmachariwordpressLoaded(list));
    } catch (e) {
      print(e);
      emit(KarmachariwordpressError('Unexpected Error Occured'));
    }
  }
}
