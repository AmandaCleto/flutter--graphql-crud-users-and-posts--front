import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_crud_users/shared/themes/gradient_decoration.dart';

class ButtonGradientWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double width;

  final bool _hasIcon;

  const ButtonGradientWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
  }) : _hasIcon = false;

  const ButtonGradientWidget.iconWrite({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
  }) : _hasIcon = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          padding: const EdgeInsets.all(0.0),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: GradientDecoration.bluePinkGradient,
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _hasIcon,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.border_color_rounded,
                      color: ColorsTheme.blue,
                    ),
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: FontSizesTheme.bodyText,
                    color: ColorsTheme.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
