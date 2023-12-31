import 'package:flutter/material.dart';

import '../../model/article_model.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/message.dart';
import '../home/home_sceen.dart';
import 'news_detail_controller.dart';
import 'package:get/get.dart';

class NewsDetailScreen extends GetView<NewDetailsController> {
  final Article article;

  const NewsDetailScreen({super.key,  required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBar(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.text_fields_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: newDetail,
      ),
    );
  }

  Column get newDetail {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        Text(
          '${Message.mPub}   ${DateTimeFormatter.formatApiDateTime(article.publishedAt)}',
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(height: 15),
        article.urlToImage.isNotEmpty
            ? Image.network(
          article.urlToImage,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        )
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        Text(
          article.content,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
