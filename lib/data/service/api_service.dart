import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:newsapp/data/model/news.dart';
import 'package:newsapp/data/model/search.dart';

class ApiService {
  final Client client;
  ApiService({required this.client});
  static const BASE_URL = "https://newsapi.org/v2/";
  static const HEADLINE = "top-headlines?country=id";
  static const API_KEY = "5f00d331dfd24c32a3e34d70cae204b6";
  static const SEARCH = "everything?q=";
  //Search: https://newsapi.org/v2/everything?q=bitcoin&page=1&apiKey=5f00d331dfd24c32a3e34d70cae204b6
  Future<NewsResult> getListNews(int page) async {
    final url = BASE_URL + HEADLINE + "&page=$page&apiKey=$API_KEY";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = NewsResult.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<SearchResult> search(String query) async {
    final url = BASE_URL + SEARCH + "$query&page=1&apiKey=$API_KEY";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = SearchResult.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
