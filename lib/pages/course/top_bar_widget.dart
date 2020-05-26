// import 'package:cdu_helper/apis/courses_api.dart';
// import 'package:cdu_helper/beans/newest_courses.dart';
// import 'package:cdu_helper/constants/constants.dart';
// import 'package:cdu_helper/utils/data_utils.dart';
// import 'package:cdu_helper/widgets/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
  
//   Widget topBarWidget() {

//     List<Widget> weeksButton() {
//       Widget weeksButtonItems(int index) {
//         return InkWell(
//           onTap: () {
//             changeCurrentWeek(index);
//           },
//           child: Container(
//             color: currentWeek == index ? Colors.blue : Colors.white,
//             padding: EdgeInsets.all(5),
//             child: Column(
//               children: <Widget>[
//                 Text('第$index周'),
//               ],
//             ),
//           ),
//         );
//       }

//       List<Widget> weeksButton = [];
//       for (var i = 1; i <= weeksInterm; i++) {
//         weeksButton.add(weeksButtonItems(i));
//       }
//       return weeksButton;
//     }

//     return Container(
//       child: ExpansionTile(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Text(currentGrade + " " + '第' + currentTerm.toString() + '学期'),
//                 Text('第$currentWeek周'),
//               ],
//             ),
//           ],
//         ),
//         children: <Widget>[
//           Container(
//             height: ScreenUtil().setHeight(200),
//             color: Colors.grey[200],
//             child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       width: 80,
//                       color: Colors.blue,
//                       child: Text('修改当前周'),
//                     ),
//                     Row(
//                       children: weeksButton(),
//                     )
//                   ],
//                 )),
//           )
//         ],
//       ),
//     );

    
//   }