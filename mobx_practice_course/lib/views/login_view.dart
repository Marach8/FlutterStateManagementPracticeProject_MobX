import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'package:provider/provider.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: 'emma@gmail.com'.ifDebugging);
    final passwordController = useTextEditingController(text: 'emmanuel'.ifDebugging);
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: emailController, keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.emailAddress, 
            decoration: const InputDecoration(
              hintText: 'Enter your Email here.', 
              prefix: Icon(Icons.edit)
            )
          ),
          TextField(
            controller: passwordController, keyboardAppearance: Brightness.dark,
            obscureText: true, obscuringCharacter: '#',
            decoration: const InputDecoration(
              hintText: 'Enter your Password here.', 
              prefix: Icon(Icons.edit)
            )
          ),
          TextButton(
            onPressed: () =>
              context.read<AppState>().loginUser(emailController.text, passwordController.text),
            child: const Text('Login')
          ),
          TextButton(
            onPressed: () => context.read<AppState>().goToNewScreen(AppScreen.register),
            child: const Text('Not registered? Register here!')
          )
        ]
      )
    );
  }
}