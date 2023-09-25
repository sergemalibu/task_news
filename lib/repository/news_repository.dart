import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_news/models/news_model.dart';

class NewsRepository {
  Future<News> fetchNews() async {
    const url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=bc56d0cefb7445baad1aa3b6c1f8fdb3';
    const error = 'Error';
    final response = await http.get(Uri.parse(
      url,
    ));
    if (response.statusCode == 200) {
      final news = News.fromJson(json.decode(response.body));
      return news;
    } else {
      return throw (error);
    }
  }
}
