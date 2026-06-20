import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/screens/detailnews.dart';
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
            TextField(
              onSubmitted: (value) {
                setState(() {
                  searchFuture = NewsService().searchNews(value);
                });
              },
              style: TextStyle(color: Colors.white),
              controller: searchArticle,
              decoration: InputDecoration(
                fillColor: Color(0xFF1A1A1A),
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFE63946)),
                ),
                hintText: 'Search News here',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
           SizedBox(height: 10,),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Detailnews(
                                    articles: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical:  10,horizontal: 10),
                              margin: EdgeInsets.symmetric(vertical: 7,horizontal: 5),
                              decoration: BoxDecoration(
                                color: Color(0xFF0F1923),
                                borderRadius: BorderRadius.circular(20),
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFFE63946),
                                    width: 4,
                                  ), // ← red accent
                                ),
                              ),
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
