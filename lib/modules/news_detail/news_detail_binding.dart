import 'package:get/get.dart';

import 'news_detail_controller.dart';
class NewDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewDetailsController());
  }
}