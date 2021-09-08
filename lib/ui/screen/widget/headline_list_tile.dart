import 'package:flutter/material.dart';
import 'package:newsapp/data/model/news.dart';

class NewsListTile extends StatelessWidget {
  final Articles article;
  const NewsListTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
      ),
      title: Text(
        article.title,
      ),
      subtitle: Text(article.description),
      onTap: () {
        // Navigator.pushNamed(context, RestaurantDetailScreen.routeName, arguments: restaurant);
         //Navigation.intentWithData(RestaurantDetailScreen.routeName, restaurant);
      },
    );
  }
}