import 'dart:io';

import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/net_utils.dart';
import 'package:dio/dio.dart';

class SystermApi{


  static Future<Response<String>> getAnnouncement()async{
    await NetUtils.getX(API.getAnnouncement,data:{'key':Constants.announcement});
  }
  static Future<Response<String>> getLatestVersion()async{
    await NetUtils.getX(API.getLatestVersion,data:{'key':Constants.latestVersion});
  }
  static Future<Response<String>> getLatestAndroid()async{
    await NetUtils.getX(API.getLatestAndroid,data:{'key':Constants.latestAndroid});
  }
  static Future<Response<String>> getLatestIOS()async{
    await NetUtils.getX(API.getLatestIOS,data:{'key':Constants.latestIOS});
  }
    static Future<Response<String>> getSMS(String mobile,
          {String key, String picCode, String token}) async =>
      await NetUtils.getX(API.getSms, data: {
        'mobile': mobile,
        'key': key,
        'pinCode': picCode,
        'token': token
      });

  static Future<Response<dynamic>> getBanner({String token,String type})async{
      var res = await NetUtils.getX(API.getBanner,data:{'token':token,'type':type});
      return res;
  }
    static Future<Response<dynamic>> getCategoryList({String token,String type})async{
      var token = SpUtils.getTokenSync();
      var res = await NetUtils.getX(API.getHomeCategoryList,data:{'token':token,});
      return res;
  }
  
  
    static Future<String>getTest({String token,String type})async{
    Future.delayed(Duration(seconds: 2));
    return 'weiyezuishuai';
  }

  static Future<Response<String>> checkSms(String code, String mobile,
          {String token}) async =>
      await NetUtils.postX(API.getSms,
          data: {'code': code, 'mobile': mobile,});

    static Future<Response<String>> uploadImage(File file) async {

    print('开始上传文件');

    //imagePicker获得照片路径
    String path = file.path;
    //获得文件名
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);
    //获得文件类型
    String imageType = name.substring(name.lastIndexOf(".") + 1, name.length);
 
    print("文件路径="+path);
    print("文件名="+name);
    print("文件类型=$imageType");

    //构造formData
    FormData formData = FormData.fromMap({
      "upfile": await MultipartFile.fromFile(path,filename: name)
    });

    //使用dio发送formData请求
    Response<String> data  = await NetUtils.uploadFiles(API.uploadFiles, formData);
    print(data);
    return data;
  }
}