import 'package:flutter/cupertino.dart';

class SelectController extends ValueNotifier<String?> {
  SelectController() : super(null);

  setValue(String newValue) => value = newValue;
}
