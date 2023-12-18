import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx_practice_course/states/reminder.dart';

//This entire file is to make the Application testatble

typedef ReminderId = String;

abstract class RemindersProvider {
  Future<void> deleteReminderWithId(ReminderId id, String userId);

  Future<void> deleteAllDocuments(String userId);

  Future<ReminderId> createReminder(String userId, String text, String dateCreated);

  Future<void> modifyReminder(ReminderId id, bool isDone, String userId);

  Future<Iterable<Reminder>> loadReminder(String userId);
}


class FireStoreReminderProvider implements RemindersProvider{
  @override
  Future<ReminderId> createReminder(String userId, String text, String dateCreated) async{
    final firebaseReminder = await FirebaseFirestore.instance.collection(userId).add(
      {
        _DocumentKeys.text: text,
        _DocumentKeys.dateCreated: dateCreated,
        _DocumentKeys.isDone: false,
      }
    ); return firebaseReminder.id;
  }

  @override
  Future<void> deleteAllDocuments(String userId) async{
    final operation = FirebaseFirestore.instance.batch();
    final collection = await FirebaseFirestore.instance.collection(userId).get();
    for (final item in collection.docs){operation.delete(item.reference);}
    await operation.commit();
  }

  @override
  Future<void> deleteReminderWithId(ReminderId id, String userId) async{
    try{
      await FirebaseFirestore.instance.collection(userId).doc(id).delete();
    } catch (_){} 
  }

  @override
  Future<void> modifyReminder(ReminderId id, bool isDone, String userId) async{
    await FirebaseFirestore.instance.collection(userId).doc(id).update({_DocumentKeys.isDone: isDone});
  }

  @override
  Future<Iterable<Reminder>> loadReminder(String userId) async{
    final collection = await FirebaseFirestore.instance.collection(userId).get();
    final reminders = collection.docs.map((document) {
      return Reminder(
        dateCreated: document[_DocumentKeys.dateCreated] as String,
        id: document.id,
        text: document[_DocumentKeys.text] as String,
        isDone: document[_DocumentKeys.isDone] as bool,
      );
    });
    return reminders;
  }
}


abstract class _DocumentKeys {
  static const text = 'text';
  static const dateCreated = 'date_created';
  static const isDone = 'is_done';
}