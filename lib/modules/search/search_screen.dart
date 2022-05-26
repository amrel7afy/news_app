import 'package:app_news/shared/cubit/news_states.dart';
import 'package:app_news/shared/reusable_components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/news_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var textEditController = TextEditingController();
        NewsCubit cubit =BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextField(
                    onChange: (String value){
                      cubit.getSearch(value);
                    },
                      labelText: 'Search', validate: (String value) {if (value.isEmpty) {
                          return 'Empty field';
                        }
                        return null;
                      }, prefixIcon: Icons.search, textEditingController: textEditController),
                ),
               ConditionalBuilder(
                 fallback: (context)=>Center(child: CircularProgressIndicator()),
                   condition: cubit.search.length>0,
                   builder: (context)=> Expanded(child: ListView.separated(
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context, index) => buildArticle(cubit.search[index], context),
                       separatorBuilder: (context,index)=>SizedBox(height: 20,),
                       itemCount: cubit.search.length)))
              ],
            ));
      },
    );
  }
}
