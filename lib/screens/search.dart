import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchArticle = TextEditingController();
  Future<List<ArticleModel>>? searchFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    searchFuture = NewsService().searchNews(value);
                  });
                },
                style: TextStyle(color: Colors.white),
                controller: searchArticle,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: InputBorder.none,
                  hintText: 'Search News here',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: searchFuture,
                builder: (context, snapshot) {
                  if (searchFuture == null) {
                    return Center(
                      child: Text(
                        'Search Some Articles ☝',
                        style: TextStyle(fontSize: 25),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'Search Some Articles ☝',
                          style: TextStyle(fontSize: 25),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final article = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              title: Text(article.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(article.desc),
                                  Text(
                                    timeago.format(article.publishAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Center(child: Text('Search Some Articles ☝'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
