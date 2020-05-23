import 'package:cdu_helper/pages/courses_page.dart';
import 'package:cdu_helper/pages/credit_page.dart';
import 'package:cdu_helper/pages/forum/forum_detail_page.dart';
import 'package:cdu_helper/pages/home/home_page.dart';
import 'package:cdu_helper/pages/login/impresve_information_page.dart';
import 'package:cdu_helper/pages/index_page.dart';
import 'package:cdu_helper/pages/lost_page.dart';
import 'package:cdu_helper/pages/love_page.dart';
import 'package:cdu_helper/pages/scores_page.dart';
import 'package:cdu_helper/pages/member/setting_page.dart';
import 'package:cdu_helper/pages/shop_page.dart';
import 'pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/splash/splash_page.dart';
import 'pages/login/bind_student_page.dart';


//配置路由规则
final routes = {
  '/splash':(context)=> SplashPage(),
  '/home':(context)=> HomePage(),
  '/login':(context)=>LoginPage(),
  '/course':(context)=>CoursesPage(),
  '/score':(context)=>ScoresPage(),
  '/love':(context)=>LovePage(),
  '/credit':(context)=>CreditPage(),
  '/lost':(context)=>LostPage(),
  '/shop':(context)=>ShopPage(),
  '/setting':(context)=>SettingPage(),
  '/index':(context)=>IndexPage(),
  '/info':(context)=>ImpresveInformationPage(),
  '/bind':(context)=>BindStudentPage(),
  '/detail':(context,{arguments})=>ForumDetailPage(arguments: arguments),
};

//配置路由拦截器
var onGenerateRoute = (RouteSettings settings) {
  // print(settings);
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      // print(settings.arguments);
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

