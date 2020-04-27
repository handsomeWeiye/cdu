import 'package:dio/dio.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/utils.dart';

class SchoolApi {
  static Future<Response<String>> getNewestCourse(
          String account, String password) async =>
      NetUtils.post(API.getCourseSchedule, data: {
        'account': account,
        'password': password,
      });
  static Future<Response<String>> getCourse(
          String account, String password, String year, String term) async =>
      NetUtils.post(API.getCourseSchedule, data: {
        'account': account,
        'password': password,
        'year': year,
        'term': term,
      });

  static Future<Response<String>> getAllScore(
          String account, String password) async =>
      NetUtils.post(API.getScore,
          data: {'account': account, 'password': password});

  static Future<Response<String>> getScore(
          String account, String password, String year, String term) async =>
      NetUtils.post(API.getScore, data: {
        'account': account,
        'password': password,
        'year': year,
        'term': term
      });

  static Future<Response<dynamic>> getCetCode(String zkz, String name) async =>
      NetUtils.get(API.getCetCode,
          data: {'zkz': zkz, 'name': name, 'token': Constants.cetToken});

  static Future<Response<dynamic>> getCetScore(
          String zkz, String name, String captcha) async =>
      NetUtils.post(API.getCetScore, data: {
        'zkz': zkz,
        'name': name,
        'captcha': captcha,
        'token': Constants.cetToken
      });
  static Future<Response<String>> getFestival()async => NetUtils.getWithHeaderSet(API.getFestivalList,headers: Constants.bmobHeader);
}
