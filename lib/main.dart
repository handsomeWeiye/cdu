import 'package:cdu_helper/constants/configs.dart';
import 'package:cdu_helper/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'utils/utils.dart';
import 'constants/constants.dart';

import 'routes.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();//确保flutter初始化
  NetUtils.initConfig(); //允许网络请求抓包
  await NotificationPermissions.getNotificationPermissionStatus(); //获取允许通知的情况
  // NotificationUtils.initSettings();//通知初始化
  await DeviceUtils.initDeviceInfo();//获取用户设备信息
  await SpUtils.initSharedPreferences();//数据持久化初始
  // await HiveBoxes.openBoxes();//本地数据库初始化

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);//设置APP允许的方向
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));//设置超出屏幕部分的样式

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final Color currentThemeColor = Configs.appThemeColor;//获取目前设置的主题色
  bool isDark = ThemeUtils.spGetBrightnessDark(); //获取目前设置的夜间模式
    @override
  void initState() { 
    super.initState();
    setBrightness();//设置白天模式或者夜间模式

    Instances.eventBus 
      //订阅夜间模式变化，实行状态变化
      ..on<BrightnessChangedEvent>().listen((event){
        print('event'+' is '+ '$event');
        isDark = event.isDark;
        if(mounted)setState(() {});
      })
      //订阅绑定状况变化，实行状态变化
      // ..on<BindGotEvent>().listen((event){
      //   print('event'+' is '+ '$event');
      //   Provider.of<CoursesProvider>(currentContext, listen: false).initCourses();
      //   Provider.of<ScoresProvider>(currentContext, listen: false).initScore();
      // })
      //订阅登录状况变化，实行状态变化
      ..on<LogoutEvent>().listen((event){
        isDark = false;
        if (mounted) setState(() {});
        // Provider.of<CoursesProvider>(currentContext, listen: false).unloadCourses();
        // Provider.of<ScoresProvider>(currentContext, listen: false).unloadScore();        
      });
  }

  //如果有记录，那么设置值，如果没有记录，那么设置为白天
  void setBrightness() {
  if (isDark == null) {
    Themes.isDark = isDark = false;
    if (mounted) setState(() {});
    ThemeUtils.spSetBrightnessDark(false);
  } else {
    Themes.isDark = isDark;
    if (mounted) setState(() {});
  }
  }




  @override
  Widget build(BuildContext context) {
   
     return
    // MultiProvider(
    //   providers: providers,
    //   child: 
    
     OKToast(child:  MaterialApp(
        navigatorKey: Instances.navigatorKey,
        title: Configs.appTitle,
        theme: isDark ? Themes.dark():Themes.light(),
        home: SplashPage(),
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: Constants.localizationsDelegates,
        supportedLocales: Constants.supportedLocales,
      ));
    // );
  }
}

