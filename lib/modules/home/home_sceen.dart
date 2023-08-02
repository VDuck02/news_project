import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manage_layout/news_list_item.dart';
import '../../model/article_model.dart';
import '../../utils/message.dart';
import 'home_controller.dart';


class HomeScreen extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Obx(
              () => _newsController.isSearching
              ? _buildSearchField()
              : const TitleAppBar(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          Obx(() => _buildSearchIcon()),
        ],
      ),
      body: Obx(() => _newsController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_newsController.isSearching
          ? _buildSearchResults()
          : _buildArticleList())),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _newsController.searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: (value) {
        _newsController.inputSearch(value);
      },
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      onPressed: () {
        _newsController.toggleSearch();
      },
      icon: Icon(
          _newsController.isSearching ? Icons.close : Icons.search_rounded),
    );
  }

  Widget _buildSearchResults() {
    return _newsController.searchResults.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      itemCount: _newsController.searchResults.length,
      itemBuilder: (context, index) {
        Article article = _newsController.searchResults[index];
        return NewsListItem(article: article);
      },
    )
        : const Center(
      child: Text(Message.mEmpty),
    );
  }

  Widget _buildArticleList() {
    return _newsController.articles.isEmpty
        ? const Center(child: Text(Message.mEmpty))
        : ListView.builder(
      shrinkWrap: true,
      itemCount: _newsController.articles.length,
      itemBuilder: (context, index) {
        Article article = _newsController.articles[index];
        return NewsListItem(article: article);
      },
    );
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
