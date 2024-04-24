import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../config/Apiconnectservices.dart';
import '../../../modal/newsnoticemodalwordpress.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  fetchNews()async{
    try{
      emit(NewsInitial());
      var res = await wordpressApi();
      emit(NewsFetched(model: res));
    }catch(e){
      var status =await Connectivity().checkConnectivity();
      if(status == ConnectivityResult.none){
        emit(NewsFetchError(error: "no_internet_connection".tr));
      }
      else{
        emit(NewsFetchError(error: "server_error".tr));
      }
    }
  }
}
