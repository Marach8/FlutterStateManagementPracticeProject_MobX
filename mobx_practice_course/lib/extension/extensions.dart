import 'package:flutter/foundation.dart';
import 'package:mobx_practice_course/states/reminder.dart';

extension BoolToInt on bool{int boolToInt() => this? 1: 0;}

extension IfDebugging on String{
  String? get ifDebugging => kDebugMode ? this: null;
}

extension Sorted on List<Reminder> {
  List<Reminder> sorted () => [...this]..sort((itemA, itemB){
    final isDone = itemA.isDone.boolToInt().compareTo(itemB.isDone.boolToInt());
    if(isDone != 0){return isDone;}
    return DateTime.parse(itemA.dateCreated).compareTo(DateTime.parse(itemB.dateCreated));
  });
}

enum AppScreen {login, register, reminder}