// import 'package:cdu_helper/widgets/confirmation_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';

// import 'package:cdu_helper/constants/constants.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// const String hiveBoxPrefix = 'cdu_helper';

// class HiveBoxes{
//   const HiveBoxes._();

//   static Box<Map<dynamic,dynamic>> coursesBox;
//   static Box<String> courseRemarkBox;
//   static Box<DateTime> startWeekBox;
//   static Box<Map<dynamic,dynamic>> scoresBox;

//   static Box<dynamic> settingsBox;

//   static Future<void> openBoxes()async{
//     // Hive
//     //   ..registerAdapter(CourseAdapter())
//     //   ..registerAdapter(ScoreAdapter());
    
//     coursesBox = await Hive.openBox('${hiveBoxPrefix}_user_courses');
//     courseRemarkBox = await Hive.openBox('${hiveBoxPrefix}_user_courses_remark');
//     startWeekBox = await Hive.openBox('${hiveBoxPrefix}_start_week');
//     scoresBox = await Hive.openBox('${hiveBoxPrefix}_user_scores');
//     settingsBox = await Hive.openBox('${hiveBoxPrefix}_app_setting');
//   }

//   static Future<void> clearBoxes({BuildContext context})async{
//     bool confirm = true;
//     if(context != null){
//       confirm = await ConfirmationBottomSheet.show(
//         context,
//         title: '清除应用数据',
//         showConfirm: true,
//         content: '清除数据会将您的所有应用内容（包括设置、应用消息）清除。\n确定继续吗？',
//       );
//     }
//     if(confirm){
//       debugPrint('Clearing Hive Boxes...');
//       await coursesBox?.clear();
//       await courseRemarkBox?.clear();
//       await scoresBox?.clear();
//       await startWeekBox?.clear();
//       await settingsBox?.clear();
//       debugPrint('Boxes cleared');
//     }
//     if(kReleaseMode){
//       SystemNavigator.pop();
//     }
//   }
// }
// class HiveAdapterTypeIds {
//   const HiveAdapterTypeIds._();

//   static const int appMessage = 0;
//   static const int message = 1;
//   static const int course = 2;
//   static const int score = 3;
//   static const int changelog = 4;
// }