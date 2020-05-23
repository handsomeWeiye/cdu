import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('会员中心'),
     ),
     body:ListView(
       children: <Widget>[
         _topHeader(),_orderType(),_myListTile('领取优惠券'),_myListTile('已领取优惠券'),_myListTile('地址管理'),_myListTile('客服电话'),_myListTile('关于我们')
       ],
     ),
     
   );
  }

   Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(500),
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Column(
        children: <Widget>[
           Container(
             margin: EdgeInsets.only(top: 30),
             child: ClipOval(
               child: Image.network('https://i.ibb.co/s2mp4Qq/1.png',width: ScreenUtil().setWidth(200),),
             ),
           ),
           Container(
             margin: EdgeInsets.only(top: 10.0),
             child: Text(
               '伟业',
               style: TextStyle(
                 fontSize: ScreenUtil().setSp(36),
                 color: Colors.white,
               ),
             ),
           )
        ],
      ),
    );
  }

  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )

      ),
      child: ListTile(
        leading: ListTile(
          leading: Icon(Icons.list),
          title: Text('我的订单'),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(187),
      padding: EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,size: 30,),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,size:30.0),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car,size: 30,),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,size: 30.0,
                ),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myListTile(String title){
    return InkWell(
      onTap: (){
      },
      child: Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    ),
    );

  }
}

