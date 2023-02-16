import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/graphql/config_graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ApplicationBindingProvider extends StatelessWidget {
  final Widget child;

  const ApplicationBindingProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient>? clientNotifier;

    return ListenableProvider(
      create: (context) => ConfigGraphQl.initializeGQLClient(
        context,
        clientNotifier: clientNotifier,
      ),
      child: child,
    );
  }
}
