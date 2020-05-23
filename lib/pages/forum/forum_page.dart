import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/pages/login/impresve_information_page.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'like_bar.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: null,child: Icon(Icons.add),),
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: ScreenUtil().setHeight(200),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                //头部整个背景颜色
                height: double.infinity,
                color: Colors.yellowAccent,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '论坛',
                          style: TextStyle(fontSize: 35),
                        ),
                        Icon(Icons.search)
                      ],
                    )
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
                  Tab(text: "推荐"),
                  Tab(text: "排行榜"),
                ]),
          )
        ];
      },
      body: FutureBuilder(
        future: CmsApi.getArticleList(),
        builder:
            (BuildContext context, AsyncSnapshot<Response<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: ScreenUtil.screenWidth,
              height: ScreenUtil.screenHeight,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = DataUtils.jsonToData(snapshot.data);
              if (data['code'] == 0) {
                return ListView.builder(
                  itemCount: data['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder(
                      future:
                          UserApi.getUserDetail(token: SpUtils.getTokenSync()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: ScreenUtil.screenWidth,
                            height: ScreenUtil.screenHeight,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          var userDetail = DataUtils.jsonToData(snapshot.data);
                          return Container(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil.screenWidth,
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: (){
                                print(data['data'][index]['id']);
                                navigatorState.pushNamed('/detail',arguments: {'id':data['data'][index]['id']});
                                // Navigator.pushNamed(context, '/detail', arguments: {'id': 123});
                              },
                              child:  Card(
                              color: Colors.yellow,
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  userDetail['data']['base']
                                                      ['avatarUrl']),
                                            ),
                                            Text(userDetail['data']['base']
                                                ['city'])
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(data['data'][index]['title'],style: TextStyle(fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold),overflow: TextOverflow.clip,maxLines: 2,),
                                    Text(data['data'][index]['descript'],style: TextStyle(color:Colors.grey),overflow: TextOverflow.clip,maxLines: 3,),
                                    likeBar(likeCount: data['data'][index]['usefulNumber'],commentCount: data['data'][index]['commentNumber'],favoriteCount: data['data'][index]['numberFav'],id: data['data'][index]['id'])
                                  ],
                                ),
                              ),
                            ),
                            )
                          );
                        }
                      },
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('暂时没有文章'),
                  ),
                );
              }
            } else {
              return Container(
                child: Center(
                  child: Text('网络开小差了'),
                ),
              );
            }
          }
        },
      ),
    ));
  }
}
