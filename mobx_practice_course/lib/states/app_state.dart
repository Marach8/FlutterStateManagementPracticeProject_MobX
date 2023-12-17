import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_practice_course/auth/auth_errors.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/states/reminder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store{
  @observable 
  AppScreen currentScreen = AppScreen.login;

  @observable 
  bool isLoading = false;

  @observable
  bool isVisible = false;

  @observable 
  User? currentUser;

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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){isLoading = false; return false;}
    try{
      await FirebaseFirestore.instance.collection(user.uid).doc(reminder.id).delete();
      reminders.removeWhere((element) => element.id == reminder.id); return true;
    } catch (e){return false;} finally{isLoading = false;}
  }

  @action
  Future<bool> deleteAccount () async{
    isLoading = true;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){isLoading = false; return false;}
    try{
      final operation = FirebaseFirestore.instance.batch();
      final collection = await FirebaseFirestore.instance.collection(user.uid).get();
      for (final item in collection.docs){operation.delete(item.reference);}
      await operation.commit();
      await user.delete(); await FirebaseAuth.instance.signOut(); 
      currentScreen = AppScreen.login;
      return true;
    } on FirebaseAuthException catch (e){
      error = AuthError.from(e); return false;
    } catch (e){return false;} finally{isLoading = false;}
  }

  @action
  Future<void> logOutUser() async{
    isLoading = true;
    try{
      await FirebaseAuth.instance.signOut();
      reminders.clear();
      currentScreen = AppScreen.login;
    } catch (_){} finally{isLoading = false;}
  }

  @action 
  Future<bool> createReminder(String text) async{
    isLoading = true;
    final userId = currentUser?.uid;
    if(userId == null){isLoading = false; return false;}
    final date = DateTime.now().toString();
    final firebaseReminder = await FirebaseFirestore.instance.collection(userId).add(
      {
        _DocumentKeys.text: text,
        _DocumentKeys.dateCreated: date,
        _DocumentKeys.isDone: false,
      }
    );
    final reminder = Reminder(dateCreated: date, isDone: false, text: text, id: firebaseReminder.id);
    reminders.add(reminder); isLoading = false; return true;
  }

  @action 
  Future<bool> modifyIsDone(Reminder reminder, bool isDone) async{
    isLoading = true;
    final userId = currentUser?.uid;
    if(userId == null){isLoading = false; return false;}
    await FirebaseFirestore.instance.collection(userId).doc(reminder.id).update({_DocumentKeys.isDone: isDone});
    reminders.firstWhere((element) => element.id == reminder.id).isDone = isDone; isLoading = false; return true;
  }

  @action 
  Future<bool> loadReminders() async{
    final userId = currentUser?.uid;
    if (userId == null){return false;}
    final collection = await FirebaseFirestore.instance.collection(userId).get();
    final reminders = collection.docs.map((document) {
      return Reminder(
        dateCreated: document[_DocumentKeys.dateCreated] as String,
        id: document.id,
        text: document[_DocumentKeys.text] as String,
        isDone: document[_DocumentKeys.isDone] as bool,
      );
    });
    this.reminders = ObservableList.of(reminders);
    return true;
  }

  @action
  Future<void> initializeApp() async{
    isLoading = true;
    currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null){await loadReminders(); currentScreen = AppScreen.reminder;}
    else{currentScreen = AppScreen.login;}
    isLoading = false;
  }
  
  @action
  Future<bool> loginOrRegister(LoginOrRegisterFunction func, String email, String password) async{
    error = null; isLoading = true;
    try {
      await func(email: email, password: password); 
      currentUser = FirebaseAuth.instance.currentUser;
      await loadReminders(); return true;
    } 
    on FirebaseAuthException catch(e){error = AuthError.from(e); currentUser = null; return false;} 
    finally{isLoading = false; currentUser != null ? currentScreen = AppScreen.reminder: {};}
  }

  @action 
  Future<bool> registerUser(String email, String password) 
    => loginOrRegister(
      FirebaseAuth.instance.createUserWithEmailAndPassword,
      email, password
    );

  @action 
  Future<bool> loginUser(String email, String password) 
    => loginOrRegister(
      FirebaseAuth.instance.signInWithEmailAndPassword,
      email, password
    );
}


abstract class _DocumentKeys {
  static const text = 'text';
  static const dateCreated = 'date_created';
  static const isDone = 'is_done';
}

typedef LoginOrRegisterFunction = Future<UserCredential> Function({
  required String email, required String password
});