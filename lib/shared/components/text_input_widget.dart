import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';

class TextInputWidget extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final TextEditingController textController;
  final int maxLength;
  final bool readonly;

  final bool _onlyOneWord;

  const TextInputWidget({
    Key? key,
    this.errorText,
    required this.hintText,
    required this.textController,
    required this.maxLength,
  })  : _onlyOneWord = false,
        readonly = false,
        super(key: key);

  const TextInputWidget.onlyOneWordAllowed({
    Key? key,
    this.errorText,
    required this.hintText,
    required this.textController,
    required this.maxLength,
    required this.readonly,
  })  : _onlyOneWord = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      inputFormatters: [
        _onlyOneWord
            ? FilteringTextInputFormatter.deny(RegExp(r'\s'))
            : FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]"))
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      maxLength: maxLength,
      readOnly: readonly,
      decoration: InputDecoration(
        fillColor:
            readonly ? ColorsTheme.white.withOpacity(0.4) : ColorsTheme.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        filled: true,
        hintText: hintText,
        errorText: errorText,
        helperText: null,
        counterText: "",
      ),
    );
  }
}
