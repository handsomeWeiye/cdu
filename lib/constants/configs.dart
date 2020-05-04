import 'package:flutter/material.dart';

class Configs {
  static final String appTitle = 'CduHelper'; //APP名
  static final Map<String, Color> appColor = {
    'dark-primary-color': Color(int.parse('1976D2', radix: 16)).withAlpha(255),
    'default-primary-color':Color(int.parse('2196F3', radix: 16)).withAlpha(255),
    'light-primary-color': Color(int.parse('BBDEFB', radix: 16)).withAlpha(255),
    'text-primary-color': Color(int.parse('FFFFFF', radix: 16)).withAlpha(255),
    'accent-color': Color(int.parse('03A9F4', radix: 16)).withAlpha(255),
    'primary-text-color': Color(int.parse('212121', radix: 16)).withAlpha(255),
    'secondary-text-color':Color(int.parse('757575', radix: 16)).withAlpha(255),
    'divider-color': Color(int.parse('BDBDBD', radix: 16)).withAlpha(255),
  }; //App配色方案
  static final Color appThemeColor = Color(0xfff54337);//APP主题色
  static double fontScale = 1.0; //字体大小
}
