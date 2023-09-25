part of 'news_bloc.dart';

class NewsState {
  News? listNews;
  List<Color>? listColors;
  bool? exception;
  String? exceptionText;

  NewsState({
    this.listNews,
    this.listColors,
    this.exception,
    this.exceptionText,
  });

  NewsState copyWith({
    News? listNews,
    List<Color>? listColors,
    bool? exception,
    String? exceptionText,
  }) {
    return NewsState(
      listNews: listNews ?? this.listNews,
      listColors: listColors ?? this.listColors,
      exception: exception ?? this.exception,
      exceptionText: exceptionText ?? this.exceptionText,
    );
  }
}
