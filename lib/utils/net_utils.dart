import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

// import 'package:cdu_helper/apis/api.dart';
// import 'package:cdu_helper/constants/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class NetUtils{
  static final Dio dio = Dio();
  static final DefaultCookieJar cookieJar = DefaultCookieJar();
  static final CookieManager cookieManager = CookieManager(cookieJar);

  static void initConfig() async{
    
    dio.interceptors.add(cookieManager);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) => "PROXY 192.168.1.9:8888";
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
    dio.interceptors.add(cookieManager);
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e) async {
        print("DioError: ${e.message}");
        return e;
      },
    ));
  }
  
  static Future<Response<T>> get<T>(String url,{Map<String,dynamic>data}) async => 
  await dio.get<T>(url,queryParameters: data);

  static Future<Response<T>> getX<T>(String url,{Map<String,dynamic>data}) async => 
  await dio.get<T>(url,queryParameters: data,options: Options(contentType: Headers.formUrlEncodedContentType));

  static Future<Response> getBytes(String url,{Map<String,dynamic>data}) async=>
  await dio.get(url,queryParameters: data,options: Options(responseType: ResponseType.bytes));

  static Future<Response<T>> getWithHeaderSet<T>(String url,{Map<String,dynamic>data,Map<String,dynamic>headers})async=>
  await dio.get<T>(url,queryParameters: data,options: Options(headers: headers));

  static Future<Response<T>> post<T>(String url,{Map<String,dynamic>data}) async=>
  await dio.post(url,data: data);

    static Future<Response<T>> postX<T>(String url,{Map<String,dynamic>data}) async=>
  await dio.post(url,data: data,options: Options(contentType: Headers.formUrlEncodedContentType));

  static Future<Response<T>> uploadFiles<T>(String url,FormData formData) async 
    { await dio.post(url,data:formData);}

  static Future<Response<dynamic>> download(String url,{Map<String,dynamic>data,Map<String,dynamic>headers})async{
    Response<dynamic> response;
    String path;
    final Map<PermissionGroup,PermissionStatus>permissions = 
    await PermissionHandler().requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
    if (permissions[PermissionGroup.storage]==PermissionStatus.granted){
      print('开始下载');
      print('File start download:$url');
      path = (await getExternalStorageDirectory()).path;
      path += '/' + url.split('/').last.split('?').first;
      print(path);
      try{
        response = await dio.download(url, path,data:data,options:Options(headers:headers));
        print('File downloaded:$path');
        print('下载完成 $path');
        final OpenResult openFileResult = await OpenFile.open(path);
        print('File open result: ${openFileResult.type}');
        return response;
      }catch(e){
        print('File download dailed:$e');
        return null;
      }
    }else{
      print('No permission to download file: $url');
      print('未获得存储权限');
      return null;
    }
  }


}