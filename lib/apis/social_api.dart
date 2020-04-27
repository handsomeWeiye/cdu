import 'package:flutter/services.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:flutter/material.dart';

MethodChannel channel = MethodChannel('jmessage_flutter');
JmessageFlutter Jmessage = JmessageFlutter();

class SocialApi {
  SocialApi(){init();}
  static init() {
    Jmessage.setDebugMode(enable: true);
    Jmessage.init(isOpenMessageRoaming: true, appkey: Constants.jAppKey);
    Jmessage.applyPushAuthority(
        JMNotificationSettingsIOS(sound: true, alert: true, badge: true));
  }

  static register(String mobile) async {
    await Jmessage.userRegister(
        username: mobile, password: Constants.socialPwd);
  }

  static login(String mobile) async {
    await Jmessage.login(username: mobile, password: Constants.socialPwd);
  }

  static loginOut() async {
    await Jmessage.logout();
  }

  static createMessage(JMMessageType type, String target,
      {String path,
      String text,
      double latitude,
      double longitude,
      int scale,
      String address,
      String fileName}) async {
    var message = await Jmessage.createMessage(
        type: type,
        targetType: target,
        path: path,
        text: text,
        latitude: latitude,
        longitude: longitude,
        scale: scale,
        address: address,
        fileName: fileName);

    return message;
  }

  static sendMessage(
    message,
  ) async {
    var sendedMessage = await Jmessage.sendMessage(
        message: message,
        sendOption: JMMessageSendOptions.fromJson({
          'isShowNotification': true,
          'isRetainOffline': true,
        }));

    return sendedMessage;
  }

  static retractMessage(dynamic target,String serverMessageId)async{
    await Jmessage.retractMessage(target: target, serverMessageId: serverMessageId);
  }

  static getHistoryMessages(dynamic target,int from,int limit)async{
    await Jmessage.getHistoryMessages(type: target, from: from, limit: limit);
  }

  static downloadOriginalImage(dynamic target,String messageId)async{
    await Jmessage.downloadOriginalImage(target: target, messageId: messageId);
  }
  static downloadFile(dynamic target,String messageId)async{
    Map res = await Jmessage.downloadFile(target: target, messageId: messageId);
    return res;
  }
  
}
