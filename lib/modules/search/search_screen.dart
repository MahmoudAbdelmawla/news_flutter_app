import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_cubit.dart';
import 'package:news_app/layouts/news_states.dart';
import 'package:news_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  //const SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color? iconColor = Theme.of(context).iconTheme.color;

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        List news = NewsCubit.getInstance(context).searchNews;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
                },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: iconColor,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: defaultTextFormField(
                  labelText: 'Search',
                  controller: searchController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.search,
                  validate:(value){
                    if(value.isEmpty){
                      return 'Search must be not empty';
                    }
                    return null;
                  },
                  onChange: (value){
                    NewsCubit.getInstance(context).getSearchNews(value);
                  },
                ),
              ),
              Expanded(
                  child: articleBuilder(news, state, context)),
            ],
          ),
        );
      } ,
    );
  }
}
