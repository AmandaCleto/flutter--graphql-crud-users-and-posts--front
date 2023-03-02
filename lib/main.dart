import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_crud_users/app/app.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await initHiveForFlutter();

  await dotenv.load(fileName: ".env");

  runApp(const App());
}
