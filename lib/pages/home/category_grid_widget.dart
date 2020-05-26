import 'package:cdu_helper/apis/systerm_api.dart';
import 'package:cdu_helper/beans/home_category_list.dart';
import 'package:cdu_helper/constants/instances.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget categoryGridWidget(String token) {
  Widget _categoryItembuild(categoryItemData) {
    return Container(
        height: 50,
        child: InkWell(
          onTap: () {
            navigatorState.pushNamed(categoryItemData.routName);
          },
          child: Column(
            children: <Widget>[
              Image.network(
                categoryItemData.picUrl,
                width: ScreenUtil().setWidth(100),
              ),
              Text(categoryItemData.name, maxLines: 1)
            ],
          ),
        ));
  }

  return Container(
    child: Card(
      margin: EdgeInsets.all(5),
      child: FutureBuilder(
        future: SystermApi.getCategoryList(token: token),
        builder:
            (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //json序列化
            Map<String, dynamic> data = DataUtils.jsonToData(snapshot.data);
            //json对象化
            CategoryList categoryList = CategoryList.fromJson(data);
            List<Data> category = categoryList.data;
            return Container(
                padding: EdgeInsets.all(5),
                height: ScreenUtil().setHeight(600),
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1,
                  children: category
                      .map((val) => _categoryItembuild(
                            val,
                          ))
                      .toList(),
                ));
          }
        },
      ),
    ),
  );
}
