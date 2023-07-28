import 'article_model.dart';

class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({required this.status, required this.totalResults, required this.articles});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Article>.from(json['articles'].map((x) => Article.fromJson(x))),
    );
  }

}
