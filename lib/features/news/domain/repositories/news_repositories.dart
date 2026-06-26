
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class NewsRepositories {
    Future<List<Article>> getTopHeadlines();
}