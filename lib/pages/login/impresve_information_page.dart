import 'dart:io';
import 'dart:async';
import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImpresveInformationPage extends StatefulWidget {
  @override
  _ImpresveInformationPageState createState() =>
      _ImpresveInformationPageState();
}

class _ImpresveInformationPageState extends State<ImpresveInformationPage> {
  String nickName = '';
  String sex = '';
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('完善个人信息'),
      ),
      body: Column(
        children: <Widget>[
          headPortrait(),
          nichNameInputCase(),
          choiceSex(),
          confirmBotton()
        ],
      ),
    );
  }

  Widget headPortrait() {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    /// 自定义的默认头像组件，用来显示默认图片。
    Widget defaultImage = Stack(
      children: <Widget>[
        Align(
          // 默认头像图片放在左上方。
          alignment: Alignment.center,
          child: Image.asset(r'lib\images\loginAndRegister\moren.png',
              fit: BoxFit.contain,
              height: 130.0,
              width: ScreenUtil().setWidth(150)),
        ),
        Align(
          // 编辑头像图片放在右下方。
          alignment: Alignment.bottomRight,
          child: Image.asset(r'lib\images\loginAndRegister\bianji.png',
              fit: BoxFit.contain,
              height: 48.0,
              width: ScreenUtil().setWidth(100)),
        ),
      ],
    );

    /// 自定义的椭圆形头像组件，用来裁剪显示头像。
    Widget ovalImage(File image) {
      return Stack(
        children: <Widget>[
          Container(
            // 通过容器（`Container`）组件的填充（`padding`）属性，使头像对齐边框。
            padding: EdgeInsets.fromLTRB(9.0, 10.5, 0.0, 0.0),
            // 剪辑椭圆形（`ClipOval`）组件，使用椭圆剪辑其子项的组件。
            child: ClipOval(
              // 图片.文件（`Image.file`）构造函数，创建一个窗口组件，显示从文件获取的图片流。
              child: Image.file(
                image,
                fit: BoxFit.cover,
                height: 109.0,
                width: 109.0,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: getImage,
          child: Container(
            width: ScreenUtil().setWidth(250.0),
            height: ScreenUtil().setHeight(260.0),
            child: _image == null
                // 第3步实现的自定义组件。
                ? defaultImage
                // 第4步实现的自定义组件。
                : ovalImage(_image),
          ),
        ),
      ],
    );
  }

  Widget nichNameInputCase() {
    return Container(
      width: ScreenUtil().setWidth(700),
      child: TextFormField(
        decoration: InputDecoration(hintText: '您的昵称'),
        onChanged: (String val) {
          nickName = val;
          print(nickName);
        },
      ),
    );
  }

  Widget choiceSex() {
    Widget gestureBoyDetector() {
      return Container(
        width: ScreenUtil().setWidth(150),
        child: GestureDetector(
          onTap: () {
            setState(() {
              sex = '男';
            });
          },
          child: Column(
            children: <Widget>[
              sex == '男'
                  ? Image.asset(r'lib\images\loginAndRegister\boySeletd.png')
                  : Image.asset(r'lib\images\loginAndRegister\boy.png'),
              Text(
                '男',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: sex == '男' ? Color(0xFF25C6CA) : Color(0xFF4A4A4A)),
              )
            ],
          ),
        ),
      );
    }

    Widget gestureGirlDetector() {
      return Container(
        width: ScreenUtil().setWidth(150),
        child: GestureDetector(
          onTap: () {
            setState(() {
              sex = '女';
            });
          },
          child: Column(
            children: <Widget>[
              sex == '女'
                  ? Image.asset(r'lib\images\loginAndRegister\girlSeleted.png')
                  : Image.asset(r'lib\images\loginAndRegister\girl.png'),
              Text(
                '女',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: sex == '女' ? Color(0xFFFF6B47) : Color(0xFF4A4A4A)),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      width: ScreenUtil().setWidth(700),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          gestureBoyDetector(),
          SizedBox(
            width: 100,
          ),
          gestureGirlDetector()
        ],
      ),
    );
  }

  Widget confirmBotton() {
    return Center(
        child: Container(
            padding: EdgeInsets.only(top: 50),
            child: ButtonTheme(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  if (_image != null) {
                    SystermApi.uploadImage(_image).then((val) {
                      print(val);
                      var data = DataUtils.jsonToData(val);
                      String imageUrl =  data['data']['url'];
                      if (data['code'] == 0) {
                        showToast('上传照片成功');
                        UserApi.updateUserDetail(
                                token: SpUtils.getTokenSync(),
                                avatarUrl: imageUrl,
                                nick: nickName,
                                city: '成都',
                                province: '四川')
                            .then((val) {
                          var data = DataUtils.jsonToData(val);
                          if (data['code'] == 0) {
                            showToast('更新信息成功');
                            SpUtils.addUserUrl(imageUrl);
                            SpUtils.addUserNickName(nickName);
                            navigatorState.pushReplacementNamed('/index');
                          } else {
                            showToast('更新信息失败');
                          }
                        });
                      } else {
                        showToast('上传照片失败');
                      }
                    });
                  }else{
                    showToast('添加您的头像呦');
                  }
                },
                child: Text(
                  '确定',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(50),
                      fontFamily: 'HuaWenXinWei'),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                ),
              ),
              minWidth: ScreenUtil().setWidth(408),
              height: ScreenUtil().setHeight(140),
            )));
  }
}
