import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/beans/article_list.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'forum_index/like_bar.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
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
      backgroundColor: Colors.grey[100],
       floatingActionButton: FloatingActionButton(onPressed:(){
         navigatorState.pushNamed('/addArticle');
       },child: Icon(Icons.add),),
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
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                //头部整个背景颜色
                height: double.infinity,
                color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '成大论坛',
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
                onTap: (val){
                  setState(() {
                    currentIndex = val;
                    _tabController.animateTo(currentIndex);
                  });
                },
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
      body: PageView(
            onPageChanged: (val) {
                    setState(() {
                      currentIndex = val;
                      _pageController.animateToPage(val,duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                      _tabController.animateTo(val);
                    });
                  },
        controller: _pageController,
        children: <Widget>[
          articleListWideget('newer'),
          articleListWideget('viewUp'),
        ],
      )
    ));
  }

  Widget articleListWideget(String orderBy){
    return FutureBuilder(
        future: CmsApi.getArticleList(orderBy: orderBy),
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
              Map<String,dynamic> data = DataUtils.jsonToData(snapshot.data);
              ArticleList articleList =  ArticleList.fromJson(data);
              print(articleList.code);
              print(articleList.data.length);
              if (articleList.code == 0) {
                return ListView.builder(
                  itemCount: articleList.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(articleList.data[index].userId.toString());
                    return FutureBuilder(
                      future: UserApi.getUserDetail(id: articleList.data[index].userId.toString(),xtoken: SpUtils.getTokenSync()),
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
                          // var userDetail = DataUtils.jsonToData(snapshot.data);
                          return Container(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil.screenWidth,
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: (){
                                print(articleList.data[index].id);
                                Provider.of<ForumDetailsProvider>(context,listen: false).init(articleList.data[index].id);
                                navigatorState.pushNamed('/detail',arguments: {'id':articleList.data[index].id});
                                // Navigator.pushNamed(context, '/detail', arguments: {'id': 123});
                              },
                              child:  Card(
                              color: Colors.white,
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
                                            // CircleAvatar(
                                            //   radius: 20,
                                            //   backgroundImage: NetworkImage(
                                            //       userDetail['data']['base']
                                            //           ['avatarUrl']),
                                            // ),
                                            // Text(userDetail['data']['base']
                                            //     ['city'])
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(articleList.data[index].title,style: TextStyle(fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold),overflow: TextOverflow.clip,maxLines: 2,),
                                    Text(articleList.data[index].descript,style: TextStyle(color:Colors.grey),overflow: TextOverflow.clip,maxLines: 3,),
                                    likeBar(likeCount: articleList.data[index].usefulNumber,commentCount: articleList.data[index].commentNumber,favoriteCount: articleList.data[index].numberFav,id: articleList.data[index].id)
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
      );
  }
}
