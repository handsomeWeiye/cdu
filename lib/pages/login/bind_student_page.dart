import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:flutter/material.dart';

class BindStudentPage extends StatefulWidget {
  @override
  _BindStudentPageState createState() => _BindStudentPageState();
}

class _BindStudentPageState extends State<BindStudentPage> {
  String account = '';
  String pwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: Text('绑定教务系统'),
      ),
      body: Container(
        width: Screens.width,
        height: Screens.height,
        padding: EdgeInsets.only(bottom: 200),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            elevation: 5.0,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        labelText: '学号'),onChanged: (val){
                          account = val;
                        },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        prefixIcon: Icon(Icons.lock),
                        labelText: '密码'),onChanged: (val){
                          pwd = val;
                        },
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:50),
                  child: SizedBox(
                    width: Screens.width * 0.7,
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                      ),
                      onPressed: () {
                        UserApi.getUserInfo(account, pwd).then((res) {
                          print(res.data.toString());
                          var data = DataUtils.jsonToData(res);
                          print(data);
                          if (data['code'] == 200) {
                            SpUtils.saveStudentAccount(account,pwd);
                            showToast('绑定教务系统账号成功');
                            navigatorState.pushReplacementNamed('/info');
                          } else {
                            showToast('绑定教务系统账号失败');
                          }
                        });
                      },
                      color: Colors.green,
                      child: Text(
                        '绑定教务系统',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
