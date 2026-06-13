import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class Detailnews extends StatefulWidget {
  final ArticleModel articles;
  const Detailnews({super.key, required this.articles});

  @override
  State<Detailnews> createState() => _DetailnewsState();
}

class _DetailnewsState extends State<Detailnews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.articles.urlToImage),
              SizedBox(height: 10),
              Text(
                timeago.format(widget.articles.publishAt),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                widget.articles.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
              Text(
                widget.articles.desc,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
