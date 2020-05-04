import 'package:flutter/material.dart';

class MeanBar extends StatefulWidget {
  double width = 300.0; //底部宽度
  double height = 50.0; //底部高度
  double buttonSize = 150; //按钮大小
  Color backgroundColor = Colors.grey; //底部背景色
  Color fontColor = Colors.black; //底部文字颜色
  double fontSize = 16.0; //底部文字大小
  Color buttonFontColor = Colors.black; //按钮文字颜色
  Color buttonColor = Colors.white; //按钮颜色
  double buttonFontSize = 16.0; //按钮文字大小
  double radiusCircle = 25.0; //组件圆角程度
  int milliseconds = 500; //动画速度
  double padding = 5; //按钮距外围距离
  bool isSingIn = true; //目前的状态
  final callback;

  MeanBar(
      {this.width = 300,
      this.height = 50.0,
      this.buttonSize = 125,
      this.backgroundColor = Colors.grey,
      this.buttonFontColor = Colors.black,
      this.buttonColor = Colors.white,
      this.buttonFontSize = 16.0,
      this.fontColor = Colors.black,
      this.fontSize = 16.0,
      this.isSingIn = true,
      this.milliseconds = 500,
      this.padding = 5,
      this.radiusCircle = 25,this.callback});

  @override
  _MeanBarState createState() => _MeanBarState();
}

class _MeanBarState extends State<MeanBar> {
  void firedParent(){
    widget.callback(widget.isSingIn);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[bottomBar(), topFlatButton()],
    );
  }

  Widget bottomBar() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(widget.radiusCircle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bottomGesture('登录'),
          bottomGesture('注册'),
        ],
      ),
    );
  }

  Widget bottomGesture(String name) {
    return Text(name,
        style: TextStyle(color: widget.fontColor, fontSize: widget.fontSize));
  }

  Widget topFlatButton() {
    return GestureDetector(
      onTapUp: (detail) {
        // print(detail.localPosition.dx);
        if (detail.localPosition.dx > widget.width / 2) {
          setState(() {
            widget.isSingIn = false;
            firedParent();
          });
        } else {
          setState(() {
            widget.isSingIn = true;
            firedParent();
          });
        }
      },
      child: AnimatedContainer(
          width: widget.width,
          height: widget.height,
          duration: Duration(milliseconds: widget.milliseconds),
          curve: Curves.fastOutSlowIn, //动画曲线
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radiusCircle)),
          ),
          alignment:
              widget.isSingIn ? Alignment.centerLeft : Alignment.centerRight,
          padding: EdgeInsets.all(widget.padding),
          child: SizedBox(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  widget.isSingIn = !widget.isSingIn;
                  firedParent();
                });
              },
              color: widget.buttonColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.radiusCircle))), //圆角大小
              child: Text(
                widget.isSingIn ? '登录' : '注册',
                style: TextStyle(
                    color: widget.buttonFontColor,
                    fontSize: widget.buttonFontSize),
              ),
            ),
            width: widget.buttonSize,
          )),
    );
  }
}
