import 'package:app_news/layouts/news_layout.dart';
import 'package:app_news/modules/business/screen.dart';
import 'package:app_news/modules/science/screen.dart';
import 'package:app_news/modules/settings/screen.dart';
import 'package:app_news/modules/sports/screen.dart';
import 'package:app_news/shared/network/local/shered_prefrences.dart';
import 'package:app_news/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomNavList=[
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),];
 // dark mode var
  bool isDarkMode=false;

  List<dynamic>business=[];
  List<dynamic>sports=[];
  List<dynamic>science=[];
  List<dynamic>search=[];
  List<Widget> screens=[BusinessScreen(),SportsScreen(),ScienceScreen(),SettingsScreen()];

//--------------------------------------------------------------------------------------
  static NewsCubit getCubit(context)=>BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex=index;
    if(index==1){
      getSports();
    }
    if(index==2){
      getScience();
    }
    emit(NewsChangeBottomIndex());
  }
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
  void getBusiness(){
    emit(NewsBusinessLoadingState());
    DioHelper.getData(path: '/v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'56d430bf7b364d06b59261f9433e210b',
        }).then((value){
          business=value.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  void getSports(){
   if(sports.length==0){
     emit(NewsSportsLoadingState());
     DioHelper.getData(path: '/v2/top-headlines',
         query: {
           'country':'eg',
           'category':'sports',
           'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
         }).then((value){
       sports=value.data['articles'];
       print(sports[0]['title']);
       emit(NewsGetSportsSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(NewsGetSportsErrorState(error.toString()));
     });
   }
   emit(NewsGetSportsSuccessState());
  }
  void getScience(){
    if(science.length==0){
      emit(NewsScienceLoadingState());
      DioHelper.getData(path: '/v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value){
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    }
    emit(NewsGetScienceSuccessState());
  }

  void getSearch(String value){
    emit(NewsSearchLoadingState());
    DioHelper.getData(path: 'v2/everything',
        query: {
      'q':'$value',
      'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value){
          search=value.data['articles'];
          print(search[0]['title']);
          emit(NewsGetSearchSuccessState());
    }).catchError((onError){
      emit(NewsSearchErrorState(onError));
    });
  }
  void changeMode({bool fromShared}){
    if(fromShared!=null){
      isDarkMode=fromShared;
    }else{isDarkMode= ! isDarkMode;}
    SharedHelper.setBoolean(key: 'isDark', value: isDarkMode).then((value) => emit(NewsChangeThemeModeState()));
  }

}