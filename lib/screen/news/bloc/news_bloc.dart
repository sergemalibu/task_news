import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_news/repository/news_repository.dart';
import 'package:task_news/models/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState()) {
    on<NewsInitEvent>(_onNewsInit);
    on<ToggleNewsRead>(_onToggleCardColor);
    on<ToggleAllNewsRead>(_onToggleAllCardColors);
  }

  void _onNewsInit(NewsInitEvent event, Emitter<NewsState> emit) async {
    final news = NewsRepository();

    try {
      var listNews = await news.fetchNews();
      final List<Color> colors = listNews.articles!.map((color) {
        return Colors.white;
      }).toList();
      emit(state.copyWith(
        listNews: listNews,
        listColors: colors,
      ));
    } catch (e) {
      emit(state.copyWith(exception: true, exceptionText: e.toString()));
    }
  }

  void _onToggleCardColor(ToggleNewsRead event, Emitter<NewsState> emit) {
    final List<Color> updatedColors = List.from(state.listColors ?? []);
    updatedColors[event.cardIndex] = Colors.grey;
    emit(NewsState(listColors: updatedColors, listNews: state.listNews));
  }

  void _onToggleAllCardColors(
      ToggleAllNewsRead event, Emitter<NewsState> emit) {
    final List<Color> updatedColors = state.listNews!.articles!.map((color) {
      return Colors.grey;
    }).toList();
    emit(state.copyWith(listColors: updatedColors, listNews: state.listNews));
  }
}
