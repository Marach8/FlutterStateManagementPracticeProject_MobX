import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_practice_course/dialogs/dialogs.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/firebase_options.dart';
import 'package:mobx_practice_course/loadscreen/loading_screen.dart';
import 'package:mobx_practice_course/provider/auth_provider.dart';
import 'package:mobx_practice_course/provider/reminders_provider.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'package:mobx_practice_course/views/login_view.dart';
import 'package:mobx_practice_course/views/register_view.dart';
import 'package:mobx_practice_course/views/reminder_view.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AppState>(
      create: (_) => AppState(
        authProvider: FirebaseAuthProvider(), 
        remindersProvider: FireStoreReminderProvider()
      )..initializeApp(),
      builder: (context, child){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.blue)
          ),
          home: ReactionBuilder(
            builder: (context){
              return autorun((_){
                final isLoading = context.read<AppState>().isLoading;
                if(isLoading){LoadingScreen().showOverlay(context: context, text: 'Loading...');}
                else{LoadingScreen().hideOverlay();}
        
                final authError = context.read<AppState>().error;
                if(authError != null){authErrorDialog(context: context, error: authError);}
              });
            },
            child: Observer(
              name: 'currentScreen',
              builder: (context){
                switch(context.watch<AppState>().currentScreen){
                  case AppScreen.login: return const LoginView();
                  case AppScreen.register: return const RegisterView();
                  case AppScreen.reminder: return const MainReminderView();
                }
              }
            )
          )
        );
      }
    );
  }
}