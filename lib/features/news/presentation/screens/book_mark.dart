import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/model/article_model.dart';
import 'package:news_app/features/news/presentation/screens/detailnews.dart';

class BookMark extends StatelessWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('bookMark')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ScaffoldMessenger(child: SnackBar(content: Text('Error $e')));
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Scaffold(
              appBar: AppBar(title: Text('Saved')),
              body: Center(
                child: Text(
                  'Nothing Saved',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Saved Article',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final article = snapshot.data!.docs[index].data();
                return Dismissible(
                  background: Container(
                    color: Color(0xFFE63946),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  key: Key(snapshot.data!.docs[index].id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) async {
                    final docUid = snapshot.data!.docs[index].id;
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(user.uid)
                        .collection('bookMark')
                        .doc(docUid)
                        .delete();
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Detailnews(
                            articles: ArticleModel.fromMap(article),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF0F1923),
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFFE63946),
                              width: 4,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      article['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      article['desc'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: Image.network(
                                  article['urlToImage'],
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
