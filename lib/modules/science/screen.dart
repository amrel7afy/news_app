import 'package:app_news/shared/cubit/news_cubit.dart';
import 'package:app_news/shared/cubit/news_states.dart';
import 'package:app_news/shared/reusable_components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var listData=NewsCubit.getCubit(context).science;
          return ConditionalBuilder(
              builder: (context) =>
                  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildArticle(listData[index],context),
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Container(height: 1,
                          color: Colors.grey[400],),),
                      itemCount: listData.length),
              condition: listData.length>0,
              fallback: (context) => Center(child: CircularProgressIndicator(),));
        });
  }
}
