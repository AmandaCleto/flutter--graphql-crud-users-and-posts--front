// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/components/alert_dialog_widget.dart';
import 'package:graphql_crud_users/shared/components/button_gradient_widget.dart';
import 'package:graphql_crud_users/shared/components/text_input_widget.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_author_mixin.dart';

class EditAuthorView extends StatefulWidget {
  final String? firstName, lastName, authorId;

  const EditAuthorView({
    Key? key,
    required this.authorId,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  State<EditAuthorView> createState() => _EditAuthorViewState();
}

class _EditAuthorViewState extends State<EditAuthorView> with EditAuthorMixin {
  final firstNameTE = TextEditingController();
  final lastNameTE = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameTE.text = widget.firstName ?? "";
    lastNameTE.text = widget.lastName ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURATION'),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Authors',
                        style: TextStyle(
                          color: ColorsTheme.white,
                          fontSize: FontSizesTheme.title,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextInputWidget.onlyOneWordAllowed(
                      maxLength: 50,
                      textController: firstNameTE,
                      hintText: 'First Name',
                      readonly: false,
                    ),
                    const SizedBox(height: 20.0),
                    TextInputWidget.onlyOneWordAllowed(
                      maxLength: 50,
                      textController: lastNameTE,
                      hintText: 'Last Name',
                      readonly: false,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonGradientWidget(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var client =
                          context.read<ValueNotifier<GraphQLClient>?>()!;

                      await editAuthor(
                        authorId: widget.authorId!,
                        client: client,
                        firstName: firstNameTE.text,
                        lastName: lastNameTE.text,
                      )
                          .then(
                        (value) => Navigator.pop(context, value),
                      )
                          .catchError(
                        (onError) {
                          showDialog(
                            context: context,
                            builder: (BuildContext _) {
                              return AlertDialogWidget.error(
                                title: 'Attention!',
                                content: onError.toString(),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                  text: 'Update',
                  width: context.percentWidth(0.30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
