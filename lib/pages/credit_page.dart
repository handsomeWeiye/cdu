import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/beans/score.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CreditPage extends StatefulWidget {
  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  Map student = SpUtils.getStudentAccountSync();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('成绩'),
      ),body: FutureBuilder(
      future: SchoolApi.getScore(
          student['account'], student['password'], '2018-2019', '2'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil.screenHeight,
            child: Center(child:  CircularProgressIndicator(),),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = DataUtils.snapToData(snapshot.data);
            print(data);
            Score scoreData = Score.fromJson(data);
            // print(scoreData.data);
             return ListView.builder(
               itemCount: scoreData.data.length,
               itemBuilder: (BuildContext context, int index) {
               return Container(
                 width: ScreenUtil.screenWidth,
                 height: ScreenUtil().setHeight(200),
                 padding: EdgeInsets.all(5),
                 child:Card(
                   elevation: 5,
                   child:  Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
                   
                   padding: EdgeInsets.all(5),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                         Text(scoreData.data[index].lessonName,style: TextStyle(fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold)),
                         Text('取得学分：${scoreData.data[index].score}   绩点：${scoreData.data[index].point}',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(24)))
                       ],),
                       Text(scoreData.data[index].score.toString(),style: TextStyle(color:  scoreData.data[index].point<1?Colors.red :Colors.green,fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold)),
                     ],
                   ),
                 ),
                 )
               ) ;
              },
             );
          }
                     
        }
      },
    ),);
  }
}
