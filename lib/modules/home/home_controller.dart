import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/article_model.dart';
import '../../model/news_model.dart';
import '../../utils/message.dart';
import '../../utils/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = Get.find<NewsService>();
  final RxList<Article> _articles = <Article>[].obs;
  final RxList<Article> _searchResults = <Article>[].obs;
  final RxBool _isLoading = true.obs;
  final RxBool _isSearching = false.obs;
  final TextEditingController _searchController = TextEditingController();

  //
  NewsService get newsService => _newsService;

  List<Article> get articles => _articles;
  List<Article> get searchResults => _searchResults;
  bool get isLoading => _isLoading.value;
  bool get isSearching => _isSearching.value;
  TextEditingController get searchController => _searchController;


  @override
  void onInit() {
    super.onInit();
    Get.put(NewsService());
    _fetchNews();
  }

  void _fetchNews() async {
    try {
      News news = await _newsService.fetchNews();
      _articles.assignAll(news.articles);
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      if (kDebugMode) {
        print('${Message.mError} $e');
      }
    }
  }

  void inputSearch(String query) async {
    if (query.isEmpty) {
      _searchResults.clear();
    } else {
      try {
        News searchNews = await _newsService.searchNews(query);
        _searchResults.assignAll(searchNews.articles);
      } catch (e) {
        if (kDebugMode) {
          print('${Message.mError} $e');
        }
      }
    }
  }

  void toggleSearch() {
    _isSearching.value = !_isSearching.value;
    if (!_isSearching.value) {
      _searchController.clear();
      _searchResults.clear();
    }
  }


}
