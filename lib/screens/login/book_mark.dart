import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/screens/detailnews.dart';

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
              appBar: AppBar(
                title: Text('Saved'),
              ),
              body: Center(
                child: Text(
                  'Nothing Saved✋',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Saved Article',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final article = snapshot.data!.docs[index].data();
                return Dismissible(
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
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.only(bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                article['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
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
