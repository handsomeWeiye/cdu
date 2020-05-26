import 'package:cdu_helper/apis/courses_api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CoursesProvider with ChangeNotifier {
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

  
}
