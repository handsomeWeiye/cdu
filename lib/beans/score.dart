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

class Score {
  Score({
    this.code,
    this.message,
    this.data,
  });

  factory Score.fromJson(Map<String, dynamic> jsonRes) {
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
    return Score(
      code: asT<int>(jsonRes['code']),
      message: asT<String>(jsonRes['message']),
      data: data,
    );
  }

  int code;
  String message;
  List<Data> data;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'message': message,
        'data': data,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class Data {
  Data({
    this.lessonName,
    this.credit,
    this.point,
    this.score,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Data(
          lessonName: asT<String>(jsonRes['lesson_name']),
          credit: asT<double>(jsonRes['credit']),
          point: asT<double>(jsonRes['point']),
          score: jsonRes['score'],
        );

  String lessonName;
  double credit;
  double point;
  dynamic score;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lesson_name': lessonName,
        'credit': credit,
        'point': point,
        'score': score,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
