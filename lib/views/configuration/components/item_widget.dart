import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/typedefs/typedefs.dart';

class ItemWidget extends StatelessWidget {
  final String firstName, lastName;
  final FutureCallback editCallback;
  final FutureCallback deleteCallback;

  const ItemWidget({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.editCallback,
    required this.deleteCallback,
  }) : super(key: key);

  final TextStyle _textStyle = const TextStyle(
    color: ColorsTheme.blue,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorsTheme.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(firstName, style: _textStyle),
              const SizedBox(width: 20.0),
              Text(lastName, style: _textStyle),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: ColorsTheme.blue,
                splashRadius: 20.0,
                onPressed: () {
                  editCallback();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: ColorsTheme.primary,
                splashRadius: 20.0,
                onPressed: () {
                  deleteCallback();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
