import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/screens/detailnews.dart';
import 'package:news_app/screens/services/news_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleModel>> _newsFuture;
  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService().getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D0D),
        title: Text(
          'NewzLy',
          style: TextStyle(color:  Color(0xFFE63946), fontWeight: FontWeight.bold,fontSize: 24),
        ),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          final article = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              print('refreshing...');
              setState(() {
                _newsFuture = NewsService().getTopHeadlines();
              });
            },
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: article.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Detailnews(articles: article[index]),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            article[index].urlToImage,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Icon(Icons.broken_image),
                                  ),
                                ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            timeago.format(article[index].publishAt),
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            article[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            article[index].desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFB0B0B0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
