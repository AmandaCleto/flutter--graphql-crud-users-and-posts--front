import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';

class GradientDecoration {
  static final bluePinkGradientDecoration = BoxDecoration(
    gradient: bluePinkGradient,
    borderRadius: BorderRadius.circular(100.0),
    boxShadow: const [
      BoxShadow(
        offset: Offset(1.0, 4.0),
        color: Colors.black38,
        blurStyle: BlurStyle.normal,
        spreadRadius: 0.2,
        blurRadius: 4.0,
      ),
    ],
  );

  static const bluePinkGradient = LinearGradient(
    colors: [
      ColorsTheme.blueLight,
      ColorsTheme.pinkLight,
    ],
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 0.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
}
