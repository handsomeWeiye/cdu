import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //首先检测是否曾经登录
        SpUtils.isLogin().then((res) {
          if (res) {
            //判断token是否有效
            UserApi.getUserDetail(token: SpUtils.getTokenSync()).then((res) {
              var data = DataUtils.jsonToData(res);
              if (data['code']==0) {
                //判断是否绑定教务系统
                SpUtils.isBind().then((res) {
                  if (res) {
                    navigatorState.pushReplacementNamed('/index');
                  } else {
                    navigatorState.pushReplacementNamed('/bindStudent');
                  }
                });
              }else{
                navigatorState.pushReplacementNamed('/login');
              }
            });
          } else {
            navigatorState.pushReplacementNamed('/login');
          }
        }).catchError((onError){
          showToast('抱歉，出了点问题$onError');
        });
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 750,height: 1500);
    return Container(
      child: FadeTransition(
        opacity: _animation,
        child: Image.asset(
          r'lib\images\splash\splash_image.png',
          scale: 2.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
