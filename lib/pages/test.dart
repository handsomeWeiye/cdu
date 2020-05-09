  //课程表主体部分,七列，每列由最多五个的小方块组成，
  import 'package:cdu_helper/apis/courses_api.dart';
import 'package:cdu_helper/beans/newest_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget coursesMainWidget(NewestCourses coursesData) {
    bool isFourSection = false;
    bool isHaveCourse = false;
    List<Widget> coursesColumnList = [];
    List<Widget> coursesMainList = [];

    void getCoursesMainList() {
      coursesMainList = [];
      coursesData.data.schedule.forEach((day) {
        coursesColumnList = [];
        day.forEach((courses) {
          if (isFourSection) {
            isFourSection = !isFourSection;
          } else {
            if (courses.isNotEmpty) {
              isHaveCourse = false;
              courses.forEach((courseItem) {
                if (courseItem.weeksArr.contains(2)) {
                  // if (courseItem.section == 4) {
                  //   isFourSection = true;
                  // }
                  coursesColumnList.add(InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(1.0),
                        height: courseItem.section == 2
                            ? ScreenUtil().setHeight(240)
                            : ScreenUtil().setHeight(480),
                        width: ScreenUtil().setWidth(100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Container(
                          color: CoursesApi.randomCourseColor(),
                          child: Center(
                              child: Column(
                            children: <Widget>[
                              Text('${courseItem.name}'),
                              Text('@${courseItem.place}')
                            ],
                          )),
                        )),
                  ));
                  isHaveCourse = true;
                } 
                if(isHaveCourse){
                  
                }else {
                  coursesColumnList.add(Container(
                    height: ScreenUtil().setHeight(240),
                    width: ScreenUtil().setWidth(100),
                    color: Colors.white,
                  ));
                }
              });
            } else {
              coursesColumnList.add(Container(
                height: ScreenUtil().setHeight(240),
                width: ScreenUtil().setWidth(100),
                color: Colors.white,
              ));
            }
          }
        });

        coursesMainList.add(Container(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(1440),
          child: Column(
            children: coursesColumnList,
          ),
        ));
      });
    }

    getCoursesMainList();
    return Container(
        width: ScreenUtil().setWidth(700),
        height: ScreenUtil().setHeight(1440),
        child: Row(
          children: coursesMainList,
        ));
  }