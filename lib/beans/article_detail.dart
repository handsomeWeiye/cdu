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

class ArticleDetail {
  ArticleDetail({
    this.code,
    this.data,
    this.msg,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ArticleDetail(
              code: asT<int>(jsonRes['code']),
              data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
              msg: asT<String>(jsonRes['msg']),
            );

  int code;
  Data data;
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
    this.categoryId,
    this.commentNumber,
    this.content,
    this.dateAdd,
    this.dateUpdate,
    this.descript,
    this.extInfo,
    this.id,
    this.isRecommend,
    this.keywords,
    this.numberFav,
    this.paixu,
    this.status,
    this.statusStr,
    this.title,
    this.uid,
    this.unusefulNumber,
    this.usefulNumber,
    this.userId,
    this.views,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Data(
          categoryId: asT<int>(jsonRes['categoryId']),
          commentNumber: asT<int>(jsonRes['commentNumber']),
          content: asT<String>(jsonRes['content']),
          dateAdd: asT<String>(jsonRes['dateAdd']),
          dateUpdate: asT<String>(jsonRes['dateUpdate']),
          descript: asT<String>(jsonRes['descript']),
          extInfo:
              ExtInfo.fromJson(asT<Map<String, dynamic>>(jsonRes['extInfo'])),
          id: asT<int>(jsonRes['id']),
          isRecommend: asT<bool>(jsonRes['isRecommend']),
          keywords: asT<String>(jsonRes['keywords']),
          numberFav: asT<int>(jsonRes['numberFav']),
          paixu: asT<int>(jsonRes['paixu']),
          status: asT<int>(jsonRes['status']),
          statusStr: asT<String>(jsonRes['statusStr']),
          title: asT<String>(jsonRes['title']),
          uid: asT<int>(jsonRes['uid']),
          unusefulNumber: asT<int>(jsonRes['unusefulNumber']),
          usefulNumber: asT<int>(jsonRes['usefulNumber']),
          userId: asT<int>(jsonRes['userId']),
          views: asT<int>(jsonRes['views']),
        );

  int categoryId;
  int commentNumber;
  String content;
  String dateAdd;
  String dateUpdate;
  String descript;
  ExtInfo extInfo;
  int id;
  bool isRecommend;
  String keywords;
  int numberFav;
  int paixu;
  int status;
  String statusStr;
  String title;
  int uid;
  int unusefulNumber;
  int usefulNumber;
  int userId;
  int views;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'commentNumber': commentNumber,
        'content': content,
        'dateAdd': dateAdd,
        'dateUpdate': dateUpdate,
        'descript': descript,
        'extInfo': extInfo,
        'id': id,
        'isRecommend': isRecommend,
        'keywords': keywords,
        'numberFav': numberFav,
        'paixu': paixu,
        'status': status,
        'statusStr': statusStr,
        'title': title,
        'uid': uid,
        'unusefulNumber': unusefulNumber,
        'usefulNumber': usefulNumber,
        'userId': userId,
        'views': views,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class ExtInfo {
  ExtInfo({
    this.authorName,
    this.authorPic,
  });

  factory ExtInfo.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : ExtInfo(
          authorName: asT<String>(jsonRes['authorName']),
          authorPic: asT<String>(jsonRes['authorPic']),
        );

  String authorName;
  String authorPic;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'authorName': authorName,
        'authorPic': authorPic,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
