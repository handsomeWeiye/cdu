import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:cdu_helper/constants/constants.dart';

class SettingProvider extends ChangeNotifier{
  void init(){
    getAnnouncement();
  }
  Future<void> getAnnouncement()async{
    try{
      final Map<String,dynamic>data= jsonDecode(await NetUtils.get(API.geta))
    }
  }
}
