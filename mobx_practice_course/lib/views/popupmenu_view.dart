import 'package:flutter/material.dart';
import 'package:mobx_practice_course/dialogs/dialogs.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'package:provider/provider.dart';

enum MenuAction{logout, deleteAccount}

class MenuPopUpButton extends StatelessWidget {
  const MenuPopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: (context) => [
        const PopupMenuItem<MenuAction>(
          value: MenuAction.logout, child: Text('LogOut')
        ),
        const PopupMenuItem<MenuAction>(
          value: MenuAction.deleteAccount, child: Text('Delete Account')
        )
      ],
      onSelected: (value) async{
        switch(value){
          case MenuAction.logout: 
            await logOutDialog(context: context)
            .then((result){result == true ? context.read<AppState>().logOutUser():{};});
            break;           
          case MenuAction.deleteAccount:
            await deletAccountDialog(context: context)
            .then((result){result == true ? context.read<AppState>().deleteAccount():{};});  
            break;
        }
      }
    );
  }
}