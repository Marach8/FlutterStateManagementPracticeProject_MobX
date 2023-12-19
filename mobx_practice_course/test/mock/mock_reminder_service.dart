import 'dart:typed_data';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/providers/reminder_provider.dart';
import 'package:mobx_practice_course/states/reminder.dart';

const mockReminder1Date = '17, December, 2023'; const mockReminder1Id = '1';
const mockReminder1Text = 'EmmanuelMarach'; const mockReminder1IsDone = true;
final mockImageData1 = 'Image1'.toUint8List();
final mockReminder1 = Reminder(
  dateCreated: mockReminder1Date, id: mockReminder1Id,
  isDone: mockReminder1IsDone, text: mockReminder1Text, hasImage: false,
);

const mockReminder2Date = '18, December, 2023'; const mockReminder2Id = '2';
const mockReminder2Text = 'NnannaMarach'; const mockReminder2IsDone = false;
final mockImageData2 = 'Image2'.toUint8List();
final mockReminder2 = Reminder(
  dateCreated: mockReminder2Date, id: mockReminder2Id,
  isDone: mockReminder2IsDone, text: mockReminder2Text, hasImage: false,
);

final Iterable<Reminder> mockReminders = [mockReminder1, mockReminder2];



class MockReminderService implements RemindersService{
  @override
  Future<ReminderId> createReminder(String userId, String text, String dateCreated)
    => mockReminder1Id.toFuture(oneSecond);

  @override
  Future<void> deleteAllDocuments(String userId) => Future.delayed(oneSecond);

  @override
  Future<void> deleteReminderWithId(ReminderId id, String userId) => Future.delayed(oneSecond);

  @override
  Future<Iterable<Reminder>> loadReminder(String userId) => mockReminders.toFuture(oneSecond);

  @override
  Future<void> modifyReminder(ReminderId id, bool isDone, String userId) => Future.delayed(oneSecond);

  @override
  Future<Uint8List?> getReminderImage(ReminderId reminderId, String userId) {
    switch(reminderId){
      case mockReminder1Id: return mockImageData1.toFuture(oneSecond);
      case mockReminder2Id: return mockImageData2.toFuture(oneSecond);
      default: return null.toFuture(oneSecond);
    } 
  }

  @override
  Future<void> setReminderImageStatus(ReminderId reminderId, String userId) 
    async => mockReminders.firstWhere((element) => element.id == reminderId).hasImage = true;
}