import 'dart:convert';
import 'dart:ui';
import 'package:cdu_helper/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double toSetX = size.width / 2;
    double toSetY = size.height / 2;
    // print(toSetX);
    // print(toSetY);
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.pink
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Paint paint1 = Paint()
      ..isAntiAlias = true
      ..color = Colors.blue
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawLine(Offset(0, toSetY), Offset(toSetX, toSetY), paint);
    canvas.drawLine(
        Offset(toSetX + 2, toSetY), Offset(2 * toSetX + 2, toSetY), paint);
    canvas.drawPoints(PointMode.points, [Offset(toSetX, toSetY)], paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

//自定义的重大日期组件
class ThingDateWidget extends StatelessWidget {
  DateTime now = DateTime.now(); //目前时间
  List<int> differentDays = []; //间隔时间
  List thingDateList = []; //重大日期列表
  List<int> removeIndexs = []; //需要移除的日期索引
List<Widget> thingDateItems = [];//将要显示的数量
  //Icon
  Widget thingDateIcon() {
    return Container(
      child: Icon(
        Icons.access_time,
        size: 35,
      ),
    );
  }

  //Item
  Widget thingDateItem(int days, String dateName, String date) {
    return Container(
        height: ScreenUtil().setHeight(200),
        width: ScreenUtil().setWidth(150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(date),
            CustomPaint(
              painter: MyPainter(),
              size:
                  Size(ScreenUtil().setWidth(150), ScreenUtil().setHeight(20)),
            ),
            Text(dateName + days.toString() + '天')
          ],
        ));
  }

  //Item组合
  // Widget thingDateItems() {
  //   List<Widget> thingDateItems = [];
  //   for (int i = 0; i < thingDateList.length; i++) {
  //     list.add(thingDateItem(differentDays[i], thingDateList[i]['thingName'],
  //         thingDateList[i]['thingDate']['iso'].toString().substring(0, 10), i));
  //   }
  //   return list.isNotEmpty ? Row(children: list) : Text('加载中');
  // }

  @override
  Widget build(BuildContext context) {
    differentDays = []; //每次刷新时将differentDays清空
    thingDateItems = [];//每次刷新时将thingDateItems清空
    return FutureBuilder(
      future: SchoolApi.getFestival(), //获取数据
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          thingDateList = jsonDecode(snapshot.data.toString())['results'];//解析json
          print(thingDateList);
          //如果已经经过的日期，那么就移除，没有经过的，保留
          thingDateList.forEach((val) {
            DateTime date = DateTime.parse(val['thingDate']['iso']); //解析日期
            int differentDay = int.parse(date.difference(now).inDays.toString()); //计算间隔天数
            //如果天数大于零
            if (differentDay >= 0) {
              //添加间隔天数到列表
                  thingDateItems.add(thingDateItem(differentDay, val['thingName'],
          val['thingDate']['iso'].toString().substring(0, 10)));
            } 
            // else {
            //   //否则获取待删除日期索引
            //   int removeIndex = thingDateList.indexOf(f);
            //   removeIndexs.add(removeIndex);
            // }
          });
          //删除过期日期
          // removeIndexs.forEach((f) {
          //   thingDateList.removeAt(f);
          // });
          // print(removeIndexs);
          print(thingDateList);
          return Container(
              padding: EdgeInsets.all(5),
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(750),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    thingDateIcon(),
                    SizedBox(width: ScreenUtil().setWidth(20)),
                    Row(children:thingDateItems) 
                  ],
                ),
              ));
        }
        return Center(child: Text('加载中'));
      },
    );
  }
}