// import 'package:cdu_helper/constants/constants.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';

// class HiveFieldUtils{
//   const HiveFieldUtils._();
//   // static SettingProvider get provider => Provider.of<SettingsProvider>(currentContext,listen:false);
//   static final Box<dynamic> _box = HiveBoxes.settingsBox;

//   static const String brightnessDark = 'theme_brightness';
//   static const String colorThemeIndex = 'theme_colorThemeIndex';
//   static const String brightnessPlatform = 'theme_brightness_platform';
  
//   static const String settingFontScale = 'setting_font_scale';
//   static const String deviceUuid = 'device_uuid';
//   static const String devicePushToken = 'device_push_token';

//     /// 获取设置的主题色
//   static int getColorThemeIndex() => _box?.get(colorThemeIndex) as int ?? 0;

//   /// 获取设置的夜间模式
//   static bool getBrightnessDark() => _box?.get(brightnessDark) as bool ?? false;

//   /// 获取设置的跟随系统夜间模式
//   static bool getBrightnessPlatform() => _box?.get(brightnessPlatform) as bool ?? true;

//   /// 设置选择的主题色
//   static Future<void> setColorTheme(int value) async => await _box?.put(colorThemeIndex, value);

//   /// 设置选择的夜间模式
//   static Future<void> setBrightnessDark(bool value) async => await _box?.put(brightnessDark, value);


//   /// 设置跟随系统的夜间模式
//   static Future<void> setBrightnessPlatform(bool value) async =>
//       await _box?.put(brightnessPlatform, value);

//   /// 获取字体缩放设置
//   static double getFontScale() => _box?.get(settingFontScale) as double;


//   /// 设置字体缩放
//   static Future<void> setFontScale(double scale) async {
//     // provider.fontScale = scale;
//     await _box?.put(settingFontScale, scale);
//   }


//   /// 获取设备PushToken
//   static String getDevicePushToken() => _box?.get(devicePushToken) as String;

//   /// 获取设备Uuid
//   static String getDeviceUuid() => _box?.get(deviceUuid) as String;

//   /// 写入PushToken
//   static Future<void> setDevicePushTokenR(String value) async {
//     DeviceUtils.devicePushToken = value;
//     await _box?.put(devicePushToken, value);
//   }

//   /// 写入uuid
//   static Future<void> setDeviceUuid(String value) async {
//     DeviceUtils.deviceUuid = value;
//     await _box?.put(deviceUuid, value);
//   }

// }