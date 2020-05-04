import 'dart:convert';
import 'dart:ui';
import 'package:cdu_helper/beans/banner.dart' as bean;
import 'package:cdu_helper/apis/systerm_api.dart';
import 'package:cdu_helper/beans/home_category_list.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/widgets/thing_date.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController; //滑动控制
  TabController _tabController; //副标题控制器
  String token = SpUtils.getTokenSync(); //获取token

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  //总体布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          title: Text('主页'),
          backgroundColor: Colors.blue,
        ),
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: ScreenUtil().setHeight(1200),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    //头部整个背景颜色
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        _swiperWideget(),
                        // _categoryGridWidget(token),
                        ThingDateWidget()
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 5.0,
                    labelColor: Color(0xff333333),
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    unselectedLabelColor: Color(0xff333333),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 12.0,
                    ),
                    tabs: [
                      Tab(text: "表白墙"),
                      Tab(text: "跳蚤市场"),
                      Tab(text: "失物招领"),
                    ]),
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            Center(
              child: Text("aaa:"),
            ),
            Center(
              child: Text("aaa:"),
            ),
            Center(
              child: Text("aaa:"),
            )
          ]),
        ));
  }
}

Widget _swiperWideget() {
  return FutureBuilder(
    future: SystermApi.getBanner(type: Configs.appTitle),
    builder: (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.connectionState == ConnectionState.done) {
        //json序列化
        Map<String, dynamic> data = DataUtils.snapToData(snapshot.data);
        //json对象化
        bean.Banner banner = bean.Banner.fromJson(data);
        List<bean.Data> swiperList = banner.data;
        return Container(
            width: Screens.width,
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  swiperList[index].picUrl,
                  fit: BoxFit.contain,
                );
              },
              itemCount: swiperList.length,
              viewportFraction: 0.8,
              scale: 0.8,
              autoplay: false,
              autoplayDisableOnInteraction: false,
              autoplayDelay: 3000,
            ));
      }
    },
  );
}

Widget _categoryGridWidget(String token) {
  Widget _categoryItembuild(categoryItemData) {
    return Container(
      height: 50,
      child: InkWell(
      onTap: () {},
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

  return FutureBuilder(
    future: SystermApi.getCategoryList(token: token),
    builder: (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.connectionState == ConnectionState.done) {
        //json序列化
        Map<String, dynamic> data = DataUtils.jsonToData(snapshot.data);
        //json对象化
        CategoryList categoryList = CategoryList.fromJson(data);
        List<Data> category = categoryList.data;
        // print(category[0].picUrl);
        return Container(
            width: Screens.width,
            height: 200,
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
  );
}


