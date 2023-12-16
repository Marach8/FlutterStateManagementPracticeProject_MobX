import 'package:flutter/material.dart';

typedef DialogOptions<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context, required String title, 
  required String content, required DialogOptions optionsBuilder,
  TextEditingController? controller
}){
  final options = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title), content: controller == null ? Text(content)
      : TextField(
        controller: controller, autocorrect: true, maxLines: null,
        keyboardType: TextInputType.text, keyboardAppearance: Brightness.dark,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Enter your Reminder here.', 
          prefix: Icon(Icons.edit)
        )
      ),
      actions: options.keys.map((optionsKey){
        final optionsValue = options[optionsKey];
        return TextButton(
          onPressed: (){
            if(optionsValue == null){Navigator.pop(context);}
            else {
              if(controller != null && optionsKey == 'Save'){Navigator.of(context).pop(controller.text);}
              else{Navigator.of(context).pop(optionsValue);}
            }
          },
          child: Text(optionsKey)
        );
      }).toList()
    )
  );
}


// Future<T?> showAddReminderDialog<T>(
//     BuildContext context, TextEditingController controller,
//     DialogOptions optionsBuilder
//   )
//   => showDialog<T?>(
//     context: context, 
//     builder: (context) {
//       final options = optionsBuilder();
//       return AlertDialog(
//         title: const Text('Add Remindder'),
//         content: TextField(
//           controller: controller, autocorrect: true, maxLines: null,
//           keyboardType: TextInputType.text, keyboardAppearance: Brightness.dark,
//         ),
//         actions: options.keys.map((optionsKey){
//           final optionsValue = options[optionsKey];
//           return TextButton(
//             onPressed: (){
//               if(optionsValue == null){Navigator.pop(context);}
//               else{Navigator.of(context).pop(optionsValue);}
//             },
//             child: Text(optionsKey)
//           );
//         }).toList()
//       );
//     }
//   );