import 'package:dio/dio.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/utils.dart';

class SchoolApi {
  static Future<Response<dynamic>> getNewestCourseSync(
      String account, String password) async {
    await NetUtils.post(API.getCourseSchedule, data: {
      'account': account,
      'password': password,
    }).then((res) {
      return res.data;
    });
  }

  static Future<Response<dynamic>> getNewestCourse(
      String account, String password) async {
    var res = await NetUtils.post(API.getCourseSchedule, data: {
      'account': account,
      'password': password,
    });

    return res;
  }

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

  static Future<Response<dynamic>> getScore(String account, String password, String year, String term) async {
    var res = await NetUtils.post(API.getScore, data: {'account': account,'password': password,'year': year,'term': term});
    return res;
  }

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
  static Future<Response<String>> getFestival() async =>
      NetUtils.getWithHeaderSet(API.getFestivalList,
          headers: Constants.bmobHeader);
}
