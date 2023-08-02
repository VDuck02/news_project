import 'package:dio/dio.dart';

import '../model/news_model.dart';
import 'message.dart';


class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = '86fc8130af7844fc86c6f3c5141ecb7e';

  final Dio _dio = Dio();

  Future<News> fetchNews() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/top-headlines?country=us&category=business&apiKey=$_apiKey',
      );
      if (response.statusCode == 200) {
        return News.fromJson(response.data);
      } else {
        throw Exception(Message.mFailure);
      }
    } catch (e) {
      throw Exception('${Message.mError} $e');
    }
  }

  Future<News> searchNews(String query) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/everything?q=$query&apiKey=$_apiKey',
      );
      if (response.statusCode == 200) {
        return News.fromJson(response.data);
      } else {
        throw Exception(Message.mFailure);
      }
    } catch (e) {
      throw Exception('${Message.mError} $e');
    }
  }
}
