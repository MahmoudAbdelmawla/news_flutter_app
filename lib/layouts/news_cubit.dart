// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/dio/dio_helper.dart';
import 'package:news_app/shared/constants.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit getInstance(context) => BlocProvider.of(context);

  int currentBottomNavBarIndex = 0;
  List<Widget> screens = [BusinessScreen(),SportsScreen(),ScienceScreen(),SettingsScreen(),];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business',),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports',),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science',),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings',),
  ];
  List<String> titles = ['Business News','Sports News','Science News'];

  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scientificNews = [];
  List<dynamic> searchNews = [];

  void changeBottomNavBarItem(int index){
    currentBottomNavBarIndex = index;
    emit(ChangeBottomNavBarItemState());
  }

  void getBusinessNews(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        method: topHeadLineMethod,
        query:{
          'country':'eg',
          'category':'business',
          'apiKey':'$apiKey',
        }).then((value){
          businessNews =  value.data['articles'];
          emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error: error.toString()));
      print('Error when getting business newses');
    });
  }
  void getSportsNews(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        method: topHeadLineMethod,
        query:{
          'country':'eg',
          'category':'sports',
          'apiKey':'$apiKey',
        }).then((value){
          sportsNews = value.data['articles'];
          emit(NewsGetSportsSuccessState());
    }).catchError((error){
      emit(NewsGetSportsErrorState(error:error.toString()));
      print('Error when getting sports news');
    });
  }
  void getScienceNews(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        method: topHeadLineMethod,
        query:{
          'country':'eg',
          'category':'science',
          'apiKey':'$apiKey',
        }).then((value){
          scientificNews = value.data['articles'];
          emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error: error.toString()));
      print('Error when getting science news');
    });
  }

  void getSearchNews(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        method: searchMethod,
        query:{
          'q':'$value',
          'apiKey':'$apiKey',
        }).then((value){
      searchNews =  value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error: error.toString()));
      print('Error when getting business newses');
    });
  }
}
