import 'package:mobx/mobx.dart';
import 'package:mobx_practice_course/auth/auth_errors.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/provider/auth_provider.dart';
import 'package:mobx_practice_course/provider/reminders_provider.dart';
import 'package:mobx_practice_course/states/reminder.dart';


part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store{
  final RemindersProvider remindersProvider;
  final AuthProvider authProvider;
  _AppState({required this.remindersProvider, required this.authProvider});


  @observable 
  AppScreen currentScreen = AppScreen.login;

  @observable 
  bool isLoading = false;

  @observable
  bool isVisible = false;

  @observable 
  AuthError? error;

  ObservableList<Reminder> reminders = ObservableList<Reminder>();

  @computed 
  ObservableList<Reminder> get sortedReminders => ObservableList.of(reminders.sorted());

  @action 
  void goToNewScreen(AppScreen newScreen) => currentScreen = newScreen;

  @action 
  void showPasswordField () => isVisible = !isVisible;

  @action 
  Future<bool> deleteReminder(Reminder reminder) async{
    isLoading = true;
    final userId = authProvider.userId;
    if (userId == null){isLoading = false; return false;}
    try{
      await remindersProvider.deleteReminderWithId(reminder.id, userId);
      reminders.removeWhere((element) => element.id == reminder.id);
      return true;
    } catch (e){return false;} finally{isLoading = false;}
  }

  @action
  Future<bool> deleteAccount () async{
    isLoading = true;
    final userId = authProvider.userId;
    if (userId == null){isLoading = false; return false;}
    try{
      await remindersProvider.deleteAllDocuments(userId);
      reminders.clear();
      await authProvider.deleteAcccountAndSignOut();
      currentScreen = AppScreen.login;
      return true;
    } on AuthError catch (e){
      error = e; return false;
    } catch (e){return false;} finally{isLoading = false;}
  }

  @action
  Future<void> logOutUser() async{
    isLoading = true; await authProvider.signOut();
    reminders.clear(); isLoading = false;
    currentScreen = AppScreen.login;
  }

  @action 
  Future<bool> createReminder(String text) async{
    isLoading = true;
    final userId = authProvider.userId;
    if(userId == null){isLoading = false; return false;}
    final date = DateTime.now().toIso8601String();
    final reminderId = await remindersProvider.createReminder(userId, text, date);
    final reminder = Reminder(dateCreated: date, isDone: false, text: text, id: reminderId);
    reminders.add(reminder); isLoading = false; return true;
  }

  @action 
  Future<bool> modifyIsDone(ReminderId reminderId, bool isDone) async{
    isLoading = true;
    final userId = authProvider.userId;
    if(userId == null){isLoading = false; return false;}
    await remindersProvider.modifyReminder(reminderId, isDone, userId);
    reminders.firstWhere((element) => element.id == reminderId).isDone = isDone; 
    isLoading = false; return true;
  }

  @action 
  Future<bool> loadReminders() async{
    final userId = authProvider.userId;
    if (userId == null){return false;}
    final reminders = await remindersProvider.loadReminders(userId);
    this.reminders = ObservableList.of(reminders);
    return true;
  }

  @action
  Future<void> initializeApp() async{
    isLoading = true;
    final userId= authProvider.userId;
    if(userId != null){await loadReminders(); currentScreen = AppScreen.reminder;}
    else{currentScreen = AppScreen.login;}
    isLoading = false;
  }
  
  @action
  Future<bool> loginOrRegister(LoginOrRegisterFunction func, String email, String password) async{
    error = null; isLoading = true;
    try {
      final success = await func(email: email, password: password); 
      if(success){await loadReminders();} return success;
    } on AuthError catch(e){error = e; return false;} 
    finally{isLoading = false; authProvider.userId != null ? currentScreen = AppScreen.reminder: {};}
  }

  @action 
  Future<bool> registerUser(String email, String password) 
    => loginOrRegister(authProvider.register, email, password);

  @action 
  Future<bool> loginUser(String email, String password) 
    => loginOrRegister(authProvider.login, email, password);
}



typedef LoginOrRegisterFunction = Future<bool> Function({
  required String email, required String password
});