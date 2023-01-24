import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/graphql/config_graphql.dart';
import 'package:graphql_crud_users/views/home/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ValueNotifier<GraphQLClient>? clientNotifier;

  @override
  void initState() {
    clientNotifier = ConfigGraphQl.initializeGQLClient(
      context,
      clientNotifier: clientNotifier,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Users Crud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(
        clientNotifier: clientNotifier!,
      ),
    );
  }
}
