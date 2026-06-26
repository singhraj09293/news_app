import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/data/repositoires/news_repository_impl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/usecase/get_top_headlines.dart';

final newsProvider = AsyncNotifierProvider<NewProvider, List<Article>>(
  NewProvider.new,
);

class NewProvider extends AsyncNotifier<List<Article>> {
  @override
  FutureOr<List<Article>> build() {
    final usecase = GetTopHeadlines(NewsRepositoryImpl());
    return usecase();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
