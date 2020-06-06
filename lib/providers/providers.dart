import 'package:cdu_helper/providers/course_provider.dart';
import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
export 'package:provider/provider.dart';

ChangeNotifierProvider<T> buildProvider<T extends ChangeNotifier>(T value) {
  return ChangeNotifierProvider<T>.value(value: value);
}

List<SingleChildWidget> get providers => _providers;

final _providers = [
  buildProvider<CoursesProvider>(CoursesProvider()),
  buildProvider<ForumDetailsProvider>(ForumDetailsProvider()),
];
