import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx_practice_course/states/reminder.dart';

//This entire file is to make the Application testatble

typedef ReminderId = String;

abstract class RemindersProvider {
  Future<void> deleteReminderWithId(ReminderId id, String userId);

  Future<void> deleteAllDocuments(String userId);

  Future<ReminderId> createReminder(String userId, String text, String dateCreated);

  Future<void> modifyReminder(ReminderId id, bool isDone, String userId);

  Future<Iterable<Reminder>> loadReminder(String userId);

  Future<void> setReminderImageStatus(ReminderId reminderId, String userId);

  Future<Uint8List?> getReminderImage(ReminderId reminderId, String userId);
}


class FireStoreReminderProvider implements RemindersProvider{
  @override
  Future<ReminderId> createReminder(String userId, String text, String dateCreated) async{
    final firebaseReminder = await FirebaseFirestore.instance.collection(userId).add(
      {
        _DocumentKeys.text: text,
        _DocumentKeys.dateCreated: dateCreated,
        _DocumentKeys.isDone: false,
        _DocumentKeys.hasImage: false,
      }
    ); return firebaseReminder.id;
  }

  @override
  Future<void> deleteAllDocuments(String userId) async{
    final operation = FirebaseFirestore.instance.batch();
    final collection = await FirebaseFirestore.instance.collection(userId).get();
    for (final item in collection.docs){
      operation.delete(item.reference);
      try{await FirebaseStorage.instance.ref(userId).child(item.id).delete();} 
      catch (_){}
    }
    await operation.commit();
  }

  @override
  Future<void> deleteReminderWithId(ReminderId reminderId, String userId) async{
    try{
      await FirebaseFirestore.instance.collection(userId).doc(reminderId).delete();
      await FirebaseStorage.instance.ref(userId).child(reminderId).delete();
    } catch (_){}

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
        hasImage: document[_DocumentKeys.hasImage] as bool,
      );
    });
    return reminders;
  }

  @override
  Future<void> modifyReminder(ReminderId id, bool? isDone, String userId,) async{
    await FirebaseFirestore.instance.collection(userId).doc(id).update({_DocumentKeys.isDone: isDone});
  }
  
  @override
  Future<Uint8List?> getReminderImage(ReminderId reminderId, String userId) async{
    try{
      final data = await FirebaseStorage.instance.ref(userId).child(reminderId).getData();
      return data;
    } catch (_){return null;}
  }
  

  // @override
  // Future<void> modifyReminder(ReminderId reminderId, bool isDone, String userId) 
  //   => _modifyReminder(reminderId, isDone, userId, {
  //   _DocumentKeys.isDone: isDone
  // });

  @override
  Future<void> setReminderImageStatus(ReminderId reminderId, String userId)
    async => await FirebaseFirestore.instance.collection(userId).doc(reminderId)
    .update({_DocumentKeys.hasImage: true});
}


abstract class _DocumentKeys {
  static const text = 'text';
  static const dateCreated = 'date_created';
  static const isDone = 'is_done';
  static const hasImage = 'has_image';
}