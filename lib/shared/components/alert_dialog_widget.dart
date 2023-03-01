// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_crud_users/shared/themes/gradient_decoration.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title, content, confirmationButtonText, denialButtonText;

  const AlertDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.denialButtonText,
    required this.confirmationButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      titleTextStyle: const TextStyle(
        fontSize: FontSizesTheme.subtitle,
        color: ColorsTheme.black,
        fontWeight: FontWeight.bold,
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: FontSizesTheme.bodyText,
          color: ColorsTheme.black,
        ),
      ),
      backgroundColor: ColorsTheme.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
      insetPadding: const EdgeInsets.all(50.0),
      buttonPadding: const EdgeInsets.all(20.0),
      contentPadding: const EdgeInsets.only(
        top: 0.0,
        bottom: 60.0,
        left: 20.0,
        right: 20.0,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      alignment: Alignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.percentWidth(0.3),
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  denialButtonText,
                  style: const TextStyle(
                    fontSize: FontSizesTheme.bodyText,
                    color: ColorsTheme.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: context.percentWidth(0.30),
              height: 60.0,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
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
                    child: Text(
                      confirmationButtonText,
                      style: const TextStyle(
                        fontSize: FontSizesTheme.bodyText,
                        color: ColorsTheme.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
