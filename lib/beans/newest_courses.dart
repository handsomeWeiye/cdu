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

class NewestCourses {
  NewestCourses({
    this.code,
    this.message,
    this.data,
  });

  factory NewestCourses.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : NewestCourses(
              code: asT<int>(jsonRes['code']),
              message: asT<String>(jsonRes['message']),
              data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
            );

  int code;
  String message;
  Data data;

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
    this.scheduleTerm,
    this.scheduleYear,
    this.schedule,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<List<List<Schedule>>> schedule =
        jsonRes['schedule'] is List ? <List<List<Schedule>>>[] : null;
    if (schedule != null) {
      for (final dynamic item0 in asT<List<dynamic>>(jsonRes['schedule'])) {
        if (item0 != null) {
          final List<List<Schedule>> items1 = <List<Schedule>>[];
          for (final dynamic item1 in asT<List<dynamic>>(item0)) {
            if (item1 != null) {
              final List<Schedule> items2 = <Schedule>[];
              for (final dynamic item2 in asT<List<dynamic>>(item1)) {
                if (item2 != null) {
                  tryCatch(() {
                    items2.add(
                        Schedule.fromJson(asT<Map<String, dynamic>>(item2)));
                  });
                }
              }
              items1.add(items2);
            }
          }
          schedule.add(items1);
        }
      }
    }
    return Data(
      scheduleTerm: asT<String>(jsonRes['schedule_term']),
      scheduleYear: asT<String>(jsonRes['schedule_year']),
      schedule: schedule,
    );
  }

  String scheduleTerm;
  String scheduleYear;
  List<List<List<Schedule>>> schedule;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'schedule_term': scheduleTerm,
        'schedule_year': scheduleYear,
        'schedule': schedule,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class Schedule {
  Schedule({
    this.color,
    this.name,
    this.weeksText,
    this.teacher,
    this.place,
    this.section,
    this.weeksArr,
    this.time,
  });

  factory Schedule.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<int> weeksArr = jsonRes['weeks_arr'] is List ? <int>[] : null;
    if (weeksArr != null) {
      for (final dynamic item in jsonRes['weeks_arr']) {
        if (item != null) {
          tryCatch(() {
            weeksArr.add(asT<int>(item));
          });
        }
      }
    }
    return Schedule(
      color: asT<String>(jsonRes['color']),
      name: asT<String>(jsonRes['name']),
      weeksText: asT<String>(jsonRes['weeks_text']),
      teacher: asT<String>(jsonRes['teacher']),
      place: asT<String>(jsonRes['place']),
      section: asT<int>(jsonRes['section']),
      weeksArr: weeksArr,
      time: asT<String>(jsonRes['time']),
    );
  }

  String color;
  String name;
  String weeksText;
  String teacher;
  String place;
  int section;
  List<int> weeksArr;
  String time;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'color': color,
        'name': name,
        'weeks_text': weeksText,
        'teacher': teacher,
        'place': place,
        'section': section,
        'weeks_arr': weeksArr,
        'time': time,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
