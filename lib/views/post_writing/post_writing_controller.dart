import 'package:flutter/material.dart';

class PostWritingController extends ValueNotifier<String> {
  PostWritingController() : super("");

  set setNewValue(String newValue) => value = newValue;
}
