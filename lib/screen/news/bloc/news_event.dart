part of 'news_bloc.dart';

abstract class NewsEvent {}

class NewsInitEvent implements NewsEvent {}

class ToggleNewsRead extends NewsEvent {
  final int cardIndex;

  ToggleNewsRead(this.cardIndex);
}

class ToggleAllNewsRead extends NewsEvent {}
