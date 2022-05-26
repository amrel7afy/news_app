import 'package:app_news/modules/search/search_screen.dart';
import 'package:app_news/shared/cubit/news_cubit.dart';
import 'package:app_news/shared/cubit/news_states.dart';
import 'package:app_news/shared/network/remote/dio_helper.dart';
import 'package:app_news/shared/reusable_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context,state){},
      builder:(BuildContext context,state){
        var cubit=NewsCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {
                navigateTo(context, SearchScreen());
              },),
              IconButton(onPressed: (){
                NewsCubit.getCubit(context).changeMode();
                print(cubit.isDarkMode);
              }, icon: Icon(Icons.brightness_4_outlined))
              ,SizedBox(width: 10,)],
            title: Text('News App',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavList,
            onTap:cubit.changeIndex
          ),
        );
      }
    );
  }
}
