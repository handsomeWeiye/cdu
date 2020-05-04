

import 'package:cdu_helper/pages/home_page.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/bind_student_page.dart';


//配置路由规则
final routes = {
  '/splash':(context)=> SplashPage(),
  '/home':(context)=> HomePage(),
  '/login':(context)=>LoginPage(),
  '/bindStudent':(context)=>BindStudentPage(),
};

//配置路由异常
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

