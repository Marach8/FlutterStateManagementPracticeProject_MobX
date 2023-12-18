import 'package:mobx_practice_course/provider/reminders_provider.dart';
import 'package:mobx_practice_course/states/reminder.dart';
import '../utils.dart';

const mockReminder1Date = '17, December, 2023'; const mockReminder1Id = '1';
const mockReminder1Text = 'EmmanuelMarach'; const mockReminder1IsDone = true;
final mockReminder1 = Reminder(
  dateCreated: mockReminder1Date, id: mockReminder1Id,
  isDone: mockReminder1IsDone, text: mockReminder1Text
);

const mockReminder2Date = '18, December, 2023'; const mockReminder2Id = '2';
const mockReminder2Text = 'NnannaMarach'; const mockReminder2IsDone = false;
final mockReminder2 = Reminder(
  dateCreated: mockReminder2Date, id: mockReminder2Id,
  isDone: mockReminder2IsDone, text: mockReminder2Text
);

final Iterable<Reminder> mockReminders = [mockReminder1, mockReminder2];

class MockReminderProvider implements RemindersProvider{
  @override
  Future<ReminderId> createReminder(String userId, String text, String dateCreated)
    => mockReminder1Id.toFuture(oneSecond);

  @override
  Future<void> deleteAllDocuments(String userId) => Future.delayed(oneSecond);

  @override
  Future<void> deleteReminderWithId(ReminderId id, String userId) => Future.delayed(oneSecond);

  @override
  Future<Iterable<Reminder>> loadReminders(String userId) => mockReminders.toFuture(oneSecond);

  @override
  Future<void> modifyReminder(ReminderId id, bool isDone, String userId) => Future.delayed(oneSecond);

}