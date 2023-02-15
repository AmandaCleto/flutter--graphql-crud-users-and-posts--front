import 'package:flutter/material.dart';

class HomeController extends ValueNotifier<bool> {
  HomeController() : super(false);

  void turnHasDataOn() => value = true;
  void turnHasDataOff() => value = false;
}
