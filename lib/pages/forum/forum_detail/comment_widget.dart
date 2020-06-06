import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List comments = Provider.of<ForumDetailsProvider>(context).commentList;
    return Container(
      child: Card(
        child: Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(500),
          padding: EdgeInsets.all(5),
          child: comments==[]?noComment():commentList(comments)
        ),
      ),
    );
  }
  Widget commentList(List commentList){
    return ListView.builder(
            itemCount: commentList.length,
            itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(commentList[index]),
            );
           },
    );
  }
  Widget noComment(){
    return Text("暂时没有评论,快来抢沙发吧");
  }
}