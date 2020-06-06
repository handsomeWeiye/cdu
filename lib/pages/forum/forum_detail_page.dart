import 'package:cdu_helper/pages/forum/forum_detail/author_widget.dart';
import 'package:cdu_helper/pages/forum/forum_detail/bottom_widget.dart';
import 'package:cdu_helper/pages/forum/forum_detail/comment_widget.dart';
import 'package:cdu_helper/pages/forum/forum_detail/content_widget.dart';
import 'package:cdu_helper/pages/forum/forum_detail/title_widget.dart';
import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:cdu_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class ForumDetailPage extends StatefulWidget {
  final Map arguments;
  ForumDetailPage({this.arguments});
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomAppBar(
        child:BottomWidget(),
      ),
      appBar: AppBar(
        title: Text('文章详情页'),
      ),
      body: SingleChildScrollView(
        child:  Provider.of<ForumDetailsProvider>(context).initCompleted==false?loadingWidget():
        Column(
          children: <Widget>[
            AuthorWidget(),
            TitleWidget(),
            ContentWidget(),
            // CommentWidget()
          ],
        )
      ),
    );
  }
}

// FutureBuilder(
//         future: CmsApi.getArticle(widget.arguments['id'].toString()),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               width: ScreenUtil.screenWidth,
//               height: ScreenUtil.screenHeight,
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             print(snapshot.data);
//             var data = DataUtils.jsonToData(snapshot.data);
//             return Container(
//               width: ScreenUtil.screenWidth,
//               height: ScreenUtil.screenHeight,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     Row(),
//                     Text(
//                       data['data']['title'],
//                       style: TextStyle(
//                           fontSize: ScreenUtil().setSp(32),
//                           fontWeight: FontWeight.bold),
//                       overflow: TextOverflow.clip,
//                       maxLines: 2,
//                     ),
//                     Divider(
//                       height: 1.0,
//                       indent: 60.0,
//                       color: Colors.red,
//                     ),
//                     Html(data: data['data']['content']),
//                     Divider(
//                       height: 1.0,
//                       indent: 60.0,
//                       color: Colors.red,
//                     ),
//                     FutureBuilder(
//                       future: CmsApi.getCommentList(
//                           refld: widget.arguments['id'].toString()),
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Container(
//                             width: ScreenUtil.screenWidth,
//                             height: ScreenUtil.screenHeight,
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           );
//                         }
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           var data = DataUtils.jsonToData(snapshot.data);
//                           print(data);
//                           if (data['code'] == 0) {
//                             return Column(children: commentBar(data['data']));
//                           } else {
//                             return Container(
//                               child: Center(
//                                 child: Text('暂时没有评论'),
//                               ),
//                             );
//                           }
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
