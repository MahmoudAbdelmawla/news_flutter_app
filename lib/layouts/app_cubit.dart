import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/constants.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit getInstance(context) => BlocProvider.of(context);

  //bool isLightMode = CacheHelper.getBooleanData(key: isLightModeKey) == null ? true : CacheHelper.getBooleanData(key: isLightModeKey);
  bool isLightMode = false;
  ThemeMode themeMode = ThemeMode.light;

  // ThemeMode themeMode = isLightMode? ThemeMode.light : ThemeMode.dark;

  void changeAppMode({bool? fromSharedPreference}){
    if(fromSharedPreference != null){
      isLightMode = fromSharedPreference;
    }
    else{
      isLightMode = !isLightMode;
     CacheHelper.setBooleanData(key: isLightModeKey, value: isLightMode).then((value)async{
       if(isLightMode){
         themeMode = ThemeMode.light;
         emit(AppLightModeState());
       }
       else{
         themeMode = ThemeMode.dark;
         emit(AppDarkModeState());
     }
     }).catchError((error){error.toString();});
    }
    //CacheHelper.setBooleanData(key: isLightModeKey, value: isLightMode);
    // if(isLightMode){
    //   themeMode = ThemeMode.light;
    //   emit(AppLightModeState());
    // }else{
    //   themeMode = ThemeMode.dark;
    //   emit(AppDarkModeState());
    // }
  }
}