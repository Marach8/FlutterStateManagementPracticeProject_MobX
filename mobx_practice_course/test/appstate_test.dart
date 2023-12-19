import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'mock/mock_auth_service.dart';
import 'mock/mock_image_upload_sevice.dart';
import 'mock/mock_reminder_service.dart';

void main(){
  late AppState appState;
  setUp((){
    appState = AppState(
      authProvider: MockAuthService(), 
      remindersProvider: MockReminderService(),
      imageUploadService: MockImageUploadService()
    );
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

  test('Making the password field to be visible and not visible', (){
    appState.showPasswordField();
    expect(appState.isVisible, true);
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

  test("Logging Out a User", () async{
    await appState.initializeApp();
    await appState.logOutUser();
    expect(appState.reminders.isEmpty, true);
    expect(appState.currentScreen, AppScreen.login);
  });

  test('Uploading Image for a reminder', () async{
    await appState.initializeApp();
    final reminder = appState.reminders.firstWhere((element) => element.id == mockReminder1Id);
    reminder.hasImage.expectFalse();
    reminder.imageData.expectNull();
    final didUploadImage = await appState.uploadImagetoRemote(
      filePath: 'image-path', forReminderId: reminder.id
    );
    didUploadImage.expectTrue();
    reminder.hasImage.expectTrue();
    reminder.imageData.expectNull();
    final image = await appState.getReminderImage(reminderId: reminder.id);
    image.expectNotNull();
    image!.isEqualTo(mockImageData1).expectTrue();
  });
}




extension NullExpectation on Object? {
  void expectNull() => expect(this, isNull);
  void expectNotNull() => expect(this, isNotNull);
}

extension BoolExpectation on Object? {
  void expectTrue() => expect(this, true);
  void expectFalse() => expect(this, false);
}

extension Comparison<E> on List<E>{
  bool isEqualTo(List<E> other){
    if(identical(this, other)){return true;}
    if(length != other.length){return false;}
    for(var i = 0; i < length; i++){
      if(this[i] != other[i]){return false;}
    } 
    return true;
  }
}