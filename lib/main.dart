import 'package:app_news/shared/cubit/bloc_observer.dart';
import 'package:app_news/shared/cubit/news_cubit.dart';
import 'package:app_news/shared/cubit/news_states.dart';
import 'package:app_news/shared/network/local/shered_prefrences.dart';
import 'package:app_news/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layouts/news_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedHelper.init();
  bool isDark=SharedHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark: isDark,));
}
class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp({@required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit().. getBusiness()..changeMode(fromShared: isDark)
      ,child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            home: Directionality(
                textDirection:TextDirection.ltr
                ,
                child: NewsLayout()),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,color: Colors.black,
                        fontWeight: FontWeight.w600
                    )
                ),
                primarySwatch:Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange
                ),
                appBarTheme: AppBarTheme(
                    color: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    elevation: 0,
                    titleTextStyle: TextStyle(color: Colors.black),
                    systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark,statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                )
            ),
            darkTheme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,color: Colors.white,
                        fontWeight: FontWeight.w600
                    )
                ),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle:SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        systemNavigationBarIconBrightness: Brightness.light) ,
                    elevation: 0,
                    backgroundColor: HexColor('333739')
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.deepOrange
                )
            ),
            themeMode:NewsCubit.getCubit(context).isDarkMode?ThemeMode.dark:ThemeMode.light
          );
        },
      ),
    );
  }
}
