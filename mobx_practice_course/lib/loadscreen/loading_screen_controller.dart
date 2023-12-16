import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadScreenController{
  final CloseLoadingScreen closeScreen; final UpdateLoadingScreen updateScreen;
  const LoadScreenController({required this.closeScreen, required this.updateScreen});
}