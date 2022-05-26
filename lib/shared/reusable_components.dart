import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constats.dart';
import 'cubit/news_cubit.dart';
import 'cubit/news_states.dart';

Widget buildArticle(Map article,context)=>Padding(
  padding: EdgeInsets.all(10),
  child: Row(
    children: [
      Container(
        width: 160.0,
        height: 130.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}')
                ,fit: BoxFit.cover)
        ),
      ),
      SizedBox(width: 15,),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text('${article['title']}',maxLines: 3,overflow: TextOverflow.ellipsis
                  ,style: Theme.of(context).textTheme.bodyText1,),
              ),
              Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey,fontSize: 15),)],),
        ),
      )
    ],
  ),
);
// Widget buildScreen(list)=> BlocConsumer<NewsCubit, NewsStates>(
//     listener: (BuildContext context, state) {},
//     builder: (BuildContext context, state) {
//       var listData=[];
//       return ConditionalBuilder(
//           builder: (context) =>
//               ListView.separated(
//                   physics: BouncingScrollPhysics(),
//                   itemBuilder: (context, index) => buildArticle(listData[index],context),
//                   separatorBuilder: (context, index) => Padding(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Container(height: 1,
//                       color: Colors.grey[400],),),
//                   itemCount: listData.length),
//           condition: state is! NewsBusinessLoadingState,
//           fallback: (context) => Center(child: CircularProgressIndicator(),));
//     });

Widget defaultTextField({
  @required String labelText,
  @required IconData prefixIcon,
  @required TextEditingController textEditingController,
  Function validate,
  Function onTap,
  Function onChange
}
    ) =>TextFormField(
  validator: validate,
  onTap: onTap,
  onChanged: onChange,
  controller: textEditingController,
  decoration: InputDecoration(
    labelText: labelText,
    border: const OutlineInputBorder(),
    prefixIcon:Icon( prefixIcon),
  ),
);

void navigateTo(context ,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}