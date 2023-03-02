import 'package:flutter/material.dart';

mixin RefreshPageMixin<T extends StatefulWidget> on State<T> {
  Future<void> refreshPage() async {
    return Future<void>.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {});
    });
  }
}
