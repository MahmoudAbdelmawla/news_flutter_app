// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layouts/app_cubit.dart';
import 'package:news_app/layouts/bloc_observer.dart';
import 'package:news_app/layouts/news_cubit.dart';
import 'package:news_app/layouts/news_layout.dart';
import 'package:news_app/network/remote/dio/dio_helper.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/styles/colors.dart';
import 'layouts/app_states.dart';
import 'network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool fromSharedPreference = CacheHelper.getBooleanData(key: isLightModeKey);
      //== null ? true : CacheHelper.getBooleanData(key: isLightModeKey);
  runApp(NewsApp(fromSharedPreference));
}

class NewsApp extends StatelessWidget {
  final bool fromSharedPreference;
  NewsApp(this.fromSharedPreference);

  // const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusinessNews()..getSportsNews()..getScienceNews(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromSharedPreference: fromSharedPreference),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
         // AppCubit appCubit = AppCubit.getInstance(context)..changeAppMode(fromSharedPreference:fromSharedPreference);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                  statusBarBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 24.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('$backgroundColor'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarBrightness: Brightness.dark,
                  ),
                  backgroundColor: HexColor(backgroundColor),
                  elevation: 24.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 24.0,
                  backgroundColor: HexColor('$backgroundColor'),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),),
            themeMode: AppCubit.getInstance(context).themeMode,
            home: Directionality(
                textDirection: TextDirection.rtl,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
// AppCubit.getInstance(context).isLightMode == true ? ThemeMode.light : ThemeMode.dark