import 'dart:io';
import 'package:cdu_helper/constants/constants.dart';
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

  static Future<Response<String>> login(
          String deviceId, String deviceName, String mobile, String pwd,
          {String token}) async =>
      NetUtils.postX(API.login, data: {
        'deviceId': deviceId,
        'deviceName': deviceName,
        'mobile': mobile,
        'pwd': pwd,
        'token': token
      });

  static Future<Response<String>> loginAdmin(
          ) async =>
      NetUtils.postX(API.loginAdmin, data: {
        'merchantKey': Constants.merchantKey,
        'merchantNo': Constants.merchantNo,
      });

  static Future<Response<String>> loginOut({String token}) async =>
      NetUtils.getX(API.loginOut, data: {'token': token});

  static Future<Response<String>> getSMS(String mobile,
          {String key, String picCode, String token}) async =>
      await NetUtils.getX(API.getSms, data: {
        'mobile': mobile,
        'key': key,
        'pinCode': picCode,
        'token': token
      });

  static Future<Response<String>> checkSms(String code, String mobile,
          {String token}) async =>
      await NetUtils.postX(API.getSms,
          data: {'code': code, 'mobile': mobile,});

  static Future<Response<String>> getUserInfo(
          String account, String password) async =>
      NetUtils.post(API.getUserInfo,
          data: {'account': account, 'password': password});

  static Future<Response<String>> getUserDetail({String token}) async =>
      NetUtils.getX(API.getUserDetail, data: {'token': token});

  static Future<Response<String>> updateUserDetail(
          String avatarUrl, String city, String nick, String province,
          String token, {String extJsonStr}) async =>
      NetUtils.postX(API.updateUserDetail, data: {
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

  
  static Future<Response<String>> uploadImage(File file) async {
    print('开始上传文件');
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    String imageType = name.substring(name.lastIndexOf(".") + 1, name.length);
    // var image = await MultipartFile.fromFile(
    //     path,
    //     filename: name,
    // );
    print("文件路径="+path);
    print("文件名="+name);
    print("文件类型=$imageType");
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path,filename: name)
    });
    NetUtils.uploadFiles(API.uploadFiles, formData);
  }
    
}
