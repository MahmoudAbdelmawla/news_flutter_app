import 'package:dio/dio.dart';
import 'package:news_app/shared/constants.dart';

class DioHelper{
  static var dio;

  static init(){
    dio = Dio(BaseOptions(baseUrl: BaseUrl,receiveDataWhenStatusError: true,),);
  }

  static Future<Response> getData({required String method,required Map<String,dynamic> query})async{
    return await dio.get(method,queryParameters:query );
  }
}