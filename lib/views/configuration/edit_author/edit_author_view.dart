import 'package:flutter/material.dart';

import 'edit_author_mixin.dart';

class EditAuthorView extends StatelessWidget with EditAuthorMixin {
  const EditAuthorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
