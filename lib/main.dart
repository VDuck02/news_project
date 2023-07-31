import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projectv1/screens/news_list_screen.dart';
import 'package:new_projectv1/utils/news_service.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: NewsListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


