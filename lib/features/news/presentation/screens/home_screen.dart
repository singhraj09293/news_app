import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/presentation/provider/new_provider.dart';
import 'package:news_app/features/news/presentation/screens/detailnews.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final newsAsync = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D0D),
        title: Text(
          'NewzLy',
          style: TextStyle(
            color: Color(0xFFE63946),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: newsAsync.when(
        error: (e, st) => Center(child: Text('Error $e')),
        loading: () => Center(child: CircularProgressIndicator()),
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            ref.read(newsProvider.notifier).refresh();
          },
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Detailnews(articles: data[index]),
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
                          data[index].urlToImage,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: Center(child: Icon(Icons.broken_image)),
                              ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          timeago.format(data[index].publishAt),
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          data[index].title,
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
                          data[index].desc,
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
        ),
      ),
    );
  }
}
