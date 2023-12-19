import 'package:flutter/foundation.dart';
import 'package:mobx_practice_course/states/reminder.dart';

enum AppScreen {login, register, reminder}

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

const oneSecond = Duration(seconds: 1);

extension WithDelay<T> on T{
  Future<T> toFuture(Duration? delay) => delay != null ? Future.delayed(delay, () => this): Future.value(this);
}

//an extension that converts a string filePath to its Uint8List bytes equivalent
extension ToBytes on String{
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}