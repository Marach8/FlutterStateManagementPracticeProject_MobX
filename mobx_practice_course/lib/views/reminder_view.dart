import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_practice_course/dialogs/dialogs.dart';
import 'package:mobx_practice_course/states/app_state.dart';
import 'package:mobx_practice_course/views/popupmenu_view.dart';
import 'package:provider/provider.dart';

class MainReminderView extends HookWidget {
  const MainReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Homepage'), centerTitle: true, 
        actions: [
          IconButton(
            onPressed: () async{
            await addReminderDialog(context: context, controller: reminderController)
            .then((reminderContent){
              if(reminderContent == null || reminderContent.runtimeType == bool){return;}
              else if(reminderController.text.isNotEmpty){
                context.read<AppState>().createReminder(reminderContent.text);
              }
              else {return;}
            });              
            }, 
            icon: const Icon(Icons.add)
          ),
          const MenuPopUpButton()
        ]
      ),
    body: const ReminderListView()
    );
  }
}



class ReminderListView extends StatelessWidget {
  const ReminderListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Observer(
      builder: (context){
        return ListView.builder(
          itemCount: appState.sortedReminders.length,
          itemBuilder: (context, listIndex){
            final reminder = appState.sortedReminders[listIndex];
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: reminder.isDone,
              onChanged: (isDone){
                appState.modifyIsDone(reminder, isDone ?? false);
                reminder.isDone = isDone ?? false;
              },
              title: Row(
                children: [
                  Expanded(child: Text(reminder.text)),
                  IconButton(
                    onPressed: () async => await deleteReminderDialog(context: context).then((value){
                      if(value == null || value == false){return;}
                      appState.deleteReminder(reminder);
                    }), 
                    icon: const Icon(Icons.delete_rounded)
                  )
                ],
              ), 
              //subtitle: Text(reminder.dateCreated.toString()),              
            );
          }
        );
      }
    );
  }
}