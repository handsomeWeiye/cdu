import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:device_info/device_info.dart';
import 'package:cdu_helper/constants/constants.dart';

class DeviceUtils{
  const DeviceUtils._();
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static dynamic deviceInfo;

  static String deviceModel = 'CduHelper Device';
  static String devicePushToken;
  static String deviceUuid;

    static Future<void> initDeviceInfo() async {
    await getModel();
    // await getDevicePushToken();
    // await getDeviceUuid();
  }

    static Future<void> getModel() async {
    if (Platform.isAndroid) {
      deviceInfo = await _deviceInfoPlugin.androidInfo;
      final AndroidDeviceInfo androidInfo = deviceInfo as AndroidDeviceInfo;

      final String model = '${androidInfo.brand} ${androidInfo.product}';
      deviceModel = model;
    } else if (Platform.isIOS) {
      deviceInfo = await _deviceInfoPlugin.iosInfo;
      final IosDeviceInfo iosInfo = deviceInfo as IosDeviceInfo;

      final String model = '${iosInfo.model} ${iosInfo.utsname.machine} ${iosInfo.systemVersion}';
      deviceModel = model;
    }
    print('deviceModel: $deviceModel');
    debugPrint('deviceModel: $deviceModel');
  }

  // static Future<void> getDevicePushToken() async {
  //   if (Platform.isIOS) {
  //     final String _savedToken = HiveFieldUtils.getDevicePushToken();
  //     final String _tempToken = await ChannelUtils.iOSGetPushToken();
  //     if (_savedToken != null) {
  //       if (_savedToken != _tempToken) {
  //         await HiveFieldUtils.setDevicePushToken(_tempToken);
  //       } else {
  //         devicePushToken = HiveFieldUtils.getDevicePushToken();
  //       }
  //     } else {
  //       await HiveFieldUtils.setDevicePushToken(_tempToken);
  //     }
  //     debugPrint('devicePushToken: $devicePushToken');
  //   }
  // }

    // static Future<void> getDeviceUuid() async {
    // if (HiveFieldUtils.getDeviceUuid() != null) {
    //   deviceUuid = HiveFieldUtils.getDeviceUuid();
    // } else {
    //   if (Platform.isIOS) {
    //     deviceUuid = (deviceInfo as IosDeviceInfo).identifierForVendor;
    //   } else {
    //     await HiveFieldUtils.setDeviceUuid(Uuid().v4());
    //   }
    // }
    // debugPrint('deviceUuid: $deviceUuid');
  // }
}
