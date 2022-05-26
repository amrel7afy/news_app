import 'package:dio/dio.dart';

abstract class NewsStates{
}
class NewsChangeThemeModeState  extends NewsStates{}
class NewsInitialState extends NewsStates{}
class NewsChangeBottomIndex extends NewsStates{}

class NewsGetBusinessSuccessState  extends NewsStates{}
class NewsBusinessLoadingState  extends NewsStates{}
class NewsGetBusinessErrorState  extends NewsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState  extends NewsStates{}
class NewsSportsLoadingState  extends NewsStates{}
class NewsGetSportsErrorState  extends NewsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState  extends NewsStates{}
class NewsScienceLoadingState  extends NewsStates{}
class NewsScienceErrorState  extends NewsStates{
  final String error;
  NewsScienceErrorState(this.error);
}

class NewsGetSearchSuccessState  extends NewsStates{}
class NewsSearchLoadingState  extends NewsStates{}
class NewsSearchErrorState  extends NewsStates{
  final String error;
  NewsSearchErrorState(this.error);
}

