import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForumAddPage extends StatefulWidget {
  @override
  _ForumAddPageState createState() => _ForumAddPageState();
}

class _ForumAddPageState extends State<ForumAddPage> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加您的文章'),
      ),
      body: Container(
        color: Colors.grey[100],
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              titleTextFiled(),
              contentTextFiled(),
              confirmButtion()
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTextFiled(){
    return Card(
      child:  Container(
        height: ScreenUtil().setHeight(200),
        child:  TextFormField(
      controller: titleEditingController,
       decoration: InputDecoration(
          border: InputBorder.none,
         hintText: '输入您的标题',
       ),
    ),
      ),
    );
  }
    Widget contentTextFiled(){
    return Card(
      child: Container(
      height: ScreenUtil().setHeight(800),
      child: TextFormField(
      controller: contentEditingController,
       decoration: InputDecoration(
          border: InputBorder.none,
         hintText: '输入您的内容',
       ),
    
    ),
    ),
    );
  }
  Widget confirmButtion(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(600),
      child:  RaisedButton(onPressed: (){
      if( titleEditingController.value.text!=null &&contentEditingController.value.text!=null){
        Provider.of<ForumDetailsProvider>(context,listen: false).addArticle(titleEditingController.value.text, contentEditingController.value.text);
      }else{
        showToast('不能为空');
      }
    },child: Text('发布帖子',style: TextStyle(color: Colors.white),), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                ),color: Colors.blue,),
    );
  }
}