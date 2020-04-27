import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{
  static final String spIsLogin = "isLogin";
  static final String spToken = "token";  
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
  static Future<Null> saveToken(String token) async {
    if (token != null) {
      await sp.setString(spToken, token);
      await sp.setBool(spIsLogin, true);
    }
  }
  static Map<String, dynamic> getToken() => <String, dynamic>{
        'ticket': sp.getString(spToken),
      };

}
