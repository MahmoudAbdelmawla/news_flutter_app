import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_cubit.dart';
import 'package:news_app/layouts/news_states.dart';
import 'package:news_app/shared/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = NewsCubit.getInstance(context);

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List news = newsCubit.sportsNews;
        return articleBuilder(news, state,context);
      },
    );
  }
}
