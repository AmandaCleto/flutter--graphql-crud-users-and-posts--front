import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';
import 'package:graphql_crud_users/shared/components/button_gradient_widget.dart';
import 'package:graphql_crud_users/shared/components/text_input_widget.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/views/post_writing/components/select_widget.dart';
import 'package:graphql_crud_users/views/post_writing/post_writing_controller.dart';
import 'package:graphql_crud_users/views/post_writing/post_writing_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class PostWritingView extends StatefulWidget {
  const PostWritingView({Key? key}) : super(key: key);

  @override
  State<PostWritingView> createState() => _PostWritingViewState();
}

class _PostWritingViewState extends State<PostWritingView>
    with PostWritingMixin {
  final postTitleTE = TextEditingController();
  final contentTitleTE = TextEditingController();
  final firstNameTitleTE = TextEditingController();
  final lastNameTitleTE = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _postWritingController = PostWritingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST WRITING'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(20.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(configurationRoute);
            },
          )
        ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Post',
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontSize: FontSizesTheme.title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextInputWidget(
                      maxLength: 50,
                      textController: postTitleTE,
                      hintText: 'Title',
                    ),
                    const SizedBox(height: 20.0),
                    TextInputWidget(
                      maxLength: 250,
                      textController: contentTitleTE,
                      hintText: 'Content',
                    ),
                    const SizedBox(height: 60.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SelectWidget(
                        callbackValueWhenSelectFn: (optionSelected, authorId) {
                          if (optionSelected != null) {
                            firstNameTitleTE.text =
                                optionSelected.split(' ').first;
                            lastNameTitleTE.text =
                                optionSelected.split(' ').last;

                            _postWritingController.setNewValue = authorId;
                          }
                        },
                      ),
                    ),
                    const Text(
                      'Author',
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontSize: FontSizesTheme.title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ValueListenableBuilder<String>(
                      valueListenable: _postWritingController,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            TextInputWidget.onlyOneWordAllowed(
                              maxLength: 50,
                              textController: firstNameTitleTE,
                              hintText: 'First Name',
                              readonly: value.isNotEmpty,
                            ),
                            const SizedBox(height: 20.0),
                            TextInputWidget.onlyOneWordAllowed(
                              maxLength: 50,
                              textController: lastNameTitleTE,
                              hintText: 'Last Name',
                              readonly: value.isNotEmpty,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ButtonGradientWidget(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var client = context.read<ValueNotifier<GraphQLClient>?>()!;
                    String authorId;

                    if (_postWritingController.value.isEmpty) {
                      authorId = await createAuthor(
                        client: client,
                        firstName: firstNameTitleTE.text,
                        lastName: lastNameTitleTE.text,
                      );
                    } else {
                      authorId = _postWritingController.value;
                    }

                    await createPost(
                      client: client,
                      title: postTitleTE.text,
                      content: contentTitleTE.text,
                      authorId: authorId,
                    ).then((value) => Navigator.pop(context, true));
                  }
                },
                text: 'Create',
                width: context.percentWidth(0.3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
