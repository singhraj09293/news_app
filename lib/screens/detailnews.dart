import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class Detailnews extends StatefulWidget {
  final ArticleModel articles;
  const Detailnews({super.key, required this.articles});

  @override
  State<Detailnews> createState() => _DetailnewsState();
}

class _DetailnewsState extends State<Detailnews> {
  bool isBooked = false;
  @override
  void initState() {
    super.initState();
    checkBookMark();
  }

  checkBookMark() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('bookMark')
        .where('title', isEqualTo: widget.articles.title)
        .get();
    setState(() {
      isBooked = snapshot.docs.isNotEmpty;
    });
  }

  saveBookMark(ArticleModel article) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('bookMark')
        .add(article.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
            onPressed: () {
              saveBookMark(widget.articles);
              setState(() {
                isBooked = !isBooked;
              });
            },
            icon: isBooked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.articles.urlToImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.newspaper, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    widget.articles.auther,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Spacer(),
                  Icon(Icons.access_time, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    timeago.format(widget.articles.publishAt),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
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
              SizedBox(height: 10),
              Text(
                widget.articles.desc,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              ),
              SizedBox(height: 170),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(widget.articles.url));
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
