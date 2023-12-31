import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
              reminderController.clear();
              await addReminderDialog(context: context, controller: reminderController)
              .then((reminderContent){
                if(reminderContent == null || reminderContent.runtimeType == bool){return;}
                else if(reminderController.text.isNotEmpty){
                  context.read<AppState>().createReminder(reminderContent);
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


final ImagePicker imagePicker = ImagePicker();

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
            final date = DateTime.parse(reminder.dateCreated);
            final formatedDate = DateFormat('EEEE dd, MMMM, yyyy hh:mm a').format(date);
            return Observer(
              builder: (context) => Card(
                elevation: 10,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: reminder.isDone,
                  onChanged: (isDone){
                    appState.modifyIsDone(reminder.id, isDone ?? false);
                    reminder.isDone = isDone ?? false;
                  },
                  title: Row(
                    children: [
                      Expanded(child: Text(reminder.text)),
                      reminder.imageIsLoading? const CircularProgressIndicator() : const SizedBox(),
                      reminder.hasImage ? const SizedBox() : IconButton(
                        onPressed: ()async{
                          final image = await imagePicker.pickImage(source: ImageSource.gallery);
                          if(image != null){
                            appState.uploadImagetoRemote(filePath: image.path, forReminderId: reminder.id);
                          }
                        },
                        icon: const Icon(Icons.upload_rounded)
                      ),
                      IconButton(
                        onPressed: () async => await deleteReminderDialog(context: context).then((value){
                          if(value == null || value == false){return;}
                          appState.deleteReminder(reminder);
                        }), 
                        icon: const Icon(Icons.delete_rounded)
                      )
                    ],
                  ), 
                  subtitle: ReminderImageView(reminderIndex: listIndex),//Text(formatedDate), 
                  tileColor: Colors.blueGrey.shade100           
                ),
              ),
            );
          }
        );
      }
    );
  }
}



class ReminderImageView extends StatelessWidget {
  final int reminderIndex;
  const ReminderImageView({required this.reminderIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final reminder = appState.sortedReminders[reminderIndex];
    if(reminder.hasImage){
      return FutureBuilder<Uint8List?>(
        future: appState.getReminderImage(reminderId: reminder.id),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if(snapshot.hasData){return Image.memory(snapshot.data!);} 
              else{return const Center(child: Icon(Icons.error));}
          }
        }
      );
    }
    else{return const SizedBox();}
  }
}