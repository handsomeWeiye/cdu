
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static final String spIsLogin = "isLogin";
  static final String spIsBind = "isBind";
  static final String spAccount = "account";
  static final String spPassword = "password";
  static final String spToken = "token";
  static final String spUid = "uid";
  static final String spBrightness = "themeBrightness";
  static final String spColorThemeIndex = "themeColorThemeIndex";

  static SharedPreferences sp;
  static Future initSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<bool> isLogin() async {
    bool b = sp.getBool(spIsLogin);
    return b != null && b;
  }

  static Future<bool> isBind() async {
    bool b = sp.getBool(spIsBind);
    return b != null && b;
  }


    static void saveStudentAccount(String account,String password) async {

    await sp.setString(spAccount, account);
    await sp.setString(spPassword, password);
    await sp.setBool(spIsBind, true);
    
  }
  static Future<Map<String, dynamic>> getStudentAccount() async {
    String account =  sp.getString(spAccount);
    String password  =  sp.getString(spPassword);

    return <String, dynamic>{
      'account': account,
      'password':password
    };
  }
  static Map<String, dynamic> getStudentAccountSync()  {
    String account =  sp.getString(spAccount);
    String password  =  sp.getString(spPassword);

    return <String, dynamic>{
      'account': account,
      'password':password
    };
  }

    static String getAccount()  {
    String account =  sp.getString(spAccount);
    return account;
  }

  static void saveUid(String uid) async {
    if (uid != null) {
      await sp.setString(spUid, uid);
      // await sp.setBool(spIsLogin, true);
    }
  }

  static Future<Null> saveToken(String token) async {
    if (token != null) {
      await sp.setString(spToken, token);
      await sp.setBool(spIsLogin, true);
    }
  }

  static Future<String> getToken() async {
    String token = await sp.getString(spToken);
    return token;
  }
  static String getTokenSync() {
    String token =  sp.getString(spToken);
    return token;
  }
}
