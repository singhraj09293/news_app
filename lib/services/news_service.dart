import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constraint.dart';
import 'package:news_app/model/article_model.dart';

class NewsService {
  final dio = Dio(BaseOptions(baseUrl: Constraint.baseUrl));
  Future<List<ArticleModel>> getTopHeadlines() async {
    final response = await dio.get(
      'everything',
      queryParameters: {'q':'India', 'apikey': Constraint.apiKey,'language' : 'en'},
    );
    if (response.statusCode == 200) {
      final data = response.data['articles'];
      return (data as List).map((e) => ArticleModel.fromMap(e)).toList();
    } else {
      throw Exception('Error in StatusCode: ${response.statusCode}');
    }
  }
}
