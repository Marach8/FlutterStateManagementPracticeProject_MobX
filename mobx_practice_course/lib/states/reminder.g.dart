// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Reminder on _Reminder, Store {
  late final _$textAtom = Atom(name: '_Reminder.text', context: context);

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  late final _$isDoneAtom = Atom(name: '_Reminder.isDone', context: context);

  @override
  bool get isDone {
    _$isDoneAtom.reportRead();
    return super.isDone;
  }

  @override
  set isDone(bool value) {
    _$isDoneAtom.reportWrite(value, super.isDone, () {
      super.isDone = value;
    });
  }

  late final _$hasImageAtom =
      Atom(name: '_Reminder.hasImage', context: context);

  @override
  bool get hasImage {
    _$hasImageAtom.reportRead();
    return super.hasImage;
  }

  @override
  set hasImage(bool value) {
    _$hasImageAtom.reportWrite(value, super.hasImage, () {
      super.hasImage = value;
    });
  }

  late final _$imageDataAtom =
      Atom(name: '_Reminder.imageData', context: context);

  @override
  Uint8List? get imageData {
    _$imageDataAtom.reportRead();
    return super.imageData;
  }

  @override
  set imageData(Uint8List? value) {
    _$imageDataAtom.reportWrite(value, super.imageData, () {
      super.imageData = value;
    });
  }

  late final _$imageIsLoadingAtom =
      Atom(name: '_Reminder.imageIsLoading', context: context);

  @override
  bool get imageIsLoading {
    _$imageIsLoadingAtom.reportRead();
    return super.imageIsLoading;
  }

  @override
  set imageIsLoading(bool value) {
    _$imageIsLoadingAtom.reportWrite(value, super.imageIsLoading, () {
      super.imageIsLoading = value;
    });
  }

  @override
  String toString() {
    return '''
text: ${text},
isDone: ${isDone},
hasImage: ${hasImage},
imageData: ${imageData},
imageIsLoading: ${imageIsLoading}
    ''';
  }
}
