import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class Detailnews extends StatelessWidget {
  final ArticleModel articles;
  const Detailnews({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                articles.urlToImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.newspaper,color: Colors.grey),
                  SizedBox(width: 5,),
                  Text(
                    articles.auther,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Spacer(),
                  Icon(Icons.access_time,color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text(
                    timeago.format(articles.publishAt),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                articles.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                articles.desc,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              ),
              SizedBox(height: 170,),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(articles.url));
                  },
                  child: Text(
                    'Read Full Article',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
