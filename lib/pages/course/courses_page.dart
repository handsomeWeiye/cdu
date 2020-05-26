import 'package:cdu_helper/apis/courses_api.dart';
import 'package:cdu_helper/beans/newest_courses.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/providers/course_provider.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  Map<String, dynamic> studentAccount;
  int currentWeek ; //目前周数
  int currentDay ; //目前日
  int currentWeekDay;
  DateTime startDay; //本学期第一天
  int currentMonth ; //目前月份
  String currentTerm ; //目前学期
  List weekDayList = ['周一', "周二", "周三", "周四", "周五", "周六", "周日"];
  String currentYear ; //目前学年
  String currentGrade ; //目前年级
  bool isExpanded ; //是否折叠栏打开
  int weeksInTerm ; //本学期周数

  void init(){
    studentAccount = SpUtils.getStudentAccountSync();
    startDay = getStartDate();
    currentWeek = getCurrentWeek();
    currentWeekDay = DateTime.now().weekday;
    currentMonth = DateTime.now().month;
    currentTerm = getCurrentTerm();
    currentYear = getCurrentYear();
    currentGrade = getCurrentGrade();
    weeksInTerm = Constants.weeksInTerm;
  }

  static int getCurrentWeek(){
    DateTime startDate = getStartDate();
    DateTime now = DateTime.now();
    Duration different = now.difference(startDate);
    int currentWeek = different.inDays~/7;
    print(currentWeek);
    return currentWeek;
  }

  static DateTime getStartDate() {
    CoursesApi.getStartDay().then((val) {
      var data = DataUtils.jsonToData(val);
      String firstDay = data['data'];
      print(firstDay);
      DateTime firstDate = DateTime.parse(firstDay);
      print(firstDate);
      return firstDate;
    });
  }

  static String getCurrentGrade() {
    String currentGrade;
    String account = SpUtils.getAccount();
    String startYear = account.substring(0, 4);
    String startDay = startYear + "-09-01";
    DateTime startDate = DateTime.parse(startDay);
    DateTime dateTime = DateTime.now();
    Duration different = dateTime.difference(startDate);
    currentGrade = Constants.intGradeToWord[different.inDays ~/ 365] ?? null;
    print(currentGrade);
    return currentGrade;
  }

  static String getCurrentTerm() {
    String currentTerm;
    List firstTerm = [9, 10, 11, 12, 1];
    // List secondTerm = [2, 3, 4, 5, 6, 7, 8, 9];
    DateTime dateTime = DateTime.now();
    int month = dateTime.month;
    if (firstTerm.contains(month)) {
      currentTerm = "1";
    } else {
      currentTerm = "2";
    }
    return currentTerm;
  }
  static String getCurrentYear(){
    String  currentYear;
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    if(month<9){
      currentYear = (year-1).toString() + "-" + year.toString();
      print(currentYear);
    }else{
      currentYear = (year).toString() + "-" + (year+1).toString();
      print(currentYear);
    }
    return currentYear;
  }



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
    init();
 
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
      for (var i = 1; i <= weeksInTerm; i++) {
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: CoursesApi.randomCourseColor()),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${course.name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(26),
                              fontWeight: FontWeight.bold),
                        ),
                        Text('@${course.place}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20),
                            ))
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
      });
      _row.add(Column(
        children: _columu,
      ));
    });

    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(1440),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leftNumWidget(),
          Row(
            children: _row,
          )
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //json序列化

            Map<String, dynamic> data = DataUtils.snapToData(snapshot.data);
            //json对象化
            coursesData = NewestCourses.fromJson(data);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight,
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
