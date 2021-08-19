import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/app_cubit.dart';
import 'package:news_app/layouts/news_cubit.dart';
import 'package:news_app/layouts/news_states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/constants.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Color? iconColor = Theme.of(context).iconTheme.color;

    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '$appName',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                    },
                  icon: Icon(
                    Icons.search,
                    color: iconColor,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    AppCubit.getInstance(context).changeAppMode(fromSharedPreference: null);
                    },
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  color: iconColor,
                ),
              ],
            ),
            body: newsCubit.screens[newsCubit.currentBottomNavBarIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: newsCubit.currentBottomNavBarIndex,
              onTap: (index){
                newsCubit.changeBottomNavBarItem(index);
              },
              items: newsCubit.bottomNavBarItems,
            ),
          );
        });
  }
}
