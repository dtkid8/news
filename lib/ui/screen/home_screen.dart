import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:newsapp/data/service/api_service.dart';
import 'package:newsapp/provider/headline_provider.dart';
import 'package:newsapp/provider/latest_news_provider.dart';
import 'package:newsapp/provider/state.dart';
import 'package:newsapp/ui/screen/widget/headline_list_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _headlineHeight = MediaQuery.of(context).size.height / 3;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeadlineProvider>(
          create: (_) => HeadlineProvider(
            apiService: ApiService(
              client: Client(),
            ),
          ),
        ),
        ChangeNotifierProvider<LatestNewsProvider>(
          create: (_) => LatestNewsProvider(
            apiService: ApiService(
              client: Client(),
            ),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("News"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Headline",
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                height: _headlineHeight,
                child: Consumer<HeadlineProvider>(
                  builder: (context, state, _) {
                    if (state.state == ProviderState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ProviderState.HasData) {
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              state.result.articles[0].urlToImage,
                              //width: _headlineHeight / 2,
                              //height: _headlineHeight / 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.articles[0].title,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Column(
                                  children: [],
                                ),
                                Image.network(
                                  state.result.articles[1].urlToImage,
                                  width: _headlineHeight / 3,
                                  height: _headlineHeight / 3,
                                ),
                                Spacer(),
                                Image.network(
                                  state.result.articles[2].urlToImage,
                                  width: _headlineHeight / 3,
                                  height: _headlineHeight / 3,
                                ),
                                Spacer(),
                                Image.network(
                                  state.result.articles[3].urlToImage,
                                  width: _headlineHeight / 3,
                                  height: _headlineHeight / 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state.state == ProviderState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ProviderState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
              Text(
                "Latest News",
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                child: Container(
                  child: Consumer<LatestNewsProvider>(
                    builder: (context, state, _) {
                      if (state.state == ProviderState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.state == ProviderState.HasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.result.articles.length,
                          itemBuilder: (context, index) {
                            final article = state.result.articles[index];
                            return NewsListTile(article: article);
                          },
                        );
                      } else if (state.state == ProviderState.NoData) {
                        return Center(child: Text(state.message));
                      } else if (state.state == ProviderState.Error) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text(''));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
