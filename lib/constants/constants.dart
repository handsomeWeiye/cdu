import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'configs.dart';

export 'configs.dart';
export 'events.dart';
export 'instances.dart';
export 'screens.dart';
export 'themes.dart';
export 'package:cdu_helper/apis/api.dart';
export 'package:cdu_helper/utils/utils.dart';

const double kAppBarHeight = 75.0;
const String packageName = 'cn.weiye.cdu_helper';

class Constants {
  const Constants._();

  static const quickActionsList = <String, String>{
    'actions_home': '主页',
    'actions_forum': '论坛',
    // 'actions_message': '消息',
    'actions_mine': '我的'
  };

  static const String latestVersion = "latestVersion";
  static const String firstDayOfTerm = "firstDayOfTerm";
  static const String announcement = "announcement";
  static const String latestIOS = "latestIOS";
  static const String latestAndroid = "latestAndroid"; 

  static const String merchantNo = "2004191283910589"; //商户号
  static const String merchantKey = "ca81d5bbd49087e166469a299263e67f"; //商户秘钥

  static const String cetToken = "bu4Zp6JSev7sM9DQn8FXxPNB"; //CET查询token

  static const String jAppKey = "541f7a74fe7b45764bb62bcf"; //极光IM Key
  static const String socialPwd = "weiyezuishuai"; //极光用户默认密码


  static final Map<String, dynamic> bmobHeader = {
    'X-Bmob-Application-Id': '160a9b19cb9a1bedce5c0f48d2fd8ce5',
    'X-Bmob-REST-API-Key': '63e64b5539026cfe34ac1f38542cda9e',
    'Content-Type': 'application/json'
  };

  static double size(double size) => size * Configs.fontScale;

  static const endLineTag = '👀 没有更多了';

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ];

  static Iterable<Locale> get supportedLocales => [
        const Locale.fromSubtags(languageCode: 'zh'),
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        const Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
        const Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
        const Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
      ];
}
