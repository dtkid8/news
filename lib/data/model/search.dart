import 'package:newsapp/data/model/news.dart';

class SearchResult {
  late String status;
  late int totalResults;
  late List<Articles> articles;

  SearchResult({required this.status, required this.totalResults, required this.articles});

  SearchResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }
}