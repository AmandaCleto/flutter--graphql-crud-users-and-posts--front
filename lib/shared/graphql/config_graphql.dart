import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/env.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_crud_users/shared/hive/config_hive.dart';

class ConfigGraphQl {
  static ValueNotifier<GraphQLClient>? initializeGQLClient(
    context, {
    required ValueNotifier<GraphQLClient>? clientNotifier,
  }) {
    final HttpLink httpLink = HttpLink(getEnv('API_HTTP_LINK'));
    HiveStore? hiveStore;

    ConfigHive.openHiveBox(context, clientNotifier)
        .then((value) => hiveStore = value);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: hiveStore),
      ),
    );

    clientNotifier = ValueNotifier<GraphQLClient>(client.value);

    return clientNotifier;
  }
}
