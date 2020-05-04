import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataUtils{
  static  Map<String, dynamic> jsonToData(Response<dynamic> dataString) =>
      Map<String, dynamic>.from(json.decode(dataString.data.toString()));
  static  Map<String, dynamic> snapToData(Response<dynamic> snapData) =>
      Map<String, dynamic>.from(snapData.data);
}