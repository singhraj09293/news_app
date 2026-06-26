import 'package:dio/dio.dart';
import 'package:news_app/constraint.dart';
import 'package:news_app/features/news/data/model/article_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repositories.dart';

class NewsRepositoryImpl implements NewsRepositories {
  final dio = Dio(
    BaseOptions(
      baseUrl: Constraint.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  )..interceptors.add(InterceptorClass());
  Future<List<ArticleModel>> getTopHeadlines() async {
    final response = await dio.get(
      'everything',
      queryParameters: {
        'q': 'India',
        'apikey': Constraint.apiKey,
        'language': 'en',
      },
    );
    if (response.statusCode == 200) {
      final data = response.data['articles'];
      return (data as List).map((e) => ArticleModel.fromMap(e)).toList();
    } else {
      throw Exception('Error in StatusCode: ${response.statusCode}');
    }
  }

  Future<List<ArticleModel>>? searchNews(String query) async {
    final response = await dio.get(
      'everything',
      queryParameters: {'q': query, 'language': 'en', 'sortBy': 'publishAt'},
    );
    if (response.statusCode == 200) {
      final data = response.data['articles'];
      return (data as List).map((e) => ArticleModel.fromMap(e)).toList();
    } else {
      throw Exception('Error in StatusCode: ${response.statusCode}');
    }
  }
}

class InterceptorClass extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    options.queryParameters['apikey'] = Constraint.apiKey;
    print(options.uri);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
    print(response.statusCode);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.type == DioExceptionType.connectionError) {
      print('No Internet');
    }
    if (err.response?.statusCode == 401) {
      print('Invalid api key');
    }
    if (err.response?.statusCode == 404) {
      print('Resources not found');
    }
    if (err.response?.statusCode == 500) {
      print('Server error,try again');
    }
    if (err.type == DioExceptionType.connectionTimeout) {
      print('Request time out');
    }
  }
}
