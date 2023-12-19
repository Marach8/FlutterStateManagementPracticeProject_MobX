import 'dart:typed_data';
import 'package:mobx_practice_course/states/reminder.dart';

//This entire file is to make the Application testatble

typedef ReminderId = String;

abstract class RemindersService {
  Future<void> deleteReminderWithId(ReminderId id, String userId);

  Future<void> deleteAllDocuments(String userId);

  Future<ReminderId> createReminder(String userId, String text, String dateCreated);

  Future<void> modifyReminder(ReminderId id, bool isDone, String userId);

  Future<Iterable<Reminder>> loadReminder(String userId);

  Future<void> setReminderImageStatus(ReminderId reminderId, String userId);

  Future<Uint8List?> getReminderImage(ReminderId reminderId, String userId);
}
