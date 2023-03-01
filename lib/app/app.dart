import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';
import 'package:graphql_crud_users/app/config/routes/routes.dart';
import 'package:graphql_crud_users/shared/themes/theme.dart';

import 'config/aplication_binding/application_binding_provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ApplicationBindingProvider(
        child: MaterialApp(
          title: 'GraphQL Users and Posts Crud',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: welcomeRoute,
        ),
      ),
    );
  }
}
