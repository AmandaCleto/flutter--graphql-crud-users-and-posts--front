import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Quicksand",
      colorSchemeSeed: const Color.fromARGB(255, 255, 39, 143),
      scaffoldBackgroundColor: ColorsTheme.secondary,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsTheme.primary,
        toolbarHeight: 90.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: FontSizesTheme.title,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: ColorsTheme.white,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorsTheme.blue,
        contentTextStyle: TextStyle(
          color: ColorsTheme.white,
          fontSize: FontSizesTheme.small,
        ),
      ),
      iconTheme: const IconThemeData(color: ColorsTheme.white, size: 24.0),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
          shadowColor: ColorsTheme.black,
          elevation: 10.0,
          minimumSize: const Size(160.0, 60.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      ),
    );
  }
}
