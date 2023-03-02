import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';
import 'package:graphql_crud_users/views/configuration/configuration_view.dart';
import 'package:graphql_crud_users/views/configuration/edit_author/edit_author_view.dart';
import 'package:graphql_crud_users/views/home/home_view.dart';
import 'package:graphql_crud_users/views/post_writing/post_writing_view.dart';
import 'package:graphql_crud_users/views/welcome/welcome_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const WelcomeView();
          },
        );
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const HomeView();
          },
        );
      case postWritingRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const PostWritingView();
          },
        );

      case configurationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const ConfigurationView();
          },
        );

      case configurationEditRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            ScreenArguments arguments = args as ScreenArguments;
            return EditAuthorView(
              firstName: arguments.firstName,
              lastName: arguments.lastName,
              authorId: arguments.authorId,
            );
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WelcomeView(),
        );
    }
  }
}
