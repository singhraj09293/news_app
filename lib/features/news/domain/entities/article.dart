class Article {
  final String title;
  final String desc;
  final String urlToImage;
  final String url;
  final DateTime publishAt;
  final String auther;
  final String content;

  Article({
    required this.title,
    required this.desc,
    required this.urlToImage,
    required this.url,
    required this.publishAt,
    required this.auther,
    required this.content,
  });

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
}
