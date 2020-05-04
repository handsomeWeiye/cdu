import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint('$e');
    debugPrint('$stack');
  }
}

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    final String valueS = value.toString();
    if (0 is T) {
      return int.tryParse(valueS) as T;
    } else if (0.0 is T) {
      return double.tryParse(valueS) as T;
    } else if ('' is T) {
      return valueS as T;
    } else if (false is T) {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return bool.fromEnvironment(value.toString()) as T;
    }
  }
  return null;
}

class Banner {
  Banner({
    this.code,
    this.data,
    this.msg,
  });

  factory Banner.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<Data> data = jsonRes['data'] is List ? <Data>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(Data.fromJson(asT<Map<String, dynamic>>(item)));
          });
        }
      }
    }
    return Banner(
      code: asT<int>(jsonRes['code']),
      data: data,
      msg: asT<String>(jsonRes['msg']),
    );
  }

  int code;
  List<Data> data;
  String msg;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'data': data,
        'msg': msg,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class Data {
  Data({
    this.businessId,
    this.dateAdd,
    this.dateUpdate,
    this.id,
    this.linkUrl,
    this.paixu,
    this.picUrl,
    this.remark,
    this.status,
    this.statusStr,
    this.title,
    this.type,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Data(
          businessId: asT<int>(jsonRes['businessId']),
          dateAdd: asT<String>(jsonRes['dateAdd']),
          dateUpdate: asT<String>(jsonRes['dateUpdate']),
          id: asT<int>(jsonRes['id']),
          linkUrl: asT<String>(jsonRes['linkUrl']),
          paixu: asT<int>(jsonRes['paixu']),
          picUrl: asT<String>(jsonRes['picUrl']),
          remark: asT<String>(jsonRes['remark']),
          status: asT<int>(jsonRes['status']),
          statusStr: asT<String>(jsonRes['statusStr']),
          title: asT<String>(jsonRes['title']),
          type: asT<String>(jsonRes['type']),
          userId: asT<int>(jsonRes['userId']),
        );

  int businessId;
  String dateAdd;
  String dateUpdate;
  int id;
  String linkUrl;
  int paixu;
  String picUrl;
  String remark;
  int status;
  String statusStr;
  String title;
  String type;
  int userId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'businessId': businessId,
        'dateAdd': dateAdd,
        'dateUpdate': dateUpdate,
        'id': id,
        'linkUrl': linkUrl,
        'paixu': paixu,
        'picUrl': picUrl,
        'remark': remark,
        'status': status,
        'statusStr': statusStr,
        'title': title,
        'type': type,
        'userId': userId,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
