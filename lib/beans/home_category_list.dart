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

class CategoryList {
  CategoryList({
    this.code,
    this.data,
    this.msg,
  });

  factory CategoryList.fromJson(Map<String, dynamic> jsonRes) {
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
    return CategoryList(
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
    this.name,
    this.picUrl,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Data(
          name: asT<String>(jsonRes['name']),
          picUrl: asT<String>(jsonRes['picUrl']),
        );

  String name;
  String picUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'picUrl': picUrl,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
