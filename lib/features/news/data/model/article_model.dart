// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String title,
    required String desc,
    required String urlToImage,
    required String url,
    required DateTime publishAt,
    required String auther,
    required String content,
  }) : super(
         title: title,
         desc: desc,
         urlToImage: urlToImage,
         url: url,
         publishAt: publishAt,
         auther: auther,
         content: content,
       );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'desc': desc,
      'urlToImage': urlToImage,
      'url': url,
      'publishAt': publishAt.millisecondsSinceEpoch,
      'auther': auther,
      'content': content,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'] ?? '',
      desc: map['description'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      url: map['url'] ?? '',
      publishAt: DateTime.parse(
        map['publishedAt'] ?? DateTime.now().toIso8601String(),
      ),
      auther: map['author'] ?? 'Unknown',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArticleModel(title: $title, desc: $desc, urlToImage: $urlToImage, url: $url, publishAt: $publishAt, auther: $auther, content: $content)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.desc == desc &&
        other.urlToImage == urlToImage &&
        other.url == url &&
        other.publishAt == publishAt &&
        other.auther == auther &&
        other.content == content;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        urlToImage.hashCode ^
        url.hashCode ^
        publishAt.hashCode ^
        auther.hashCode ^
        content.hashCode;
  }
}
