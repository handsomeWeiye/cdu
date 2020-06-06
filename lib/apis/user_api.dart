import 'dart:io';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:cdu_helper/utils/utils.dart';
import 'api.dart';

class UserApi {
  static Future<Response<String>> register(
          String mobile, String code, String pwd) async =>
      await NetUtils.postX(API.register,
          data: {'mobile': mobile, 'code': code, 'pwd': pwd});

  static Future<Response<String>> resetPwd(
          String code, String mobile, String pwd, {String token}) async =>
      NetUtils.postX(API.resetPwd,
          data: {'mobile': mobile, 'code': code, 'pwd': pwd, 'token': token});

  static Future<String> loginAdmin({String merchantKey,String merchantNo })async{
    Response<String> jsonData =  await NetUtils.postX(API.loginAdmin,data:{'merchantKey':Constants.merchantKey,'merchantNo':Constants.merchantNo});
    String data = DataUtils.jsonToData(jsonData)['data'];
    return data;
  }

  static Future<String> verArticle()async{

  }

  static Future<Response<String>> login(
           String mobile, String pwd,
          {String deviceId, String deviceName,String token}) async =>
      NetUtils.postX(API.login, data: {
        'deviceId': DeviceUtils.deviceModel,
        'deviceName':  DeviceUtils.deviceModel,
        'mobile': mobile,
        'pwd': pwd,
        'token': token
      });



  static Future<Response<String>> loginOut({String token}) async =>
      NetUtils.getX(API.loginOut, data: {'token': token});



  static Future<Response<String>> getUserInfo(
          String account, String password) async =>
      NetUtils.post(API.getUserInfo,
          data: {'account': account, 'password': password});

  static Future<Response<String>> getMyDetail({String token}) async 
      { Response<String> data = await NetUtils.getX(API.getMyDetail, data: {'token': token});return data;}

  static Future<Response<String>> getUserDetail({String xtoken,String id}) async 
      { Response<String> data = await NetUtils.getX(API.getUserDetail, data: {'token': xtoken,'id':id});return data;}

  static Future<Response<String>> updateUserDetail(
         { String avatarUrl, String city, String nick, String province,
          String token, String extJsonStr}) async =>
      NetUtils.postX(API.updateMyDetail, data: {
        'avatarUrl': avatarUrl,
        'city': city,
        'nick': nick,
        'province': province,
        'token': token,
        'extJsonStr': extJsonStr
      });

  static Future<Response<String>> sign({String token}) async =>
      NetUtils.postX(API.sign, data: {'token': token});

  static Future<Response<String>> getSignList(
          {String dateAddBegin,
          String dateAddEnd,
          String page,
          String pageSize,
          String token}) async =>
      NetUtils.postX(API.getSignList, data: {
        'dateAddBegin': dateAddBegin,
        'dateAddEnd': dateAddEnd,
        'page': page,
        'pageSize': pageSize,
        'token': token
      });

  static Future<Response<String>> getTodaySign({String token}) async =>
      NetUtils.getX(API.getTodaySign, data: {'token': token});

  static Future<Response<String>> getSignRules({String token}) async =>
      NetUtils.getX(API.getSignRules, data: {'token': token});

    
}
