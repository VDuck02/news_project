import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projectv1/model/article_model.dart';
import 'package:new_projectv1/utils/date_time_formatter.dart';
import 'package:new_projectv1/screens/news_detail_screen.dart';

class NewsListItem extends StatelessWidget {
  final Article article;

  const NewsListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                article.urlToImage,
                width: 115,
                height: 90,
                fit: BoxFit.cover,
              ),
            )
                : const SizedBox.shrink(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    DateTimeFormatter.formatTimeAgo(article.publishedAt),
                    style: const TextStyle(fontSize: 10),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail() {
    Get.to(() => NewsDetailScreen(article: article));
  }

}
