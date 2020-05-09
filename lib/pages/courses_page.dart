import 'package:cdu_helper/apis/courses_api.dart';
import 'package:cdu_helper/beans/newest_courses.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  Map<String, dynamic> studentAccount;
  int currentWeek = 11; //目前周数
  int currentDay = 5; //目前日
  int currentMonth = 5; //目前月份
  int currentTerm = 2; //目前学期
  List weekDayList = ['周一', "周二", "周三", "周四", "周五", "周六", "周日"];
  String currentYear = '2019-2020'; //目前学年
  String currentGrade = '大三'; //目前学年
  bool isExpanded = false; //是否折叠栏打开
  int weeksInterm = 15; //本学期周数

  void changeExpanded(val) {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void changeCurrentWeek(val) {
    setState(() {
      currentWeek = val;
    });
  }

  @override
  void initState() {
    super.initState();
    studentAccount = SpUtils.getStudentAccountSync();
  }

  Widget topBarWidget() {
    List<Widget> weeksButton() {
      Widget weeksButtonItems(int index) {
        return InkWell(
          onTap: () {
            changeCurrentWeek(index);
          },
          child: Container(
            color: currentWeek == index ? Colors.blue : Colors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Text('第$index周'),
              ],
            ),
          ),
        );
      }

      List<Widget> weeksButton = [];
      for (var i = 1; i <= weeksInterm; i++) {
        weeksButton.add(weeksButtonItems(i));
      }
      return weeksButton;
    }

    return Container(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(currentGrade + " " + '第' + currentTerm.toString() + '学期'),
                Text('第$currentWeek周'),
              ],
            ),
          ],
        ),
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(200),
            color: Colors.grey[200],
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      color: Colors.blue,
                      child: Text('修改当前周'),
                    ),
                    Row(
                      children: weeksButton(),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  //周一到周日的组件
  Widget weekdayWidget() {
    Widget _weekDay(weekDayName) {
      return Container(
        width: ScreenUtil().setWidth(100),
        child: Center(
          child: Text('$weekDayName'),
        ),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1.0, color: Colors.white))),
      );
    }

    Widget _monthName(monthName) {
      return Container(
        width: ScreenUtil().setWidth(50),
        child: Center(
          child: Text('$monthName' + '月'),
        ),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1.0, color: Colors.white))),
      );
    }

    return Container(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(70),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: <Widget>[
            _monthName(currentMonth),
            _weekDay(weekDayList[0]),
            _weekDay(weekDayList[1]),
            _weekDay(weekDayList[2]),
            _weekDay(weekDayList[3]),
            _weekDay(weekDayList[4]),
            _weekDay(weekDayList[5]),
            _weekDay(weekDayList[6])
          ],
        ));
  }

  //左边的行号，使用一个column
  Widget leftNumWidget() {
    Widget _widget(number) {
      return Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(120),
        child: Center(
          child: Text('$number'),
        ),
        decoration: BoxDecoration(
            color: Colors.white12, border: Border(bottom: BorderSide())),
      );
    }

    List<Widget> list = [];
    for (int i = 1; i <= 12; i++) {
      list.add(_widget(i));
    }

    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(1440),
          color: Colors.black26,
          child: Column(children: list),
        )
      ],
    );
  }

  Widget mainWidget(NewestCourses coursesData) {
    List<Widget> _row = [];
    List<Widget> _columu = [];
    var coursesList = coursesData.data.schedule;
    coursesList.forEach((day) {
      _columu = [];
      day.forEach((courses) {
        bool isSkip = false;

        if (courses.isNotEmpty) {
          courses.forEach((course) {
            if (course.weeksArr.contains(currentWeek)) {
              isSkip = true;
              _columu.add(InkWell(
                child: Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(240),
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color:CoursesApi.randomCourseColor() ),
                    child: Column(
                      children: <Widget>[
                        Text('${course.name}',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(26),fontWeight:FontWeight.bold),),
                        Text('@${course.place}',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20),))
                      ],
                    ),
                    
                  ),
                ),
              ));
            }
          });
        }

        if (isSkip) {
        } else {
          _columu.add(Container(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(240),
          ));
        }
      }

      );
      _row.add(Column(children: _columu,));
    });

    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(1440),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leftNumWidget(),
          Row(children: _row,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SchoolApi.getNewestCourse(
            studentAccount['account'], studentAccount['password']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          NewestCourses coursesData;
          if(snapshot.connectionState == ConnectionState.waiting){
            return  Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil.screenHeight,
            child: Center(child:  CircularProgressIndicator(),),
          );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //json序列化

            Map<String, dynamic> data = DataUtils.snapToData(snapshot.data);
            //json对象化
            coursesData = NewestCourses.fromJson(data);
                      return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: Screens.width,
              height: Screens.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    topBarWidget(),
                    weekdayWidget(),
                    mainWidget(coursesData),
                  ],
                ),
              ),
            ),
          );
          }

        });
  }
}
