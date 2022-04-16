import 'package:dio/dio.dart';

class dio_helper{
   static late Dio dio;

    static init(){
      dio = Dio(
        BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,

        )
      );
    }

  static Future<Response> getData({
  required String url,
   Map<String,dynamic>? query,
    String lang = 'en',
    String? auth,
}) async{
    dio.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':auth,

    };
     return await dio.get(
        url,
         queryParameters: query
     );
    }

    static Future<Response> postdata({
      required String url,
       Map<String,dynamic>? query,
      required Map<String,dynamic> data,
      String lang = 'en',
      String? auth,
}) async
    {
      dio.options.headers ={
        'Content-Type':'application/json',
        'lang':lang,
        'Authorization':auth,
      };
      return await dio.post(url,queryParameters: query,data: data );
    }

   static Future<Response> updateData({
     required String url,
     Map<String,dynamic>? query,
     required Map<String,dynamic> data,
     String lang = 'en',
     String? auth,
   }) async
   {
     dio.options.headers ={
       'Content-Type':'application/json',
       'lang':lang,
       'Authorization':auth,
     };
     return await dio.put(url,queryParameters: query,data: data );
   }

   static Future<Response> deleteData({
     required String url,
     Map<String,dynamic>? query,
     String lang = 'en',
     String? auth,
   }) async
   {
     dio.options.headers ={
       'Content-Type':'application/json',
       'lang':lang,
       'Authorization':auth,
     };
     return await dio.delete(url);
   }
}