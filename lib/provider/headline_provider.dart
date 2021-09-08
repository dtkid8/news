import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newsapp/data/model/news.dart';
import 'package:newsapp/data/service/api_service.dart';
import 'package:newsapp/provider/state.dart';
class HeadlineProvider extends ChangeNotifier {
  final ApiService apiService;
  HeadlineProvider({
   required this.apiService,
  }) {
    _fetchInitialNews();
  }

  late NewsResult _news;
  String _message = "";
  late ProviderState _state;

  String get message => _message;

  NewsResult get result => _news;

  ProviderState get state => _state;

  Future<dynamic> _fetchInitialNews() async {
    try {
      _state = ProviderState.Loading;
      notifyListeners();
      final news = await apiService.getListNews(1);
      if (news.articles.isEmpty) {
        _state = ProviderState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ProviderState.HasData;
        notifyListeners();
        return _news = news;
      }
    } on SocketException {
      _state = ProviderState.Error;
      notifyListeners();
      return _message = 'Tidak ada koneksi Internet';
    } catch (e) {
      _state = ProviderState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}