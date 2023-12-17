// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<ObservableList<Reminder>>? _$sortedRemindersComputed;

  @override
  ObservableList<Reminder> get sortedReminders => (_$sortedRemindersComputed ??=
          Computed<ObservableList<Reminder>>(() => super.sortedReminders,
              name: '_AppState.sortedReminders'))
      .value;

  late final _$currentScreenAtom =
      Atom(name: '_AppState.currentScreen', context: context);

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isVisibleAtom =
      Atom(name: '_AppState.isVisible', context: context);

  @override
  bool get isVisible {
    _$isVisibleAtom.reportRead();
    return super.isVisible;
  }

  @override
  set isVisible(bool value) {
    _$isVisibleAtom.reportWrite(value, super.isVisible, () {
      super.isVisible = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_AppState.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AppState.error', context: context);

  @override
  AuthError? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(AuthError? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$deleteReminderAsyncAction =
      AsyncAction('_AppState.deleteReminder', context: context);

  @override
  Future<bool> deleteReminder(Reminder reminder) {
    return _$deleteReminderAsyncAction
        .run(() => super.deleteReminder(reminder));
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_AppState.deleteAccount', context: context);

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$logOutUserAsyncAction =
      AsyncAction('_AppState.logOutUser', context: context);

  @override
  Future<void> logOutUser() {
    return _$logOutUserAsyncAction.run(() => super.logOutUser());
  }

  late final _$createReminderAsyncAction =
      AsyncAction('_AppState.createReminder', context: context);

  @override
  Future<bool> createReminder(String text) {
    return _$createReminderAsyncAction.run(() => super.createReminder(text));
  }

  late final _$modifyIsDoneAsyncAction =
      AsyncAction('_AppState.modifyIsDone', context: context);

  @override
  Future<bool> modifyIsDone(Reminder reminder, bool isDone) {
    return _$modifyIsDoneAsyncAction
        .run(() => super.modifyIsDone(reminder, isDone));
  }

  late final _$loadRemindersAsyncAction =
      AsyncAction('_AppState.loadReminders', context: context);

  @override
  Future<bool> loadReminders() {
    return _$loadRemindersAsyncAction.run(() => super.loadReminders());
  }

  late final _$initializeAppAsyncAction =
      AsyncAction('_AppState.initializeApp', context: context);

  @override
  Future<void> initializeApp() {
    return _$initializeAppAsyncAction.run(() => super.initializeApp());
  }

  late final _$loginOrRegisterAsyncAction =
      AsyncAction('_AppState.loginOrRegister', context: context);

  @override
  Future<bool> loginOrRegister(
      LoginOrRegisterFunction func, String email, String password) {
    return _$loginOrRegisterAsyncAction
        .run(() => super.loginOrRegister(func, email, password));
  }

  late final _$_AppStateActionController =
      ActionController(name: '_AppState', context: context);

  @override
  void goToNewScreen(AppScreen newScreen) {
    final _$actionInfo = _$_AppStateActionController.startAction(
        name: '_AppState.goToNewScreen');
    try {
      return super.goToNewScreen(newScreen);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showPasswordField() {
    final _$actionInfo = _$_AppStateActionController.startAction(
        name: '_AppState.showPasswordField');
    try {
      return super.showPasswordField();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> registerUser(String email, String password) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.registerUser');
    try {
      return super.registerUser(email, password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> loginUser(String email, String password) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.loginUser');
    try {
      return super.loginUser(email, password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
isVisible: ${isVisible},
currentUser: ${currentUser},
error: ${error},
sortedReminders: ${sortedReminders}
    ''';
  }
}
