import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_projectv1/model/article_model.dart';
import 'package:new_projectv1/model/news_model.dart';
import '../manage_layout/news_list_item.dart';
import '../utils/message.dart';
import '../utils/news_service.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<Article> _articles = [];
  List<Article> _searchResults = [];
  final NewsService _newsService = NewsService();
  bool _isLoading = true;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const TitleAppBar(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          _buildSearchIcon(),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_isSearching ? _buildSearchResults() : _buildArticleList()),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: (value) {
        _inputSearch(value);
      },
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSearching = !_isSearching;
          if (!_isSearching) {
            _searchController.clear();
            _searchResults.clear();
          }
        });
      },
      icon: Icon(_isSearching ? Icons.close : Icons.search_rounded),
    );
  }

  Widget _buildSearchResults() {
    return _searchResults.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        Article article = _searchResults[index];
        return NewsListItem(article: article);
      },
    )
        : const Center(
      child: Text(Message.mEmpty),
    );
  }

  Widget _buildArticleList() {
    return _articles.isEmpty
        ? const Center(child: Text(Message.mEmpty))
        : ListView.builder(
      shrinkWrap: true,
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        Article article = _articles[index];
        return NewsListItem(article: article);
      },
    );
  }



  void _fetchNews() async {
    try {
      News news = await _newsService.fetchNews();
      setState(() {
        _articles = news.articles;
        _isLoading = false;

        if (kDebugMode) {
          print(news.articles.toString());
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (kDebugMode) {
        print('${Message.mError} $e');
      }
    }
  }

  void _inputSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
    } else {
      try {
        News searchNews = await _newsService.searchNews(query);
        setState(() {
          _searchResults = searchNews.articles;
        });
      } catch (e) {
        if (kDebugMode) {
          print('${Message.mError} $e');
        }
      }
    }
  }
}

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                  text: 'Investing',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              TextSpan(
                  text: '.com',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal)),
            ]));
  }
}
