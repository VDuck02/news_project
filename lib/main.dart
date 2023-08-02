import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projectv1/routes/app_pages.dart';
import 'package:new_projectv1/utils/news_service.dart';

import 'modules/home/home_binding.dart';
import 'modules/home/home_sceen.dart';

void main() {
  Get.put(NewsService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      initialBinding: HomeBinding(),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}

