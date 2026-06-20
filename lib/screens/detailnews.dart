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

  void checkBookMark() async {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.articles.urlToImage,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.newspaper, color: Color(0xFFE63946), size: 25),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        widget.articles.auther,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFB0B0B0),
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.access_time, color: Color(0xFFE63946)),
                    SizedBox(width: 5),
                    Text(
                      timeago.format(widget.articles.publishAt),
                      style: TextStyle(fontSize: 15, color: Color(0xFFB0B0B0)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  widget.articles.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.articles.content,
                  style: TextStyle(fontSize: 20, color: Color(0xFFB0B0B0)),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE63946)),
          onPressed: () {
            launchUrl(Uri.parse(widget.articles.url));
          },
          child: Text(
            'Read Full Article',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
