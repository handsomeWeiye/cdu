
import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
 Row textField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: new TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: '友善的评论是沟通的起点哦...', //提示文字
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
          onPressed: (){
            print(_textEditingController.text);
            Provider.of<ForumDetailsProvider>(context,listen: false).addComment(_textEditingController.text);
          },
        )
      ],
    );
  }

  Container bottomNewCommentButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("发表您的评论",
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

    return Container(
      padding: EdgeInsets.all(5),
      child: bottomNewCommentButton(context)
    );

  }


}