import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class ForumDetailPage extends StatefulWidget {
  final Map arguments;
  ForumDetailPage({this.arguments});
  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  Row textField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: new TextField(
            decoration: InputDecoration(
              hintText: 'Say something here...', //提示文字
              border: null,
              focusedBorder: UnderlineInputBorder(
                //输入框被选中时的边框样式
                borderSide: BorderSide(color: Colors.blue[300]),
              ),
            ),
            keyboardType: TextInputType.text, //键盘的类型
            maxLength: 250, //最多字数
            maxLines: 10, //最高行数
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {},
        )
      ],
    );
  }

  Container bottomNewCommentButton() {
    return Container(
      child: RaisedButton(
        child: Text("Publish",
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
        color: Colors.blue[300],
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: Duration(milliseconds: 100),
                  child: Container(
                    child: textField(),
                    padding: EdgeInsets.all(7),
                  ),
                );
              });
        },
      ),
      height: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> commentBar(List comments) {
      List<Widget> commentBar = [];
      comments.forEach((val) {
        commentBar.add(Container(
          padding: EdgeInsets.all(5),
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(150),
          child: Text(val),
        ));
      });
      return commentBar;
    }

    print(widget.arguments['id'].toString());
    return Scaffold(
     
      bottomNavigationBar: BottomAppBar(
        child: bottomNewCommentButton(),
      ),
      appBar: AppBar(
        title: Text('文章详情页'),
      ),
      body: FutureBuilder(
        future: CmsApi.getArticle(widget.arguments['id'].toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            print(snapshot.data);
            var data = DataUtils.jsonToData(snapshot.data);
            return Container(
              width: ScreenUtil.screenWidth,
              height: ScreenUtil.screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(),
                    Text(
                      data['data']['title'],
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                    Divider(
                      height: 1.0,
                      indent: 60.0,
                      color: Colors.red,
                    ),
                    Html(data: data['data']['content']),
                    Divider(
                      height: 1.0,
                      indent: 60.0,
                      color: Colors.red,
                    ),
                    FutureBuilder(
                      future: CmsApi.getCommentList(
                          refld: widget.arguments['id'].toString()),
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
                          var data = DataUtils.jsonToData(snapshot.data);
                          print(data);
                          if (data['code'] == 0) {
                            return Column(children: commentBar(data['data']));
                          } else {
                            return Container(
                              child: Center(
                                child: Text('暂时没有评论'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
