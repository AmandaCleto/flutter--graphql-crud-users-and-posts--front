import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/hive/boxes_enum.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConfigHive {
  static Future<HiveStore?> openHiveBox(context, clientNotifier) async {
    try {
      await HiveStore.openBox(EBoxesLabel.users.message);

      HiveStore store = await HiveStore.open(
        boxName: EBoxesLabel.users.message,
      );

      return Future.value(store);
    } catch (e) {
      clientNotifier = null;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: Text(EMessages.errorHive.message),
          );
        },
      );

      return Future.value(null);
    }
  }
}
