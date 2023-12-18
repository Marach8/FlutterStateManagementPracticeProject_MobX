import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'mock/mockauth_provider.dart';
import 'mock/mockreminder_provider.dart';

void main(){
  late AppState appState;
  setUp((){
    appState = AppState(authProvider: MockAuthProvider(), remindersProvider: MockReminderProvider());
  });

  test('Testing the initial states of AppState', (){
    expect(appState.currentScreen, AppScreen.login);
    expect(appState.error, null);
    expect(appState.isVisible, false);
    expect(appState.isLoading, false);
    expect(appState.reminders.isEmpty, true);
  });
  

  test('Going to other Screens', (){
    appState.goToNewScreen(AppScreen.register);
    expect(appState.currentScreen, AppScreen.register);

    appState.goToNewScreen(AppScreen.reminder);
    expect(appState.currentScreen, AppScreen.reminder);

    appState.goToNewScreen(AppScreen.login);
    expect(appState.currentScreen, AppScreen.login);
  });

  
  test('Initializing the AppState when there is a current user', () async{
    await appState.initializeApp();
    expect(appState.reminders.length, mockReminders.length);
    expect(appState.reminders.contains(mockReminder1), true);
    expect(appState.reminders.contains(mockReminder2), true);
    expect(appState.currentScreen, AppScreen.reminder);
  });

  test('Modifying reminders isDone property', () async{
    await appState.initializeApp();
    final isModifiedA = await appState.modifyIsDone(mockReminder1Id, false);
    final isModifiedB = await appState.modifyIsDone(mockReminder2Id, true);
    final reminderA = appState.reminders.firstWhere((element) => element.id == mockReminder1Id);
    final reminderB = appState.reminders.firstWhere((element) => element.id == mockReminder2Id);
    expect(reminderA.isDone, false); expect(reminderB.isDone, true);
    expect(isModifiedA, true); expect(isModifiedB, true);
  });

  test('Creating reminders', () async{
    await appState.initializeApp();
    final didCreate = await appState.createReminder(mockReminder1Text);
    expect(didCreate, true); expect(appState.reminders.length, mockReminders.length + 1);
    final testReminder = appState.reminders.firstWhere((element) => element.id == mockReminder1Id);
    expect(testReminder.text, mockReminder1Text); expect(testReminder.isDone, false);
  });

  test('Deleting a given reminder', () async{
    await appState.initializeApp();
    final initialRemindersLength = appState.reminders.length;
    final isDeleted = await appState.deleteReminder(appState.reminders.first);
    final finalRemindersLength = appState.reminders.length;
    expect(isDeleted, true);
    expect(initialRemindersLength, finalRemindersLength + 1);
  });

  test("Deleting a User's account", () async{
    await appState.initializeApp();
    final accountDeleted = await appState.deleteAccount();
    expect(accountDeleted, true); 
    expect(appState.reminders.isEmpty, true);
    expect(appState.currentScreen, AppScreen.login);
  });

  test("Loggin Out a User", () async{
    await appState.initializeApp();
    await appState.logOutUser();
    expect(appState.reminders.isEmpty, true);
    expect(appState.currentScreen, AppScreen.login);
  });
}