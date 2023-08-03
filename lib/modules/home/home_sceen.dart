import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manage_layout/news_list_item.dart';
import '../../model/article_model.dart';
import '../../utils/message.dart';
import 'home_controller.dart';


class HomeScreen extends GetView<NewsController> {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Obx(
              () => controller.isSearching
              ? _buildSearchField()
              : const TitleAppBar(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          Obx(() => _buildSearchIcon()),
        ],
      ),
      body: Obx(() => controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (controller.isSearching
          ? _buildSearchResults()
          : _buildArticleList())),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: controller.searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: (value) {
        controller.inputSearch(value);
      },
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      onPressed: () {
        controller.toggleSearch();
      },
      icon: Icon(
          controller.isSearching ? Icons.close : Icons.search_rounded),
    );
  }

  Widget _buildSearchResults() {
    return controller.searchResults.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        Article article = controller.searchResults[index];
        return NewsListItem(article: article);
      },
    )
        : const Center(
      child: Text(Message.mEmpty),
    );
  }

  Widget _buildArticleList() {
    return controller.articles.isEmpty
        ? const Center(child: Text(Message.mEmpty))
        : ListView.builder(
      shrinkWrap: true,
      itemCount: controller.articles.length,
      itemBuilder: (context, index) {
        Article article = controller.articles[index];
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