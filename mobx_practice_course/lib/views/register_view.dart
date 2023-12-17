import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'package:provider/provider.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final emailController = useTextEditingController(text: 'emma@gmail.com'.ifDebugging);
    final passwordController = useTextEditingController(text: 'emmanuel'.ifDebugging);
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: emailController, keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.emailAddress, 
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              hintText: 'Enter your Email here.', 
              prefix: Icon(Icons.edit)
            )
          ),
          Observer(
            builder: (context) => TextField(
              controller: passwordController, keyboardAppearance: Brightness.dark,
              obscureText: appState.isVisible, obscuringCharacter: '*',
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                hintText: 'Enter your Password here.', 
                prefix: const Icon(Icons.edit),
                suffix: IconButton(
                  onPressed: () => appState.showPasswordField(),
                  icon: Icon(appState.isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined)
                )
              )
            ),
          ),
          TextButton(
            onPressed: () =>
              context.read<AppState>().registerUser(emailController.text, passwordController.text),
            child: const Text('Register')
          ),
          TextButton(
            onPressed: () => context.read<AppState>().goToNewScreen(AppScreen.login),
            child: const Text('Already registered? Login here!')
          )
        ]
      )
    );
  }
}