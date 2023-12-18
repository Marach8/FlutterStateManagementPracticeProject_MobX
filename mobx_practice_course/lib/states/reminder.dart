import 'dart:typed_data';

import 'package:mobx/mobx.dart';
part 'reminder.g.dart';


class Reminder = _Reminder with _$Reminder;

abstract class _Reminder with Store{
  final String id; final String dateCreated;

  @observable
  String text;

  @observable 
  bool isDone;

  @observable
  bool hasImage;

  @observable 
  Uint8List? imageData;

  @observable 
  bool imageIsLoading;

  _Reminder({
    required this.text, required this.isDone, required this.id, 
    required this.hasImage, required this.dateCreated
    }): imageIsLoading = false;

  @override 
  bool operator ==(covariant _Reminder other) => id == other.id 
  && dateCreated == other.dateCreated && text == other.text && isDone == other.isDone;

  @override 
  int get hashCode => Object.hash(id, isDone, text, dateCreated);
}