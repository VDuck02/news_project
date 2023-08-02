import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_sceen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

  ];
}