import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repositories.dart';

class GetTopHeadlines {
  final NewsRepositories repository;
  GetTopHeadlines(this.repository);

  Future<List<Article>> call() {
    return repository.getTopHeadlines();  // just delegates
  }
}