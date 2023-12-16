import 'package:flutter/material.dart';
import 'package:mobx_practice_course/auth/auth_errors.dart';
import 'package:mobx_practice_course/dialogs/generic_dialog.dart';

Future<bool?> deletAccountDialog({required BuildContext context}) 
  => showGenericDialog<bool?>(
    context: context, title: 'Delete Account',
    content: 'Are you sure you want to delete your account?',
    optionsBuilder: () => {'Cancel': false, 'Delete': true}
  ).then((value) => value ?? false);


Future<bool?> logOutDialog({required BuildContext context}) 
  => showGenericDialog<bool?>(
    context: context, title: 'Log Out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: () => {'Cancel': false, 'Log Out': true}
  ).then((value) => value ?? false);


Future<void> authErrorDialog({required BuildContext context, required AuthError error}) 
  => showGenericDialog<void>(
    context: context, title: error.title,
    content: error.content,
    optionsBuilder: () => {'Ok': true}
  );

Future<bool?> deleteReminderDialog({required BuildContext context})
  => showGenericDialog<bool>(
    context: context, title: 'Delete Reminder',
    content: 'Do you want to delete this reminder?',
    optionsBuilder: () => {'Cancel': false, 'Delete': true}
  ).then((value) => value ?? false);

Future<T?> addReminderDialog<T>({required BuildContext context, required TextEditingController controller})
  => showGenericDialog<T?>(
    context: context, controller: controller, title: 'Add Reminder',
    optionsBuilder: () => {'Cancel': false, 'Save': true}
  ).then((value) => value);