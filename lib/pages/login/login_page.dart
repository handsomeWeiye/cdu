import 'dart:async';
import 'dart:convert';

import 'package:cdu_helper/apis/systerm_api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:cdu_helper/widgets/mean_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer _timer; //计时器
  int _countdownTime = 0; //目前倒计时数
  bool isAbled = true; //获取验证码按钮是否可用
  bool isSingIn = true; //是否登录界面
  bool isOcured = false; //是否密码可见
  String mobile = ''; //手机号
  String pwd = ''; //密码
  String rePwd = ''; //再次输入的密码
  String code = ''; //短信验证码
  TextEditingController mobileController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);



  void isSingInChanged(val) {
    setState(() {
      this.isSingIn = val;
      if (val) {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      } else {
        _pageController.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      }
    });
  } //菜单栏的回调函数

  //整体布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Container(
          width: Screens.width,
          height: Screens.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MeanBar(
                isSingIn: isSingIn,
                callback: (val) => isSingInChanged(val),
              ),
              Container(
                width: Screens.width * 0.8,
                height: Screens.height * 0.4,
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    Center(
                      child: _singIn(),
                    ),
                    Center(
                      child: _singUp(),
                    )
                  ],
                  onPageChanged: (val) {
                    if (val == 0) {
                      setState(() {
                        isSingIn = true;
                      });
                    } else {
                      setState(() {
                        isSingIn = false;
                      });
                    }
                  },
                ),
              ),
              _confirmBotton()
            ],
          ),
        ));
  }

  //登录卡片

  Widget _singIn() {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        width: Screens.width * 0.8,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: mobileController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelText: '手机号',
              ),
              onChanged: (val) {
                print(val);
                setState(() {
                  mobile = val;
                });
              },
            ),
            TextField(
              autofocus: false,
              controller: pwdController,
              decoration: InputDecoration(
                
                prefixIcon: Icon(Icons.lock),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelText: '密码',
                contentPadding: EdgeInsets.all(5.0),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isOcured = !isOcured;
                    });
                  },
                  child: isOcured
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              obscureText: true,
              onChanged: (val) {
                print(val);
                setState(() {
                  pwd = val;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  //注册卡片
  Widget _singUp() {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        width: Screens.width * 0.8,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelText: '手机号',
              ),
              onChanged: (val) {
                print(val);
                setState(() {
                  mobile = val;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelText: '密码',
                contentPadding: EdgeInsets.all(5.0),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isOcured = !isOcured;
                    });
                  },
                  child: isOcured
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              obscureText: true,
              onChanged: (val) {
                print(val);
                setState(() {
                  pwd = val;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelText: '确认密码',
                contentPadding: EdgeInsets.all(5.0),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isOcured = !isOcured;
                    });
                  },
                  child: isOcured
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              obscureText: true,
              onChanged: (val) {
                print(val);
                setState(() {
                  rePwd = val;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.message,
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelText: '验证码',
                  contentPadding: EdgeInsets.all(5.0),
                  suffixIcon: isAbled
                      ? InkWell(
                          onTap: () {
                            if (mobile.length == 11) {
                              SystermApi.getSMS(mobile).then((res) {
                                var data = DataUtils.jsonToData(res);
                                if (data['code'] == 0) {
                                  showToast('发送验证码成功');
                                }
                              });
                              setState(() {
                                isAbled = false;
                                _countdownTime = 60;
                                countDown();
                              });
                            } else {
                              showToast('手机号未填写');
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              '获取验证码',
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            '重新发送($_countdownTime)',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        )),
              onChanged: (val) {
                print(val);
                setState(() {
                  code = val;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  //计时器
  Widget countDown() {
    const oneSec = const Duration(seconds: 1);
    Function callback = (Timer timer) {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
          isAbled = true;
        } else {
          _countdownTime = _countdownTime - 1;
          print(_countdownTime);
        }
      });
    };

    _timer = Timer.periodic(oneSec, callback);
  }

  //确定按钮
  Widget _confirmBotton() {
    return SizedBox(
      width: Screens.width * 0.7,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          if (isSingIn) {
            if (mobile != '' && pwd != '') {
              UserApi.login(mobile, pwd).then((res) {
                var data = DataUtils.jsonToData(res);
                print(data[code]);
                if (data['code'] == 0) {
                  showToast('登录成功');
                  SpUtils.saveToken(data['data']['token']);
                  SpUtils.isBind().then((res) {
                    if (res) {
                      navigatorState.pushReplacementNamed('/home');
                    } else {
                      showToast('请绑定您的教务系统账号');
                      navigatorState.pushReplacementNamed('/bind');
                    }
                  });
                } else {
                  showToast('登录失败,${data['msg']}');
                }
              });
            } else {
              if (mobile == '') {
                showToast('未填写手机号');
              } else {
                showToast('未填写密码');
              }
            }
          } else {
            if (mobile != '' && pwd != '' && rePwd != '' && code != '') {
              if (pwd == rePwd) {
                UserApi.register(mobile, code, pwd).then((res) {
                  print(res);
                  var data = DataUtils.jsonToData(res);
                  if (data['code'] == 0) {
                    showToast('注册成功');
                    setState(() {
                      isSingIn = true;
                    });
                    UserApi.login(mobile, pwd).then((res) {
                      var data = DataUtils.jsonToData(res);
                      if (data['code'] == 0) {
                        SpUtils.saveToken(data['data']['token']);
                        navigatorState.pushNamed('/bindStudent');
                      } else {
                        showToast('网络开小差了');
                      }
                    });
                  } else {
                    showToast('注册失败${data['msg']}');
                  }
                });
              } else {
                showToast('密码与确认密码不一致');
              }
            } else {
              showToast('注册信息不完整');
            }
          }
        },
        child: Text(
          isSingIn ? '登录' : '注册',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(70)),
        ),
      ),
    );
  }
}
