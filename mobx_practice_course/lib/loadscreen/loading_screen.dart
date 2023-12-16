import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx_practice_course/loadscreen/loading_screen_controller.dart';

class LoadingScreen{
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadScreenController? _controller;
  void showOverlay({required BuildContext context, required String text}){
    if(_controller?.updateScreen(text) ?? false){return;}
    else{_controller = _showOverlay(context: context, text: text);}
  }

  void hideOverlay(){_controller?.closeScreen(); _controller = null;}
  
  LoadScreenController _showOverlay({required BuildContext context, required String text}){
    final streamText = StreamController<String>();
    streamText.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context){
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8, maxHeight: size.height * 0.8, minWidth: size.width * 0.5
              ), 
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(backgroundColor: Colors.blue),
                      const SizedBox(height: 10),
                      StreamBuilder(
                        stream: streamText.stream,
                        builder: (context, snapshot){
                          if(snapshot.hasData){return Text(snapshot.data!, textAlign: TextAlign.center,);}
                          else{return const SizedBox.shrink();}
                        }
                      )
                    ]
                  )
                )
              )
            )
          )
        );
      }
    );
    state.insert(overlay);
    return LoadScreenController(
      closeScreen: () {streamText.close(); overlay.remove(); return true;},
      updateScreen: (text){streamText.add(text); return true;}
    );
  }
}