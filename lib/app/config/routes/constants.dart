import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ScreenArguments {
  ValueNotifier<GraphQLClient>? clientNotifier;

  ScreenArguments({
    this.clientNotifier,
  });
}

const String homeRoute = '/home';
const String welcomeRoute = '/splash-screen';
