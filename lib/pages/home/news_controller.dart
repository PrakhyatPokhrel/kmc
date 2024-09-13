import 'package:get/get.dart';

import '../../config/Apiconnectservices.dart';
import '../../modal/newsnoticemodalwordpress.dart';

class NewsController extends GetxController {
  var news = <NewsNoticeModelWordpress>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews() async {
    news.value = await wordpressApi();
    isLoading.value = false;
  }
}
