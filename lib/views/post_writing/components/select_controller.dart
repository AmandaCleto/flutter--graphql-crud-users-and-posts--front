import 'package:flutter/cupertino.dart';

class SelectController extends ValueNotifier<String?> {
  SelectController() : super(null);

  set setValue(String? newValue) => value = newValue;
}
